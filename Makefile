container_name = 'SPA'
container_exists := `docker ps -a -q -f name=${container_name}`
dir := `pwd`

up:
	if [ ${container_exists} ] ; then \
		docker stop ${container_name} ; \
		docker rm ${container_name} ; \
	fi
	docker run -d --name ${container_name} --mount type=bind,source="${dir}/src",target=/src -p 5000:5000 spa

exec:
	docker exec -tiu root ${container_name} /bin/sh

stop:
	docker stop ${container_name}

build:
	if [ ${container_exists} ] ; then \
		docker stop ${container_name} && docker rm ${container_name} ; \
	fi
	docker build -t spa . --file Dockerfile-dev
	docker run -d --name ${container_name} --mount type=bind,source="${dir}/src",target=/src -p 5000:5000 spa

test:
	docker exec ${container_name} npm run lint
	docker exec ${container_name} npm run test