FROM debian:sid-slim
LABEL maintainer="lorenz.vanthillo@gmail.com"
RUN apt-get -o Acquire::Check-Valid-Until=false update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
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

RUN wget https://github.com/meetfranz/franz/releases/download/v5.0.0-beta.18/franz-5.0.0-beta.18.tar.gz

RUN tar -zxvf franz-5.0.0-beta.18.tar.gz --strip-components=1 && \
    rm franz-5.0.0-beta.18.tar.gz

ENV config /home/franz/.config/Franz
RUN mkdir -p "$config" && chown -R franz:franz "$config"
VOLUME /home/franz/.config/Franz

ENTRYPOINT  [ "./franz" ]
