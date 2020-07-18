# Parent image
FROM nginx:latest

# Labels
LABEL maintainer="BAREXTE <barexte@gmail.com>"

# Install tools
RUN \
  apt update && \
  apt upgrade -y && \
  apt install software-properties-common -y && \
  apt install certbot -y
