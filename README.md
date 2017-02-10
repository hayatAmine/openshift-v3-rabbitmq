#see https://hub.docker.com/_/rabbitmq/
#proxy
 export http_proxy="<proxyHost:proxyPort>"
 export https_proxy="<proxyHost:proxyPort>"
 export HTTP_PROXY="<proxyHost:proxyPort>"
 export HTTPS_PROXY="<proxyHost:proxyPort>"

#build images
 docker build --build-arg HTTP_PROXY=$HTTP_PROXY -t <project>/<image-name>:<tag> ./

#log to v1 registry
 docker login -u a609716 registry.v1.dpsk.as8677.net

#tag images
 docker tag <project>/<image-name>:<tag> registry.v1.dpsk.as8677.net/<project>/<image-name>:<tag>

#push images
 docker push registry.v1.dpsk.as8677.net/<project>/<image-name>:<tag>
 
#use image in openshift
oc new-app luiscoms/openshift-rabbitmq:management
