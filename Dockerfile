FROM docker.io/golang:alpine as builder
RUN apk --no-cache add tzdata
WORKDIR /go/src/github.com/serjs/socks5
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-s' -o ./socks5

FROM docker.io/alpine:latest
RUN apk add --no-cache curl
COPY --from=builder /go/src/github.com/serjs/socks5/socks5 /
ENTRYPOINT ["/socks5"]
