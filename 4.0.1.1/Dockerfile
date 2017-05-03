FROM buildpack-deps:trusty
LABEL maintainer "Dave Curylo <dave@curylo.org>, Steve Desmond <steve@stevedesmond.ca>"

ENV MONO_VERSION 4.8.0.495

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-xamarin.list

ENV MONO_THREADS_PER_CPU 50

RUN apt-get -y update && \
    apt-get -y --no-install-recommends install nuget mono-devel ca-certificates-mono && \
    rm -rf /var/lib/apt/lists/*

ENV FSHARP_VERSION 4.0.1.1
ENV FSHARP_PREFIX=/usr \
    FSHARP_GACDIR=/usr/lib/mono/gac \
    FSHARP_BASENAME=fsharp-$FSHARP_VERSION \
    FSHARP_ARCHIVE=$FSHARP_VERSION.tar.gz \
    FSHARP_ARCHIVE_URL=https://github.com/fsharp/fsharp/archive/$FSHARP_VERSION.tar.gz

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

WORKDIR /root
CMD ["fsharpi"]
