FROM debian
RUN touch /etc/apt/sources.list.d/yandex.list && echo "deb http://mirror.yandex.ru/debian bullseye main" > /etc/apt/sources.list.d/yandex.list &&apt -y update && apt -y upgrade && apt -y install nginx && apt clean
RUN rm -rf /var/www/* && mkdir -p /var/www/company.com/img
COPY index.html /var/www/company.com/ 
COPY img.png /var/www/company.com/img/
RUN chmod -R 754 /var/www/company.com && useradd Oleg && groupadd Davidenko && usermod -a -G  Davidenko Oleg && chown -R Oleg /var/www/company.com/
RUN sed -i 's+/html+/company.com+g' /etc/nginx/sites-enabled/default
RUN sed -i 's+www-data+Oleg+g' /etc/nginx/nginx.conf

#EXPOSE 80
#STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]

#RUN /etc/init.d/nginx start
#CMD ["/bin/sh", "-c", "/etc/init.d/nginx start"]

#ENTRYPOINT /etc/init.d nginx status
