"""
Base API Client - Python implementation
Provides standardized HTTP communication across Python services
"""

import asyncio
import json
import logging
from abc import ABC, abstractmethod
from datetime import datetime
from typing import Any, Dict, Optional, Type, TypeVar, Union
from urllib.parse import urljoin, urlencode

import aiohttp
from aiohttp import ClientSession, ClientTimeout, ClientError

from ..errors.app_error import AppError
from ..logging.logger_service import LoggerService, LogLevel

T = TypeVar('T')


class BaseApiClient(ABC):
    """Base API Client for standardized HTTP communication"""
    
    def __init__(
        self,
        base_url: str,
        default_headers: Dict[str, str],
        timeout: int = 30,
        session: Optional[ClientSession] = None
    ):
        self.base_url = base_url.rstrip('/')
        self.default_headers = default_headers
        self.timeout = ClientTimeout(total=timeout)
        self._session = session
        self._logger = LoggerService()

    async def __aenter__(self):
        if self._session is None:
            self._session = ClientSession(
                timeout=self.timeout,
                headers=self.default_headers
            )
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        if self._session:
            await self._session.close()

    @property
    def session(self) -> ClientSession:
        """Get or create session"""
        if self._session is None:
            self._session = ClientSession(
                timeout=self.timeout,
                headers=self.default_headers
            )
        return self._session

    async def get(
        self,
        endpoint: str,
        headers: Optional[Dict[str, str]] = None,
        params: Optional[Dict[str, Any]] = None,
        response_type: Optional[Type[T]] = None
    ) -> Union[T, Dict[str, Any]]:
        """GET request with standardized error handling"""
        url = self._build_url(endpoint)
        request_headers = self._build_headers(headers)
        
        self._logger.log(
            level=LogLevel.INFO,
            message=f"GET {url}",
            metadata={'params': params},
            service='api_client'
        )
        
        try:
            async with self.session.get(
                url,
                headers=request_headers,
                params=params
            ) as response:
                response_data = await self._handle_response(response)
                
                if response_type:
                    return response_type.from_dict(response_data)
                return response_data
                
        except ClientError as e:
            raise AppError(
                code='NETWORK_001',
                message='Network connection failed',
                details={'original_error': str(e)}
            )
        except Exception as e:
            raise AppError(
                code='UNKNOWN_001',
                message='Unknown error occurred',
                details={'original_error': str(e)}
            )

    async def post(
        self,
        endpoint: str,
        body: Optional[Any] = None,
        headers: Optional[Dict[str, str]] = None,
        params: Optional[Dict[str, Any]] = None,
        response_type: Optional[Type[T]] = None
    ) -> Union[T, Dict[str, Any]]:
        """POST request with standardized error handling"""
        url = self._build_url(endpoint)
        request_headers = self._build_headers(headers)
        json_body = body if body is not None else {}
        
        self._logger.log(
            level=LogLevel.INFO,
            message=f"POST {url}",
            metadata={'body': body, 'params': params},
            service='api_client'
        )
        
        try:
            async with self.session.post(
                url,
                headers=request_headers,
                json=json_body,
                params=params
            ) as response:
                response_data = await self._handle_response(response)
                
                if response_type:
                    return response_type.from_dict(response_data)
                return response_data
                
        except ClientError as e:
            raise AppError(
                code='NETWORK_001',
                message='Network connection failed',
                details={'original_error': str(e)}
            )
        except Exception as e:
            raise AppError(
                code='UNKNOWN_001',
                message='Unknown error occurred',
                details={'original_error': str(e)}
            )

    async def put(
        self,
        endpoint: str,
        body: Optional[Any] = None,
        headers: Optional[Dict[str, str]] = None,
        params: Optional[Dict[str, Any]] = None,
        response_type: Optional[Type[T]] = None
    ) -> Union[T, Dict[str, Any]]:
        """PUT request with standardized error handling"""
        url = self._build_url(endpoint)
        request_headers = self._build_headers(headers)
        json_body = body if body is not None else {}
        
        self._logger.log(
            level=LogLevel.INFO,
            message=f"PUT {url}",
            metadata={'body': body, 'params': params},
            service='api_client'
        )
        
        try:
            async with self.session.put(
                url,
                headers=request_headers,
                json=json_body,
                params=params
            ) as response:
                response_data = await self._handle_response(response)
                
                if response_type:
                    return response_type.from_dict(response_data)
                return response_data
                
        except ClientError as e:
            raise AppError(
                code='NETWORK_001',
                message='Network connection failed',
                details={'original_error': str(e)}
            )
        except Exception as e:
            raise AppError(
                code='UNKNOWN_001',
                message='Unknown error occurred',
                details={'original_error': str(e)}
            )

    async def delete(
        self,
        endpoint: str,
        headers: Optional[Dict[str, str]] = None,
        params: Optional[Dict[str, Any]] = None,
        response_type: Optional[Type[T]] = None
    ) -> Union[T, Dict[str, Any]]:
        """DELETE request with standardized error handling"""
        url = self._build_url(endpoint)
        request_headers = self._build_headers(headers)
        
        self._logger.log(
            level=LogLevel.INFO,
            message=f"DELETE {url}",
            metadata={'params': params},
            service='api_client'
        )
        
        try:
            async with self.session.delete(
                url,
                headers=request_headers,
                params=params
            ) as response:
                response_data = await self._handle_response(response)
                
                if response_type:
                    return response_type.from_dict(response_data)
                return response_data
                
        except ClientError as e:
            raise AppError(
                code='NETWORK_001',
                message='Network connection failed',
                details={'original_error': str(e)}
            )
        except Exception as e:
            raise AppError(
                code='UNKNOWN_001',
                message='Unknown error occurred',
                details={'original_error': str(e)}
            )

    def _build_url(self, endpoint: str) -> str:
        """Build full URL from base URL and endpoint"""
        if endpoint.startswith('/'):
            endpoint = endpoint[1:]
        return f"{self.base_url}/{endpoint}"

    def _build_headers(self, custom_headers: Optional[Dict[str, str]] = None) -> Dict[str, str]:
        """Build headers by merging default and custom headers"""
        headers = self.default_headers.copy()
        
        if custom_headers:
            headers.update(custom_headers)
        
        # Ensure content-type is set
        if 'Content-Type' not in headers:
            headers['Content-Type'] = 'application/json'
        
        return headers

    async def _handle_response(self, response: aiohttp.ClientResponse) -> Dict[str, Any]:
        """Handle HTTP response and convert errors to AppError"""
        response_text = await response.text()
        
        self._logger.log(
            level=LogLevel.INFO,
            message=f"Response {response.status}",
            metadata={'response_body': response_text[:1000]},  # Truncate for logging
            service='api_client'
        )
        
        if 200 <= response.status < 300:
            try:
                return json.loads(response_text) if response_text else {}
            except json.JSONDecodeError as e:
                raise AppError(
                    code='PARSE_001',
                    message='Failed to parse response',
                    details={'original_error': str(e), 'response_body': response_text}
                )
        else:
            error_code = f'HTTP_{response.status}'
            error_message = f'HTTP Error {response.status}'
            error_details = {'response_body': response_text}
            
            try:
                error_data = json.loads(response_text)
                if isinstance(error_data, dict) and 'error' in error_data:
                    error_info = error_data['error']
                    error_code = error_info.get('code', error_code)
                    error_message = error_info.get('message', error_message)
                    error_details = error_info.get('details', error_details)
            except json.JSONDecodeError:
                pass  # Use default error info
            
            raise AppError(
                code=error_code,
                message=error_message,
                details=error_details
            )

    async def close(self):
        """Close the session"""
        if self._session:
            await self._session.close()


