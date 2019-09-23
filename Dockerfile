FROM centos/nginx-16-centos7

#set variables
ENV HOME=/opt/rh/nginx16/root/etc/nginx
#

#openshift lbles
LABEL io.k8s.description="nginx-centos7-1.16" \
      io.k8s.display-name="OpenShift nginx-centos7-1.16" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.expose-services="8888:http" \
      io.openshift.tags="builder,Nginx,webserver,html"

#copy s2i files
COPY ./s2i/bin/ /usr/libexec/s2i

#creating user and set permissions
RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "NGINX default user" default \
    && mkdir -p ${HOME} \
    && chown -R 1001:0 ${HOME} && chmod -R g+rwX ${HOME}

USER 1001
WORKDIR ${HOME}

#copy default nginx configuration
COPY ./nginx/default.conf ${HOME}/conf.d

#set default expose port
EXPOSE 8888