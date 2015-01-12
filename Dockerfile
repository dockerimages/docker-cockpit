FROM fedora:21
MAINTAINER "Frank Lemanschik" <frank@dspeed.eu>

RUN yum -y update && yum clean all

# A repo where we can find recent Cockpit builds for F21
# ADD cockpit-preview.repo /etc/yum.repos.d/
RUN echo '[cockpit-preview] \
 name=COPR repo for cockpit-preview \
 baseurl=http://copr-be.cloud.fedoraproject.org/results/sgallagh/cockpit-preview/fedora-$releasever-$basearch/ \
 gpgcheck=0 \
 enabled=0' > /etc/yum.repos.d/cockpit-preview.repo
RUN yum -y --enablerepo=cockpit-preview install cockpit && yum clean all 

# And the stuff that starts the container
RUN mkdir -p /container
ADD cockpit-container-bridge /container/cockpit-bridge
ADD cockpit-container-daemon /container/cockpitd
ADD cockpit-container-run /container/cockpit-run
RUN chmod +x /container/*

EXPOSE 9090

CMD ["/container/cockpit-run"]
