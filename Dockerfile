FROM golang:1.25.3-alpine3.22 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

FROM alpine:3.22
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .

CMD ["/app/main"]