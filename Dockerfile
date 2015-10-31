FROM centos:latest
MAINTAINER Henrik Feldt <henrik@haf.se>

ENV MONO_VERSION 4.0.4.1
ENV FSHARP_VERSION 4.0.0.3

RUN set -x && \
    yum clean all && \
    yum install -y yum-utils && \
    rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" && \
    yum-config-manager --add-repo http://download.mono-project.com/repo/centos/ && \
    yum install -y mono-complete-$MONO_VERSION fsharp-$FSHARP_VERSION

ENTRYPOINT ["/bin/bash"]
CMD ["fsharpi"]