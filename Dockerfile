# Use Python 3.10 to avoid compatibility issues
FROM python:3.10

# Set working directory
WORKDIR /data

# Install required system dependencies
RUN apt-get update && apt-get install -y python3-distutils python3-setuptools

# Install Django directly
RUN pip install --upgrade pip setuptools wheel
RUN pip install django==3.2

# Copy the entire project into the container
COPY . .

# Ensure permissions are correct
RUN chmod +x manage.py

# Run database migrations (if they fail, it won't stop the build)
RUN python manage.py migrate || echo "Migration failed, skipping..."

# Expose port 8000 for Django
EXPOSE 8000

# Command to start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

