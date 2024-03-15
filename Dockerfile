# Stage 1: Build Flask application
FROM python:3.9-slim AS builder

LABEL maintainer="kennymarioantonio@gmail.com"

WORKDIR /app

COPY requirements.txt /app

# Install Flask dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask application code
COPY . /app

# Stage 2: Final image with Redis and Flask application
FROM python:3.9-slim

#Set redis HOST env
ENV REDIS_HOST=localhost

# Install Redis
RUN apt-get update && apt-get install -y redis-server && apt-get clean

# Copy only the necessary files from the previous stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /app /app

#Fix flas packege
RUN pip uninstall -y flask && pip install flask

# Expose Flask port
EXPOSE 5000

# Set working directory
WORKDIR /app

# Command to run the Flask application and start redis

CMD ["sh", "-c", "redis-server --daemonize yes && flask run --host=0.0.0.0"]
