FROM       centos:7
MAINTAINER sqre-admin
LABEL      description="LSST DM/SQuaRE keeper.lsst.codes product status" \
           name="lsstsqre/uservice-productstatus"

# Must run python setup.py sdist first.
ARG        VERSION="0.0.2"
LABEL      version="$VERSION"
RUN        mkdir /dist
COPY       dist/sqre-uservice-productstatus-$VERSION.tar.gz /dist

USER       root
RUN        yum install -y epel-release
RUN        yum repolist
RUN        yum install -y git python-pip python-devel
RUN        yum install -y gcc openssl-devel
RUN        pip install --upgrade pip
RUN        useradd -d /home/uwsgi -m uwsgi
RUN        mkdir /dist

# Must run python setup.py sdist first.
COPY       dist/sqre-uservice-productstatus-$VERSION.tar.gz /dist
RUN        pip install /dist/sqre-uservice-productstatus-$VERSION.tar.gz

USER       uwsgi
WORKDIR    /home/uswsgi
COPY       uwsgi.ini .
EXPOSE     5000
#CMD        sqre-uservice-productstatus
CMD        [ "uwsgi", "-T", "uwsgi.ini" ]
