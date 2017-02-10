FROM openshift/base-centos7

MAINTAINER Deep Sky Team <hayat.2.amine.external@worldline.com>

ENV ERLANG_SOLUTIONS_VERSION 1.0-1
ENV http_proxy $HTTP_PROXY     
ENV https_proxy $HTTP_PROXY    
ENV HTTP_PROXY $HTTP_PROXY     
ENV HTTPS_PROXY $HTTP_PROXY    

RUN yum update -y && yum clean all \
&& yum install -y wget && yum clean all\
  && yum -y install epel-release \
   && yum -y install wxGTK \
     &&  yum install -y http://packages.erlang-solutions.com/erlang-solutions-${ERLANG_SOLUTIONS_VERSION}.noarch.rpm  --skip-broken && yum clean all \
     && yum install -y erlang && yum clean all

#RUN yum update -y && yum clean all 
# RUN yum install -y wget && yum clean all
#  RUN yum -y install epel-release 
#  RUN  yum -y install wxGTK 
 #  RUN  yum install -y http://packages.erlang-solutions.com/erlang-solutions-${ERLANG_SOLUTIONS_VERSION}.noarch.rpm  --skip-broken && yum clean all 
 #   RUN  yum install -y erlang && yum clean all



ENV RABBITMQ_VERSION 3.6.5
RUN yum install -y http://www.rabbitmq.com/releases/rabbitmq-server/v${RABBITMQ_VERSION}/rabbitmq-server-${RABBITMQ_VERSION}-1.noarch.rpm && yum clean all \
&& echo "[{rabbit,[{loopback_users,[]}]}]." > /etc/rabbitmq/rabbitmq.config \
 && rm -rf /var/lib/rabbitmq/mnesia 

EXPOSE 4369 5671 5672 25672

# get logs to stdout (thanks @dumbbell for pushing this upstream! :D)
ENV RABBITMQ_LOGS=- RABBITMQ_SASL_LOGS=-

# set home so that any `--user` knows where to put the erlang cookie
ENV HOME /var/lib/rabbitmq

RUN mkdir -p /var/lib/rabbitmq /etc/rabbitmq \
	&& chown -R rabbitmq:rabbitmq /var/lib/rabbitmq /etc/rabbitmq \
	 && chmod 777 /var/lib/rabbitmq /etc/rabbitmq \ 
	  && chown -R rabbitmq:rabbitmq /opt/app-root

VOLUME /var/lib/rabbitmq/

RUN ls -la /var/lib/rabbitmq/

COPY ./docker-entrypoint.sh /usr/local/bin/

USER "rabbitmq"

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rabbitmq-server"]
