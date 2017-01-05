FROM       centos:7
MAINTAINER sqre-admin
LABEL      version="0.0.1"
           description="LSST DM/SQuaRE keeper.lsst.codes product status"
           name="lsstsqre/uservice-productstatus"

USER       root
RUN        yum update -y && \
           yum install -y epel-release && \
           yum repolist && \
           yum install -y git python-pip python-devel && \
	   pip install --upgrade pip && \
           pip install requests sqre-uservice-productstatus && \
           useradd -d /home/flasker -m flasker

USER flasker
WORKDIR /home/flasker
EXPOSE 5000
CMD sqre-uservice-productstatus
	   
