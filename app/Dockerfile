# Base Image
FROM python:3.8-slim-buster

# Dockerfile maintainer
LABEL maintainer="Faith Kovi"

# Create a working directory
WORKDIR /app

# Copy requirements.txt
COPY requirements.txt requirements.txt

# Install all requirements
RUN pip3 install -r requirements.txt

# Copy source code to WORKDIR
COPY . .

# Expose container port
EXPOSE 5000

# Add bash script for running application
ADD script.sh /usr/src/script.sh

# Make bash script executable
RUN ["chmod", "+x", "/usr/src/script.sh"]

# Run the bash script
CMD [ "./script.sh" ]