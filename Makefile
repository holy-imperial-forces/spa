container_exists := `docker ps -a -q -f name=SPA`
dir := `pwd`

up:
	if [ ${container_exists} ] ; then \
		docker stop SPA ; \
		docker rm SPA ; \
	fi
	docker run -d --name SPA --mount type=bind,source="${dir}/codebase",target=/codebase -p 5000:5000 spa

exec:
	docker exec -tiu root SPA /bin/sh

stop:
	docker stop SPA

build:
	if [ ${container_exists} ] ; then \
		docker stop SPA && docker rm SPA ; \
	fi
	docker build -t spa . --file Dockerfile-dev
	docker run -d --name SPA --mount type=bind,source="${dir}/codebase",target=/codebase -p 5000:5000 spa

test:
	docker exec SPA npm run lint
	docker exec SPA npm run test