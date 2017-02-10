FROM testham/openshift-rappitmq:1.1.5
USER "root"
RUN yum install -y sudo \
&& /usr/sbin/rabbitmq-plugins enable --offline rabbitmq_management
USER "rabbitmq"
 
EXPOSE 15671 15672
