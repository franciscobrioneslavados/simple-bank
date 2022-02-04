# Build Stage
FROM golang:1.17-alpine3.13 AS builder

WORKDIR /app
COPY . .
RUN go build -o main main.go

# RUN stage
FROM alpine:3.13
WORKDIR /app
COPY --from=builder /app/main .

COPY app.env . 

EXPOSE 8080

CMD ["/app/main"]