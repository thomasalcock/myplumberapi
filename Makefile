build:
	DOCKER_BUILDKIT=1 docker build -t house_api .

rem:
	docker rmi house_api

remove:
	docker rmi $$(docker images -f "dangling=true" -q)

run:
	docker run \
		--rm \
		--name house_api \
		-p 8000:8000 \
		-v $$(pwd)/data:/root/api/data \
		-d \
		--network api-workshop-net \
		house_api