init:
	mkdir -p ./data/postgres
	mkdir -p ./data/server
	touch server.env
	touch web.env

container-up:
	docker compose up -d

container-down:
	docker compose down