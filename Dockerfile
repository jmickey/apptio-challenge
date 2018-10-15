FROM ubuntu:latest

RUN mkdir -p /srv/www/public

WORKDIR /temp
ADD https://s3-us-west-2.amazonaws.com/techops-interview-webapp/webapp.tar.gz .
RUN tar -xvzf webapp.tar.gz

WORKDIR /srv/www

RUN cp /temp/public/* ./public/
RUN cp /temp/dist/example-webapp-linux .

RUN rm -rf /temp

ENTRYPOINT [ "./example-webapp-linux" ]