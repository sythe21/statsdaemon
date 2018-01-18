FROM golang:1.9
WORKDIR /go/src/github.com/bitly/statsdaemon
COPY . .
RUN go get -d -v github.com/bmizerany/assert \
  && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/bitly/statsdaemon/app .
ENTRYPOINT ["./app"]  
