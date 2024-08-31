all: build

build:
	docker compose up -d --build

run:
	docker compose up

down:
	docker compose down

start:
	docker compose start

stop:
	docker compose stop

re: down build

.PHONY : all build run down start stop re 