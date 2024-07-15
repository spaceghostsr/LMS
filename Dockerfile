# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Install dependencies required for psycopg2
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Patch flask_login to use the safe_str_cmp from our patch
RUN echo "import hmac\n\ndef safe_str_cmp(a, b):\n    return hmac.compare_digest(a, b)" > /usr/local/lib/python3.12/site-packages/flask_login/safe_cmp_patch.py
RUN sed -i "s/from werkzeug.security import safe_str_cmp/from flask_login.safe_cmp_patch import safe_str_cmp/g" /usr/local/lib/python3.12/site-packages/flask_login/utils.py

# Expose the port the app runs on
EXPOSE 5001

# Set environment variables
ENV FLASK_APP=run.py
ENV FLASK_DEBUG=1

# Run the application
CMD ["flask", "run", "--host=0.0.0.0", "--port=5001"]
