# Parent image
FROM nginx:latest

# Labels
LABEL maintainer="BAREXTE <barexte@gmail.com>"

# Install tools
RUN \
  apt update && \
  apt upgrade -y && \
  apt install software-properties-common -y && \
  apt install certbot -y && \
  apt install easy-rsa -y && \
  mkdir -p /etc/k8s-certbot/secret

# Copy scripts
COPY ./gen-csr.sh /usr/bin/
COPY ./gen-cer.sh /usr/bin/
COPY ./easyrsa.patch /usr/share/easy-rsa/easyrsa

RUN \
  chmod +x /usr/bin/gen-csr.sh && \
  chmod +x /usr/bin/gen-cer.sh && \
  chmod +x /usr/share/easy-rsa/easyrsa
