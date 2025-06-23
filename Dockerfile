# Etapa 1: Definir a imagem base
# Usamos nginx:alpine por ser uma imagem extremamente leve e eficiente para servir arquivos estáticos.
FROM nginx:alpine

# Etapa 2: Copiar os arquivos do site
# Copiamos os arquivos do seu projeto para o diretório padrão do Nginx onde ele serve o conteúdo.
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY fotoSdResolve.jpeg /usr/share/nginx/html/

# Etapa 3: Copiar a configuração personalizada do Nginx
# Isso garante que o Nginx escute na porta 5666.
COPY default.conf /etc/nginx/conf.d/default.conf

# Etapa 4: Expor a porta
# Informamos ao Docker que o contêiner irá escutar na porta 5666.
EXPOSE 5666

# O comando para iniciar o Nginx já está incluído na imagem base, então não precisamos de um CMD.
