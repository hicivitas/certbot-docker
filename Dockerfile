FROM certbot/certbot:v0.24.0
RUN pip install --no-cache-dir \
    certbot-dns-dnspod && \
    apk --no-cache add curl ca-certificates bash && \
    curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl
COPY *.sh /bin/
ENTRYPOINT ["/bin/cert.sh"]
