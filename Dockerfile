FROM golang:1.6-alpine
EXPOSE 80
CMD ["/app/main"]

RUN mkdir /app 
WORKDIR /app 
ADD . /app/ 

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

