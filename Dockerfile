# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Update all packages
RUN apt-get update && apt-get upgrade -y

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Install a production WSGI server
RUN pip install waitress Flask

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variables
ENV FLASK_APP=app.py:create_app

# Run the command to start the Flask application
CMD ["waitress-serve", "--call", "app:create_app"]
