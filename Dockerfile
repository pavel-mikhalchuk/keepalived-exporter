FROM pavelmikhalchuk/keepalived as keepalived

FROM golang:alpine

RUN apk add --no-cache make git bash

WORKDIR /keepalived-exporter

ADD . .

RUN make build

COPY --from=keepalived /usr/local/sbin/keepalived /usr/local/sbin/keepalived

EXPOSE 9165

RUN keepalived -v

ENTRYPOINT [ "./keepalived-exporter" ]
