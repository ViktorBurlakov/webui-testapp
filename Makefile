.PHONY: npm_install jspm_isntall jspm_lockdown static init build server

SHELL := /bin/bash

include .env


npm_install: .env
	sudo apt-get install npm
	sudo apt-get install nodejs-legacy
	npm config set prefix '$(NPM_GLOBAL_PATH)'
	@echo -e '\nexport PATH="$(NPM_GLOBAL_PATH)/bin:$$PATH"' >> ~/.bashrc
	source ~/.bashrc
#	npm install npm -g


jspm_install: npm_install
	npm install jspm -g


jspm_lockdown: jspm_install
	npm install jspm --save-dev


static:
	npm install node-static -g


init: jspm_install static
	jspm init
	jspm install npm:lodash-node
	jspm install github:components/jquery
	jspm install jquery
	jspm install myname=npm:underscore
	jspm install github:as3long/puremvc-es6-multicore-framework


build:
	jspm bundle js/main --inject


server:
	static -p 8000