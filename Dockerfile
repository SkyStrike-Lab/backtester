# Use a lightweight official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Create non-root user (appuser:1000)
RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -s /bin/bash -m appuser

# Copy the rest of the application code and configure ownership
COPY --chown=appuser:appuser . .

# Ensure data and config directories exist and are writable
RUN mkdir -p /app/data /app/config && \
    chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port 5000 for the Flask server
EXPOSE 5000

# Define environment variables
ENV BASE_PATH=""

# Run app.py when the container launches
CMD ["python", "app.py"]

