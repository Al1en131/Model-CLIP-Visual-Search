FROM python:3.10-slim

WORKDIR /app

# Install dependensi sistem yang dibutuhkan Pillow & torch
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Copy dan install dependencies Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy semua file project
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
