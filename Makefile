DOCKER_IMAGE_NAME=$(shell cat IMAGE_NAME)

build:
	cd binder && docker build -t ${DOCKER_IMAGE_NAME} .

push:
	docker push ${DOCKER_IMAGE_NAME}
