FROM       centos:7
MAINTAINER sqre-admin
# XXX probably better to make this an ARG
ENV        VERSION 0.0.1

LABEL      version="$VERSION" \
           description="LSST DM/SQuaRE keeper.lsst.codes product status" \
           name="lsstsqre/uservice-productstatus"

RUN        mkdir /dist
COPY       dist/sqre-uservice-productstatus-$VERSION.tar.gz /dist

USER       root
RUN        yum install -y epel-release && \
           yum repolist && \
           yum install -y git python-pip python-devel && \
           pip install --upgrade pip && \
           useradd -d /home/flasker -m flasker

RUN        pip install /dist/sqre-uservice-productstatus-$VERSION.tar.gz

USER flasker
WORKDIR /home/flasker
EXPOSE 5000
CMD sqre-uservice-productstatus
