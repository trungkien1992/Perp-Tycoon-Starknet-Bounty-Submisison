"""
Logger Service - Python implementation
Centralized logging service for Python applications
"""

import json
import logging
import os
import uuid
from datetime import datetime
from enum import Enum
from typing import Any, Dict, List, Optional, Union
from pathlib import Path


class LogLevel(Enum):
    """Log levels for filtering and categorizing logs"""
    DEBUG = "DEBUG"
    INFO = "INFO"
    WARNING = "WARNING"
    ERROR = "ERROR"
    CRITICAL = "CRITICAL"
    
    @property
    def priority(self) -> int:
        """Get numeric priority for level comparison"""
        priorities = {
            LogLevel.DEBUG: 0,
            LogLevel.INFO: 1,
            LogLevel.WARNING: 2,
            LogLevel.ERROR: 3,
            LogLevel.CRITICAL: 4,
        }
        return priorities[self]


class LoggerService:
    """Logger service for centralized logging across the application"""
    
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance._initialize()
        return cls._instance
    
    def _initialize(self):
        """Initialize logger with default settings"""
        self._minimum_level = LogLevel.INFO
        self._enable_file_logging = True
        self._enable_console_logging = True
        self._log_file_path = ""
        self._log_buffer: List[Dict[str, Any]] = []
        self._max_buffer_size = 100
        
        # Set up Python logging
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
        self._python_logger = logging.getLogger('streetcred')
    
    def initialize(
        self,
        minimum_level: LogLevel = LogLevel.INFO,
        enable_file_logging: bool = True,
        enable_console_logging: bool = True,
        log_file_path: Optional[str] = None,
        max_buffer_size: int = 100,
    ):
        """Initialize the logger with configuration"""
        self._minimum_level = minimum_level
        self._enable_file_logging = enable_file_logging
        self._enable_console_logging = enable_console_logging
        self._max_buffer_size = max_buffer_size
        
        if log_file_path:
            self._log_file_path = log_file_path
        else:
            self._log_file_path = self._get_default_log_path()
        
        # Update Python logger level
        py_level = getattr(logging, minimum_level.value)
        self._python_logger.setLevel(py_level)
    
    def log(
        self,
        level: LogLevel,
        message: str,
        metadata: Optional[Dict[str, Any]] = None,
        service: Optional[str] = None,
        trace_id: Optional[str] = None,
        user_id: Optional[str] = None,
        exception: Optional[Exception] = None,
    ):
        """Log a message with specified level"""
        # Skip if level is below minimum
        if level.priority < self._minimum_level.priority:
            return
        
        log_entry = self._create_log_entry(
            level=level,
            message=message,
            metadata=metadata,
            service=service,
            trace_id=trace_id,
            user_id=user_id,
            exception=exception,
        )
        
        # Add to buffer
        self._log_buffer.append(log_entry)
        if len(self._log_buffer) > self._max_buffer_size:
            self._log_buffer.pop(0)
        
        # Output to console
        if self._enable_console_logging:
            self._log_to_console(log_entry)
        
        # Output to file
        if self._enable_file_logging and self._log_file_path:
            self._log_to_file(log_entry)
        
        # Send to centralized logging (placeholder)
        self._send_to_log_aggregator(log_entry)
    
    def debug(
        self,
        message: str,
        metadata: Optional[Dict[str, Any]] = None,
        service: Optional[str] = None,
        trace_id: Optional[str] = None,
    ):
        """Log debug message"""
        self.log(
            level=LogLevel.DEBUG,
            message=message,
            metadata=metadata,
            service=service,
            trace_id=trace_id,
        )
    
    def info(
        self,
        message: str,
        metadata: Optional[Dict[str, Any]] = None,
        service: Optional[str] = None,
        trace_id: Optional[str] = None,
    ):
        """Log info message"""
        self.log(
            level=LogLevel.INFO,
            message=message,
            metadata=metadata,
            service=service,
            trace_id=trace_id,
        )
    
    def warning(
        self,
        message: str,
        metadata: Optional[Dict[str, Any]] = None,
        service: Optional[str] = None,
        trace_id: Optional[str] = None,
    ):
        """Log warning message"""
        self.log(
            level=LogLevel.WARNING,
            message=message,
            metadata=metadata,
            service=service,
            trace_id=trace_id,
        )
    
    def error(
        self,
        message: str,
        metadata: Optional[Dict[str, Any]] = None,
        service: Optional[str] = None,
        trace_id: Optional[str] = None,
        exception: Optional[Exception] = None,
    ):
        """Log error message"""
        self.log(
            level=LogLevel.ERROR,
            message=message,
            metadata=metadata,
            service=service,
            trace_id=trace_id,
            exception=exception,
        )
    
    def critical(
        self,
        message: str,
        metadata: Optional[Dict[str, Any]] = None,
        service: Optional[str] = None,
        trace_id: Optional[str] = None,
        exception: Optional[Exception] = None,
    ):
        """Log critical message"""
        self.log(
            level=LogLevel.CRITICAL,
            message=message,
            metadata=metadata,
            service=service,
            trace_id=trace_id,
            exception=exception,
        )
    
    def log_request(
        self,
        method: str,
        url: str,
        body: Any = None,
        trace_id: Optional[str] = None,
    ):
        """Log HTTP request"""
        self.log(
            level=LogLevel.INFO,
            message=f"{method} {url}",
            metadata={
                'type': 'http_request',
                'method': method,
                'url': url,
                'body': self._sanitize_body(body),
                'timestamp': datetime.now().isoformat(),
            },
            service='api_client',
            trace_id=trace_id,
        )
    
    def log_response(
        self,
        status_code: int,
        body: Any = None,
        trace_id: Optional[str] = None,
    ):
        """Log HTTP response"""
        level = LogLevel.ERROR if status_code >= 400 else LogLevel.INFO
        self.log(
            level=level,
            message=f"Response {status_code}",
            metadata={
                'type': 'http_response',
                'status_code': status_code,
                'body': self._sanitize_body(body),
                'timestamp': datetime.now().isoformat(),
            },
            service='api_client',
            trace_id=trace_id,
        )
    
    def get_recent_logs(self, limit: Optional[int] = None) -> List[Dict[str, Any]]:
        """Get recent logs"""
        logs = self._log_buffer.copy()
        if limit and len(logs) > limit:
            return logs[-limit:]
        return logs
    
    def get_logs_by_level(self, level: LogLevel) -> List[Dict[str, Any]]:
        """Get logs by level"""
        return [log for log in self._log_buffer if log['level'] == level.value]
    
    def get_logs_by_service(self, service: str) -> List[Dict[str, Any]]:
        """Get logs by service"""
        return [log for log in self._log_buffer if log['service'] == service]
    
    def get_logs_by_trace_id(self, trace_id: str) -> List[Dict[str, Any]]:
        """Get logs by trace ID"""
        return [log for log in self._log_buffer if log['trace_id'] == trace_id]
    
    def clear_logs(self):
        """Clear log buffer"""
        self._log_buffer.clear()
    
    def _create_log_entry(
        self,
        level: LogLevel,
        message: str,
        metadata: Optional[Dict[str, Any]] = None,
        service: Optional[str] = None,
        trace_id: Optional[str] = None,
        user_id: Optional[str] = None,
        exception: Optional[Exception] = None,
    ) -> Dict[str, Any]:
        """Create log entry"""
        entry = {
            'timestamp': datetime.now().isoformat(),
            'level': level.value,
            'message': message,
            'service': service or 'unknown',
            'trace_id': trace_id or self._generate_trace_id(),
            'user_id': user_id,
            'metadata': metadata or {},
        }
        
        if exception:
            entry['exception'] = {
                'type': type(exception).__name__,
                'message': str(exception),
                'stack_trace': str(exception.__traceback__) if exception.__traceback__ else None,
            }
        
        return entry
    
    def _log_to_console(self, log_entry: Dict[str, Any]):
        """Log to console with color formatting"""
        level = log_entry['level']
        message = log_entry['message']
        service = log_entry['service']
        timestamp = log_entry['timestamp']
        trace_id = log_entry['trace_id']
        
        # Color codes for different log levels
        colors = {
            'DEBUG': '\033[36m',    # Cyan
            'INFO': '\033[32m',     # Green
            'WARNING': '\033[33m',  # Yellow
            'ERROR': '\033[31m',    # Red
            'CRITICAL': '\033[35m', # Magenta
        }
        reset = '\033[0m'
        
        color = colors.get(level, '')
        output = f"{color}[{level}]{reset} [{timestamp}] [{service}] [{trace_id}] {message}"
        
        print(output)
        
        # Print metadata if present
        metadata = log_entry.get('metadata')
        if metadata:
            print(f"  Metadata: {json.dumps(metadata, indent=2)}")
        
        # Print exception if present
        exception = log_entry.get('exception')
        if exception:
            print(f"  Exception: {exception['type']} - {exception['message']}")
    
    def _log_to_file(self, log_entry: Dict[str, Any]):
        """Log to file"""
        try:
            # Ensure log directory exists
            log_path = Path(self._log_file_path)
            log_path.parent.mkdir(parents=True, exist_ok=True)
            
            # Write log entry as JSON
            with open(log_path, 'a', encoding='utf-8') as f:
                json.dump(log_entry, f, ensure_ascii=False)
                f.write('\n')
        except Exception as e:
            # If file logging fails, at least log to console
            print(f"Failed to write to log file: {e}")
    
    def _send_to_log_aggregator(self, log_entry: Dict[str, Any]):
        """Send to centralized log aggregator (placeholder)"""
        # This is a placeholder for future implementation
        # Could send to services like:
        # - Elasticsearch
        # - Splunk
        # - DataDog
        # - Custom log aggregation service
        pass
    
    def _generate_trace_id(self) -> str:
        """Generate a random trace ID"""
        return str(uuid.uuid4()).replace('-', '')[:16]
    
    def _get_default_log_path(self) -> str:
        """Get default log file path"""
        timestamp = int(datetime.now().timestamp())
        return f"logs/app_{timestamp}.log"
    
    def _sanitize_body(self, body: Any) -> Any:
        """Sanitize body for logging (remove sensitive data)"""
        if isinstance(body, dict):
            sanitized = {}
            for key, value in body.items():
                if self._is_sensitive_field(key):
                    sanitized[key] = '[REDACTED]'
                elif isinstance(value, dict):
                    sanitized[key] = self._sanitize_body(value)
                else:
                    sanitized[key] = value
            return sanitized
        
        if isinstance(body, str):
            # Check if it's JSON and sanitize
            try:
                parsed = json.loads(body)
                return json.dumps(self._sanitize_body(parsed))
            except json.JSONDecodeError:
                return body
        
        return body
    
    def _is_sensitive_field(self, field_name: str) -> bool:
        """Check if field contains sensitive data"""
        sensitive_fields = {
            'password',
            'secret',
            'token',
            'key',
            'private_key',
            'api_key',
            'auth_token',
            'authorization',
            'signature',
            'pin',
            'ssn',
            'credit_card',
            'card_number',
        }
        
        return any(field in field_name.lower() for field in sensitive_fields)


# Global logger instance
logger = LoggerService()