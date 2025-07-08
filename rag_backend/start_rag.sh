#!/bin/bash
# Enhanced RAG System Startup Script

echo "🚀 Starting Enhanced Multi-Platform RAG System..."

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install/update requirements
pip install -r requirements.txt

# Load environment variables
export $(cat .env | xargs)

# Start the enhanced RAG server
echo "Starting RAG server on port $PORT..."
python main.py

# Keep script running
wait
