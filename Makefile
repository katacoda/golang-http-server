NAME = katacoda/docker-http-server
TAG=openshift-v1
INSTANCE = scrapbook-http-server

.PHONY: default build copy release buildrelease debug clean push

default: build

build:
	docker build -t $(NAME)-dev .

copy:
	docker create --name $(INSTANCE) $(NAME)-dev
	docker cp $(INSTANCE):/app/main $(shell pwd)/app
	docker rm $(INSTANCE)

release:
	docker build -t $(NAME):$(TAG) -f Dockerfile-release .

buildrelease: build copy release

clean:
	docker rm $(INSTANCE)

debug:
	docker run --rm -it --name $(INSTANCE) $(NAME)-dev /bin/bash

run:
	docker run --rm -p 80:80 --name $(INSTANCE) $(NAME):$(TAG)

dev:
	docker run -it --rm -w /go/src/github.com/$(NAME) -v $(shell pwd)/vendor/github.com/:/go/src/github.com/ -v $(shell pwd):/go/src/github.com/$(NAME) golang

push:
	docker push $(NAME):$(TAG)
