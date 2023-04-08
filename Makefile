DOCKER_IMAGE_NAME=$(shell cat IMAGE_NAME)
DOCKER_DISPLAY=$(shell grep -q "microsoft-standard" /proc/version && echo $(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')${DISPLAY} || echo ${DISPLAY})

build:
	cd binder && docker build -t ${DOCKER_IMAGE_NAME} .

push:
	docker push ${DOCKER_IMAGE_NAME}

run:
	docker stop binder || true && docker rm binder || true
	docker run --privileged -h  binder --name binder -d --cap-add=SYS_PTRACE \
	   --net=host \
	   --add-host binder:127.0.0.1 \
	   --env HOME=/home/${USER} \
	   --env USER=${USER} \
	   --env GROUP=${USER} \
	   --env USER_ID=`id -u ${USER}` \
	   --env GROUP_ID=`getent group ${USER} | awk -F: '{printf $$3}'` \
	   --env TIMEZONE=`cat /etc/timezone` \
	   --env EMAIL \
	   --env GIT_AUTHOR_EMAIL \
	   --env GIT_AUTHOR_NAME \
	   --env GIT_COMMITTER_EMAIL \
	   --env GIT_COMMITTER_NAME \
	   --env SSH_AUTH_SOCK \
	   --env TERM \
	   --env DISPLAY=${DOCKER_DISPLAY} \
	   --env VIDEO_GROUP_ID=`getent group video | awk -F: '{printf $$3}'` \
	   --volume $${PWD%/*}:/home/${USER} \
	   --volume /dev/dri:/dev/dri \
	   --gpus all \
	   --env NVIDIA_VISIBLE_DEVICES=all \
	   --env NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics,display \
	   --env LD_LIBRARY_PATH=/usr/local/nvidia/lib64 \
	   ${DOCKER_IMAGE_NAME}
	xhost +local:'binder'

enter:
	docker exec -it -u ${USER} -w /home/${USER}/$${PWD##*/} binder /bin/bash

stop:
	docker stop binder || true && docker rm binder || true
	docker stop binder-nvidia || true && docker rm binder-nvidia || true
