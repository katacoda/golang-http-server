NAME="scrapbook/docker-http-server"
build:
	docker build -t $(NAME) .

run:
	docker run -d -P $(NAME)

debug:
	docker run --rm -it $(NAME) /bin/bash

deploy:
	docker push $(NAME)

