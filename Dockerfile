FROM nginx:1.16.0-alpine

#set variables
ENV HOME=/etc/nginx
#

#openshift lbles
LABEL io.k8s.description="nginx-alpine-1.16" \
      io.k8s.display-name="OpenShift nginx-alpine-1.16" \
      io.openshift.s2i.scripts-url="image:///etc/nginx" \
      io.openshift.expose-services="8888:http" \
      io.openshift.tags="builder,Nginx,webserver,html"

#copy s2i files
COPY ./s2i/bin/ /etc/nginx

#creating user and set permissions
#RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "NGINX default user" default \
# #   && mkdir -p ${HOME} \
#  #  && chown -R 1001:0 ${HOME} && chmod -R g+rwX ${HOME} && chmod -R g+rwX /etc/nginx
#
USER 101
WORKDIR /etc/nginx

#copy default nginx configuration
COPY ./nginx/default.conf /etc/nginx/sites-enabled
COPY ./nginx/default.conf /etc/nginx/sites-enabled

#set default expose port
EXPOSE 8888