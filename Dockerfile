FROM --platform=${BUILDPLATFORM} alpine:3.16.0 as src
RUN apk add --no-cache ca-certificates curl
RUN curl -L https://github.com/SanCraftDev/vokabel-trainer/archive/refs/heads/develop.tar.gz | tar zx
RUN mv /vokabel-trainer-* /vokabel-trainer

FROM --platform=${BUILDPLATFORM} httpd:2.4.54-alpine3.16
COPY --from=src /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=src /vokabel-trainer /usr/local/apache2/htdocs
ENTRYPOINT ["httpd"]
CMD ["-D", "FOREGROUND"]
