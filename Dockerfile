# docker build -t vlt .
# docker run --name vlt -p 8200:8200 --cap-add IPC_LOCK vlt
# docker stop vlt && docker rm vlt 
# docker rmi vlt

FROM vault:1.3.3

ADD config.hcl /app/config.hcl

ENV VAULT_API_ADDR=http://127.0.0.1:8200

CMD ["server", "-config=/app/config.hcl"]