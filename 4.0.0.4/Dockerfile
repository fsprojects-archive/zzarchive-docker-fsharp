FROM buildpack-deps:trusty
MAINTAINER Henrik Feldt

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list && \
    echo "deb http://download.mono-project.com/repo/debian alpha main" > /etc/apt/sources.list.d/mono-xamarin-alpha.list

RUN apt-get -y update && \
    apt-get -y --no-install-recommends install nuget && \
    rm -rf /var/lib/apt/lists/*

ENV MONO_VERSION 4.2.1.102
ENV MONO_THREADS_PER_CPU 50

RUN apt-get -y update && \
    apt-get -y --no-install-recommends install mono-devel=$MONO_VERSION-0xamarin1 ca-certificates-mono=$MONO_VERSION-0xamarin1 && \
    rm -rf /var/lib/apt/lists/*

ENV FSHARP_PREFIX /usr
ENV FSHARP_GACDIR /usr/lib/mono/gac
ENV FSHARP_VERSION 4.0.0.4
ENV FSHARP_BASENAME fsharp-$FSHARP_VERSION
ENV FSHARP_ARCHIVE $FSHARP_VERSION.tar.gz
ENV FSHARP_ARCHIVE_URL https://github.com/fsharp/fsharp/archive/$FSHARP_ARCHIVE

RUN mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget $FSHARP_ARCHIVE_URL && \
    tar xf $FSHARP_ARCHIVE && \
    cd $FSHARP_BASENAME && \
    ./autogen.sh --prefix=$FSHARP_PREFIX --with-gacdir=$FSHARP_GACDIR && \
    make && \
    make install && \
    cd ~ && \
    rm -rf /tmp/src

CMD ["fsharpi"]
