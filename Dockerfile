# Use a imagem oficial do Nginx como base
FROM nginx:alpine

# Informações do mantenedor
LABEL maintainer="SD-Resolv <contato@sd-resolv.com.br>"
LABEL description="Website oficial da SD-Resolv - Soluções Financeiras e Jurídicas"
LABEL version="1.0"

# Remove o conteúdo padrão do Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia os arquivos da aplicação para o diretório do Nginx
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY fotoSdResolve.jpeg /usr/share/nginx/html/
COPY README.md /usr/share/nginx/html/

# Cria uma configuração customizada do Nginx
RUN echo 'server {' > /etc/nginx/conf.d/default.conf && \
    echo '    listen 80;' >> /etc/nginx/conf.d/default.conf && \
    echo '    listen [::]:80;' >> /etc/nginx/conf.d/default.conf && \
    echo '    server_name localhost;' >> /etc/nginx/conf.d/default.conf && \
    echo '    root /usr/share/nginx/html;' >> /etc/nginx/conf.d/default.conf && \
    echo '    index index.html;' >> /etc/nginx/conf.d/default.conf && \
    echo '' >> /etc/nginx/conf.d/default.conf && \
    echo '    # Configurações de cache para assets estáticos' >> /etc/nginx/conf.d/default.conf && \
    echo '    location ~* \.(css|js|jpg|jpeg|png|gif|ico|svg)$ {' >> /etc/nginx/conf.d/default.conf && \
    echo '        expires 1y;' >> /etc/nginx/conf.d/default.conf && \
    echo '        add_header Cache-Control "public, immutable";' >> /etc/nginx/conf.d/default.conf && \
    echo '    }' >> /etc/nginx/conf.d/default.conf && \
    echo '' >> /etc/nginx/conf.d/default.conf && \
    echo '    # Configurações de segurança' >> /etc/nginx/conf.d/default.conf && \
    echo '    add_header X-Frame-Options "SAMEORIGIN" always;' >> /etc/nginx/conf.d/default.conf && \
    echo '    add_header X-Content-Type-Options "nosniff" always;' >> /etc/nginx/conf.d/default.conf && \
    echo '    add_header X-XSS-Protection "1; mode=block" always;' >> /etc/nginx/conf.d/default.conf && \
    echo '    add_header Referrer-Policy "no-referrer-when-downgrade" always;' >> /etc/nginx/conf.d/default.conf && \
    echo '' >> /etc/nginx/conf.d/default.conf && \
    echo '    # Compressão gzip' >> /etc/nginx/conf.d/default.conf && \
    echo '    gzip on;' >> /etc/nginx/conf.d/default.conf && \
    echo '    gzip_vary on;' >> /etc/nginx/conf.d/default.conf && \
    echo '    gzip_min_length 1024;' >> /etc/nginx/conf.d/default.conf && \
    echo '    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;' >> /etc/nginx/conf.d/default.conf && \
    echo '' >> /etc/nginx/conf.d/default.conf && \
    echo '    # Configuração para SPA (Single Page Application)' >> /etc/nginx/conf.d/default.conf && \
    echo '    location / {' >> /etc/nginx/conf.d/default.conf && \
    echo '        try_files $uri $uri/ /index.html;' >> /etc/nginx/conf.d/default.conf && \
    echo '    }' >> /etc/nginx/conf.d/default.conf && \
    echo '' >> /etc/nginx/conf.d/default.conf && \
    echo '    # Logs de acesso e erro' >> /etc/nginx/conf.d/default.conf && \
    echo '    access_log /var/log/nginx/access.log;' >> /etc/nginx/conf.d/default.conf && \
    echo '    error_log /var/log/nginx/error.log;' >> /etc/nginx/conf.d/default.conf && \
    echo '}' >> /etc/nginx/conf.d/default.conf

# Define as permissões corretas
RUN chmod -R 755 /usr/share/nginx/html

# Expõe a porta 80
EXPOSE 80

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]

# Health check para verificar se o container está funcionando
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1
