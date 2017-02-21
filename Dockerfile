FROM debian:sid
MAINTAINER Lorenz Vanthillo <lorenz.vanthillo@outlook.com>
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    apt-utils \
    libgtk2.0-0 \
    libxtst6 \
    libxss1 \
    libgconf-2-4 \
    libnss3 \
    libasound2 \
    dbus \
    packagekit-gtk3-module \
    libcanberra-gtk-module \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN dbus-uuidgen > /var/lib/dbus/machine-id

ENV HOME /home/franz
RUN useradd --create-home --home-dir $HOME franz \
    && gpasswd -a franz franz \
    && chown -R franz:franz $HOME

USER franz
WORKDIR $HOME

RUN wget https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz
RUN tar -xzvf Franz-linux-x64-4.0.4.tgz -C $HOME && \
    rm Franz-linux-x64-4.0.4.tgz

ENV config /home/franz/.config/Franz
RUN mkdir -p "$config" && chown -R franz:franz "$config"
VOLUME /home/franz/.config/Franz

ENTRYPOINT  [ "./Franz" ]
