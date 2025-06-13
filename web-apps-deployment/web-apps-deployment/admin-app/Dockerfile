# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements.txt
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app source code
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Set environment variables
ENV PORT=8080
ENV FLASK_APP=main.py

# Run the app with Gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
