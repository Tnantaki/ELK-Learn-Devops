FROM alpine:3.19.3

COPY generate-certs.sh .

RUN chmod +x generate-certs.sh

RUN apk add openssl

RUN mkdir certs

CMD ["sh", "generate-certs.sh"]

