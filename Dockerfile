FROM ubuntu:latest
MAINTAINER Sebastian Fialka <sebastian.fialka@sebfia.net>

ENV MONO_VERSION 4.2.1.102
ENV FSHARP_VERSION 4.0.0.3
ENV LIBUV_PREFIX /opt/libuv
ENV LIBUV_VERSION v1.7.5
ENV LIBUV_BASENAME libuv-$LIBUV_VERSION
ENV LIBUV_ARCHIVE $LIBUV_BASENAME.tar.gz
ENV LIBUV_ARCHIVE_URL dist.libuv.org/dist/$LIBUV_VERSION/$LIBUV_ARCHIVE

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list && \
    echo "deb http://download.mono-project.com/repo/debian alpha main" | sudo tee /etc/apt/sources.list.d/mono-xamarin-alpha.list && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install mono-devel=$MONO_VERSION-0xamarin1 ca-certificates-mono=$MONO_VERSION-0xamarin1 fsharp=$FSHARP_VERSION-0xamarin1 nuget libtool make automake curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p $LIBUV_PREFIX/src && \
    cd $LIBUV_PREFIX/src && \
    curl -sL $LIBUV_ARCHIVE_URL -o $LIBUV_ARCHIVE && \
    tar xf $LIBUV_ARCHIVE && \
    cd $LIBUV_BASENAME && \
    libtoolize -c && \
    ./autogen.sh && \
    ./configure --prefix=$LIBUV_PREFIX && \
    make && \
    make install && \
    rm -rf $LIBUV_PREFIX/src && \
    cd ~ && \
    echo $LIBUV_PREFIX/lib/ > /etc/ld.so.conf.d/libuv.conf && ldconfig

ENV CMAKE_INCLUDE_PATH $LIBUV_PREFIX/include/:$CMAKE_INCLUDE_PATH
ENV CMAKE_LIBRARY_PATH $LIBUV_PREFIX/lib/:$CMAKE_LIBRARY_PATH

ENTRYPOINT ["/bin/bash"]
CMD ["fsharpi"]
