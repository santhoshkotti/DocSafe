# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container to /app
WORKDIR /app

# Install Tesseract OCR and any other system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add the current directory contents into the container at /app
ADD . /app

# Update and install python3-opencv
RUN apt-get update && apt-get install -y python3-opencv

# Install any needed Python packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Create the directory for uploaded files
RUN mkdir -p /app/imgs

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME World

# Example of passing an environment variable for the Excel file path
ENV EXCEL_FILE_PATH=/app/data/governmentdetails.xlsx

# Run app.py when the container launches
CMD ["python", "app.py"]
