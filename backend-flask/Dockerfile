# Use the official Python image as the base image
FROM python:3.10-slim-buster

# Set the working directory in the container
WORKDIR /backend-flask

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the dependencies
RUN pip3 install -r requirements.txt

# Copy the entire application into the container
COPY . .

# Copy the start.sh script into the container
COPY start.sh /start.sh

# Make the script executable
RUN chmod +x /start.sh

# Set environment variables
ENV FLASK_ENV=development

# Expose the port the application runs on
EXPOSE ${PORT}

# Set the default command to run the script
CMD ["/start.sh"]