NAME = katacoda/docker-http-server
TAG=v1
INSTANCE = scrapbook-http-server

.PHONY: default build copy debug clean push buildrelease

default: buildrelease

build:
	docker build -t $(NAME)-dev .

copy:
	docker create --name $(INSTANCE) $(NAME)-dev
	docker cp $(INSTANCE):/app/main $(shell pwd)/app
	docker rm $(INSTANCE)

release:
	docker build -t $(NAME):$(TAG) -f Dockerfile-release .
	docker tag $(NAME):$(TAG) $(NAME):latest

buildrelease: build copy release

clean:
	docker rm $(INSTANCE)

debug:
	docker run --rm -it --name $(INSTANCE) $(NAME)-dev /bin/bash

run:
	docker run --rm -p 80:80 --name $(INSTANCE) $(NAME)

dev:
	docker run -it --rm -p 80:80 -w /go/src/github.com/$(NAME) -v $(shell pwd)/vendor/github.com/:/go/src/github.com/ -v $(shell pwd):/go/src/github.com/$(NAME) golang:1.6

push:
	docker push $(NAME):$(TAG)
	docker push $(NAME):latest
