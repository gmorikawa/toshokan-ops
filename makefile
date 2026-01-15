init:
	mkdir -p ./data/postgres
	mkdir -p ./data/server
	touch server.env
	touch web.env

container-up:
	docker compose up -d

container-down:
	docker compose down

remove-server-image:
	docker image rm toshokan-server

remove-web-image:
	docker image rm toshokan-web

remove-all-images: remove-server-image remove-web-image

deploy-web: container-down remove-web-image container-up

deploy-server: container-down remove-server-image container-up

deploy: container-down remove-all-images container-up