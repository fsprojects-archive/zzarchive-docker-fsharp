FROM fsharp:10.7.0
LABEL maintainer "Dave Curylo <dave@curylo.org>, Steve Desmond <steve@stevedesmond.ca>"

ENV FrameworkPathOverride /usr/lib/mono/4.7.2-api/
ENV NUGET_XMLDOC_MODE=skip \
    DOTNET_RUNNING_IN_CONTAINER=true \
    DOTNET_USE_POLLING_FILE_WATCHER=true
RUN apt-get update && \
    apt-get --no-install-recommends install -y \
    curl \
    libunwind8 \
    gettext \
    apt-transport-https \
    libc6 \
    libcurl4 \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu63 \
    liblttng-ust0 \
    libssl1.1 \
    libstdc++6 \
    libunwind8 \
    libuuid1 \
    zlib1g && \
    rm -rf /var/lib/apt/lists/*
RUN DOTNET_SDK_VERSION=3.1.102 && \
    DOTNET_SDK_DOWNLOAD_URL=https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-sdk-$DOTNET_SDK_VERSION-linux-x64.tar.gz && \
    DOTNET_SDK_DOWNLOAD_SHA=9cacdc9700468a915e6fa51a3e5539b3519dd35b13e7f9d6c4dd0077e298baac0e50ad1880181df6781ef1dc64a232e9f78ad8e4494022987d12812c4ca15f29 && \
    curl -SL $DOTNET_SDK_DOWNLOAD_URL --output dotnet.tar.gz && \
    echo "$DOTNET_SDK_DOWNLOAD_SHA dotnet.tar.gz" | sha512sum -c - && \
    mkdir -p /usr/share/dotnet && \
    tar -zxf dotnet.tar.gz -C /usr/share/dotnet && \
    rm dotnet.tar.gz && \
    ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
RUN mkdir warmup && \
    cd warmup && \
    dotnet new && \
    cd - && \
    rm -rf warmup /tmp/NuGetScratch
WORKDIR /root
CMD ["dotnet", "fsi"]
