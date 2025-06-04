# Gunakan base image Python ringan
FROM python:3.10-slim

# Install git (dibutuhkan untuk clone dari GitHub)
RUN apt-get update && apt-get install -y git

# Set workdir
WORKDIR /app

# Salin file requirements.txt dan install dependenasi
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Salin semua file project
COPY . .

# Jalankan aplikasi Flask
CMD ["python", "app.py"]