class ExtendedApiClient(BaseApiClient):
    """Extended API Client specifically for Extended Exchange"""
    
    def __init__(
        self,
        base_url: str,
        api_key: str,
        timeout: int = 30,
        session: Optional[ClientSession] = None
    ):
        super().__init__(
            base_url=base_url,
            default_headers={
                'Content-Type': 'application/json',
                'X-API-Key': api_key,
            },
            timeout=timeout,
            session=session
        )
        self.api_key = api_key

    async def get_market_data(self, symbol: str) -> Dict[str, Any]:
        """Get market data for a symbol"""
        return await self.get(
            '/market/data',
            params={'symbol': symbol}
        )

    async def place_order(self, order_data: Dict[str, Any]) -> Dict[str, Any]:
        """Place a new order"""
        return await self.post('/orders', body=order_data)

    async def get_order_history(self) -> List[Dict[str, Any]]:
        """Get order history"""
        response = await self.get('/orders/history')
        return response.get('orders', [])

    async def get_balance(self) -> Dict[str, Any]:
        """Get account balance"""
        return await self.get('/account/balance')

    async def cancel_order(self, order_id: str) -> Dict[str, Any]:
        """Cancel an order"""
        return await self.delete(f'/orders/{order_id}')

    async def get_order_status(self, order_id: str) -> Dict[str, Any]:
        """Get order status"""
        return await self.get(f'/orders/{order_id}')