FROM alpine:latest

RUN mkdir -p /srv/www/public

WORKDIR /temp
ADD https://s3-us-west-2.amazonaws.com/techops-interview-webapp/webapp.tar.gz .
RUN tar -xvzf webapp.tar.gz

RUN cp ./public/* /srv/www/public/
RUN cp ./dist/example-webapp-linux /srv/www

WORKDIR /srv/www
RUN rm -rf /temp/*

ENTRYPOINT [ "./example-webapp-linux" ]