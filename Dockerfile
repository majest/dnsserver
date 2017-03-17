FROM golang:alpine
RUN mkdir /app
ADD main /app/
WORKDIR /app
CMD ["/app/main"]
