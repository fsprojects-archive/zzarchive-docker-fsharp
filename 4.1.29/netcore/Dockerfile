FROM fsharp
LABEL maintainer "Dave Curylo <dave@curylo.org>, Steve Desmond <steve@stevedesmond.ca>"

ENV FrameworkPathOverride /usr/lib/mono/4.5/
RUN apt-get update && \
    apt-get --no-install-recommends install -y curl libunwind8 gettext apt-transport-https
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-jessie-prod jessie main" > /etc/apt/sources.list.d/dotnetdev.list && \
    apt-get update && apt-get --no-install-recommends install -y dotnet-sdk-2.0.3 && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir warmup && \
    cd warmup && \
    dotnet new && \
    cd .. && \
    rm -rf warmup && \
    rm -rf /tmp/NuGetScratch
WORKDIR /root
