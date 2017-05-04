FROM jenkinsci/jenkins:2.47-alpine

USER root

RUN install-plugins.sh antisamy-markup-formatter matrix-auth pipeline-model-definition blueocean swarm
RUN apk update && apk add su-exec

# remove executors in master
COPY master-executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY volume-permissions.sh /usr/local/bin/volume-permissions.sh

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/volume-permissions.sh"]
