build_api:
	DOCKER_BUILDKIT=1 docker build -t house_api .

remove:
	docker rmi $$(docker images -f "dangling=true" -q)

run_api:
	docker run \
		--rm \
		--name house_api \
		-p 8000:8000 \
		-d \
		--network api-workshop-net \
		house_api