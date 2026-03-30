# Imagen base oficial de nginx en su versión alpine (liviana y segura)
FROM nginx:alpine

# Elimina la página de bienvenida por defecto de nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia el archivo index.html al directorio de contenido estático de nginx
COPY index.html /usr/share/nginx/html/index.html

# Expone el puerto 80 para tráfico HTTP
EXPOSE 80

# Comando por defecto: arranca nginx en foreground (requerido por Docker)
CMD ["nginx", "-g", "daemon off;"]
