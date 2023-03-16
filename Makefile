DOCKER_IMAGE_NAME=$(shell cat IMAGE_NAME)
UID=$(shell id -u $$USER)
GID=$(shell getent group $$USER | awk -F: '{printf $$3}')
ifeq ($(UID),1000)
  USER=ue4
endif

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
	   --env USER_ID=${UID} \
	   --env GROUP_ID=${GID} \
	   --env TIMEZONE=`cat /etc/timezone` \
	   --env EMAIL \
	   --env GIT_AUTHOR_EMAIL \
	   --env GIT_AUTHOR_NAME \
	   --env GIT_COMMITTER_EMAIL \
	   --env GIT_COMMITTER_NAME \
	   --env SSH_AUTH_SOCK \
	   --env TERM \
	   --env DISPLAY \
	   --env SDL_VIDEODRIVER=x11 \
	   --env VIDEO_GROUP_ID=`getent group video | awk -F: '{printf $$3}'` \
	   --volume $${PWD%/*}:/home/${USER}/workspace \
	   --volume /tmp/.X11-unix/:/tmp/.X11-unix/ \
	   --volume /usr/share/vulkan/icd.d:/usr/share/vulkan/icd.d \
	   --volume /dev/dri:/dev/dri \
	   --gpus all \
	   --env NVIDIA_VISIBLE_DEVICES=all \
	   --env NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics,display,video \
	   --env LD_LIBRARY_PATH=/usr/local/nvidia/lib64 \
	   ${DOCKER_IMAGE_NAME}
	xhost +local:'binder'

enter:
	docker exec -it -u ${USER} -w /home/${USER}/workspace binder /bin/bash

stop:
	docker stop binder
	docker rm binder

unreal-editor:
	/home/ue4/UnrealEngine/Engine/Binaries/Linux/UnrealEditor
