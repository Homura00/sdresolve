# Etapa 1: Definir a imagem base
# Usamos nginx:alpine por ser uma imagem extremamente leve e eficiente para servir arquivos estáticos.
FROM nginx:alpine

# Etapa 2: Copiar os arquivos do site
# Copiamos os arquivos do seu projeto para o diretório padrão do Nginx onde ele serve o conteúdo.
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY fotoSdResolve.jpeg /usr/share/nginx/html/

# Etapa 3: Expor a porta
# Informamos ao Docker que o contêiner irá escutar na porta 80.
EXPOSE 80

# O comando para iniciar o Nginx já está incluído na imagem base, então não precisamos de um CMD.
