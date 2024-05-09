FROM python:3.13.0b1-slim

# Creates working directory and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application in working directory
COPY service ./service

# Create user theia and change ownership of app
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run the service on port 8080
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
