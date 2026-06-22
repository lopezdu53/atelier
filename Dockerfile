# --- Base Image with Node.js ---
FROM node:20-bullseye-slim

# Instalar ffmpeg y dependencias necesarias para SQLite y herramientas de compilación
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# CAMBIO AQUÍ: Usamos 'npm install' en lugar de 'npm ci'
RUN npm install

# Copiar el resto del código
COPY . .

# Compilar el Frontend si aplica
RUN npm run build --if-present

# Exponer el puerto
EXPOSE 3000

# Comando para arrancar la aplicación
CMD ["npm", "install"]
