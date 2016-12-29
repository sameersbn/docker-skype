all: build

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

ENV_VARS = \
	--env="USER_UID=$(shell id -u)" \
	--env="USER_GID=$(shell id -g)" \
	--env="DISPLAY=${DISPLAY}" \
	--env="XAUTHORITY=${XAUTH}"

VOLUMES = \
	--volume=$(HOME)/.Skype:/home/skype/.Skype \
	--volume=$(HOME)/Downloads:/home/skype/Downloads \
	--volume=${XSOCK}:${XSOCK} \
	--volume=${XAUTH}:${XAUTH} \
	--volume=/run/user/$(shell id -u)/pulse:/run/pulse

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build the skype image"
	@echo "   1. make install          - install launch wrappers"
	@echo "   2. make skype 				   - launch skype"
	@echo "   2. make bash             - bash login"
	@echo ""

build:
	@docker build --tag=sameersbn/skype:$(shell cat VERSION) .

install uninstall: build
	@docker run -it --rm \
		--volume=/usr/local/bin:/target \
		sameersbn/skype:$(shell cat VERSION) $@

skype bash:
	@docker run -it --rm \
		${ENV_VARS} \
		${VOLUMES} \
		sameersbn/skype:$(shell cat VERSION) $@
