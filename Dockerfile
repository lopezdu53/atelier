# --- Base Image with Node.js ---
FROM node:20-bullseye-slim

# Instalar dependencias esenciales del sistema
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Primero copiamos TODO el contenido del repositorio
COPY . .

# Ahora instalamos las dependencias globales del proyecto
RUN npm install

# Compilar si el script existe en la raíz
RUN npm run build --if-present

# Exponer el puerto por defecto
EXPOSE 3000

# Iniciar la aplicación
CMD ["npm", "install"]
