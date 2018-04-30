FROM node:6-alpine

RUN apk update 					&&\
	apk upgrade 				&&\
	apk add git					&&\
	apk add openssh-client		&&\
	yarn global add lerna


RUN mkdir ~/.ssh &&\
	ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts