FROM fedora:21
MAINTAINER "Stef Walter" <stefw@redhat.com>

RUN yum -y update && yum clean all

# A repo where we can find recent Cockpit builds for F21
ADD cockpit-preview.repo /etc/yum.repos.d/
RUN yum -y --enablerepo=cockpit-preview install cockpit && yum clean all 

# And the stuff that starts the container
RUN mkdir -p /container
ADD cockpit-container-bridge /container/cockpit-bridge
ADD cockpit-container-daemon /container/cockpitd
ADD cockpit-container-run /container/cockpit-run

# Look ma, no EXPOSE

CMD ["/container/cockpit-run"]
