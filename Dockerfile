FROM golang:1.27-alpine
ADD ./ /work
WORKDIR /work
RUN CGO_ENABLED=0 GOOS=linux go build -buildmode=pie -o bash-exporter .

FROM alpine
VOLUME /scripts
WORKDIR /root/
COPY --from=0 /work/bash-exporter /root/
COPY ./examples/* /scripts/

EXPOSE 9300/tcp
ENTRYPOINT ["/root/bash-exporter"]
