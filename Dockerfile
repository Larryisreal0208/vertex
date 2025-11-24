FROM python:3.9-slim

WORKDIR /app

# Install system dependencies for Playwright
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright browsers
RUN playwright install --with-deps chromium

COPY . .

# Set environment variables
ENV PORT=7860
ENV HEADLESS=true
ENV PYTHONUNBUFFERED=1
ENV ENABLE_AUTO_HARVEST=true

# Expose the port
EXPOSE 7860

# Run the application
CMD ["python", "main.py"]
