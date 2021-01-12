FROM golang:alpine as build

RUN apk add --no-cache make git bash

WORKDIR /keepalived-exporter

ADD . .

RUN make build

FROM pavelmikhalchuk/keepalived

COPY --from=build /keepalived-exporter/keepalived-exporter /keepalived-exporter

EXPOSE 9165

RUN keepalived -v

ENTRYPOINT [ "/keepalived-exporter" ]
