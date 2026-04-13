FROM golang:1.25.1 AS builder

WORKDIR /app
COPY go.mod ./
COPY main.go ./
RUN go version
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server .

FROM gcr.io/distroless/base-debian12
WORKDIR /alinme-dev-moty
COPY --from=builder /app/server .
ENV PORT=3000
EXPOSE 3000
CMD ["/alinme-dev-moty/server"]