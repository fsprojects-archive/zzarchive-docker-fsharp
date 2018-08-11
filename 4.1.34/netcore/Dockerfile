FROM fsharp:4.1.34
LABEL maintainer "Dave Curylo <dave@curylo.org>, Steve Desmond <steve@stevedesmond.ca>"

ENV FrameworkPathOverride /usr/lib/mono/4.6.2-api/
ENV NUGET_XMLDOC_MODE skip
RUN apt-get update && \
    apt-get --no-install-recommends install -y \
    curl \
    libunwind8 \
    gettext \
    apt-transport-https \
    libc6 \
    libcurl3 \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu52 \
    liblttng-ust0 \
    libssl1.0.0 \
    libstdc++6 \
    libunwind8 \
    libuuid1 \
    zlib1g && \
    rm -rf /var/lib/apt/lists/*
RUN DOTNET_SDK_VERSION=2.1.302 && \
    DOTNET_SDK_DOWNLOAD_URL=https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-sdk-$DOTNET_SDK_VERSION-linux-x64.tar.gz && \
    DOTNET_SDK_DOWNLOAD_SHA=2166986e360f1c3456a33723edb80349e6ede115be04a6331bfbfd0f412494684d174a0cfb21d2feb00d509ce342030160a4b5b445e393ad83bedb613a64bc66 && \
    curl -SL $DOTNET_SDK_DOWNLOAD_URL --output dotnet.tar.gz && \
    echo "$DOTNET_SDK_DOWNLOAD_SHA dotnet.tar.gz" | sha512sum -c - && \
    mkdir -p /usr/share/dotnet && \
    tar -zxf dotnet.tar.gz -C /usr/share/dotnet && \
    rm dotnet.tar.gz && \
    ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
RUN mkdir warmup && \
    cd warmup && \
    dotnet new && \
    cd - && \
    rm -rf warmup /tmp/NuGetScratch
WORKDIR /root
