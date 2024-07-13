FROM golang:1.22.4-alpine as builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download && go mod verify

# copiando tudo da interface para o /app
COPY . .

RUN go build -o /bin/journey ./cmd/journey/journey.go

# separando estágio de prep e exe
FROM scratch

WORKDIR /app

COPY --from=builder /bin/journey .

EXPOSE 8080

ENTRYPOINT [ "./journey" ]