FROM nginx:stable

RUN rm -f /etc/nginx/conf.d/default.conf
RUN mkdir /log && cd /log && touch log.log

ADD nginx.conf /etc/nginx/nginx.conf
ADD conf.d/ /etc/nginx/conf.d/