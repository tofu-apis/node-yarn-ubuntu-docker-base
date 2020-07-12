DOCKER_COMPOSE_FILE_NAME = docker-compose.test.yml

.PHONY: clean build rebuild test

build:
	docker-compose --file $(DOCKER_COMPOSE_FILE_NAME) build

clean:
	docker-compose --file $(DOCKER_COMPOSE_FILE_NAME) down --remove-orphans --rmi all

rebuild:
	docker-compose --file $(DOCKER_COMPOSE_FILE_NAME) build --no-cache --pull

test: build
	docker-compose --file $(DOCKER_COMPOSE_FILE_NAME) run sut \
	&& echo "Tests successfully passed!"
