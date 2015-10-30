FROM centos:latest
MAINTAINER Henrik Feldt <henrik@haf.se>

ENV FSHARP_VERSION 4.0.0.4
ENV FSHARP_BUILD_PREFIX /build
ENV APP_PREFIX /app
RUN mkdir -p $FSHARP_BUILD_PREFIX $APP_PREFIX
WORKDIR $FSHARP_BUILD_PREFIX

RUN set -x && \
    yum install -y yum-utils && \
    rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" && \
    yum-config-manager --add-repo http://download.mono-project.com/repo/centos/ && \
    yum install -y mono-complete fsharp

ENTRYPOINT ["/bin/bash"]
CMD ["fsharpi"]