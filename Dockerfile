FROM nginx:stable-alpine

#copy s2i files
COPY ./s2i/bin/ /usr/libexec/s2i
# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx /usr/libexec/s2i
RUN chgrp -R root /var/cache/nginx

RUN addgroup nginx root
USER nginx

#openshift lables
LABEL io.k8s.description="nginx-stable-alpine" \
      io.k8s.display-name="OpenShift nginx-stable-alpine" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.expose-services="8888:http" \
      io.openshift.tags="builder,Nginx,webserver,html"


USER nginx
WORKDIR /tmp 

#copy default nginx configuration
COPY ./nginx/default.conf /etc/nginx/sites-enabled

#set default expose port
EXPOSE 8888