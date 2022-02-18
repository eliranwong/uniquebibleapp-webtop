FROM lsiobase/rdesktop-web:arch

# set version label
ARG BUILD_DATE
#ARG VERSION
# LABEL build_version="UniqueBibleApp version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL build_version="Unique Bible App webtop version Build-date:- ${BUILD_DATE}"
LABEL maintainer="Eliran Wong"

RUN \
  echo "**** install updates ****" && \
  pacman -Syu --noconfirm

RUN \
  echo "**** install tools & library ****" && \
  pacman -S --noconfirm --needed \
    wget \
    git \
    nano \
    gcc \
    glibc \
    gtk3 \
    python-pip \
    python-setuptools \
    python-pyqt5 \
    python-pyqt5-sip \
    python-pyqt5-webengine \
    python-qtpy

RUN \
  echo "**** install thunar ****" && \
  pacman -S --noconfirm --needed \
    exo \
    garcon \
    thunar \
    thunar-volman \
    tumbler

# RUN \
#   echo "**** install xfce ****" && \
#   pacman -S --noconfirm --needed \
#     xfce4 \
#     xfce4-appfinder \
#     xfce4-panel \
#     xfce4-power-manager \
#     xfce4-session \
#     xfce4-settings \
#     xfce4-terminal \
#     xfconf \
#     xfdesktop \
#     xfwm4 \
#     xfwm4-themes \
#     xfce4-pulseaudio-plugin
#     # To use xfce4-terminal, e.g.:
#     # > xfce4-terminal -e "python /config/UniqueBible/uba.py docker"

RUN \
  echo "**** gui applications ****" && \
  pacman -S --noconfirm --needed \
    obconf-qt \
    rxvt-unicode \
    leafpad \
    # mousepad \
    geany \
    firefox \
    gthumb \
    vlc

RUN \
  echo "**** setup audio text-to-speech features ****" && \
  pip install --no-cache --upgrade pip && \
  # pip install --no-cache --upgrade sip setuptools && \
  # These are essential for UBA to offer text-to-speech features on docker version
  pip install --no-cache --upgrade \
    gTTS && \
  pacman -S --noconfirm --needed \
    mpd \
    mpc \
    sox \
    mpg123 \
    pulseaudio
  # Usage, for examples:
    # > gtts-cli 'hello' | play -t mp3 -
    # > gtts-cli --lang zh --nocheck '你好' | play -t mp3 -
    # > gtts-cli 'hello' --output hello.mp3
    # > mpg123 hello.mp3

RUN \
  echo "**** fix audio for macOS users ****" && \
  # macOS users should read https://github.com/eliranwong/ArchLinuxWebtop#setup-audio-macos-users-only
  sh -c 'echo "PULSE_SERVER=host.docker.internal" >> /etc/environment'

RUN \
  echo "**** install fonts ****" && \
  # Chrome OS core fonts
  pacman -S --noconfirm --needed ttf-croscore && \
  # Chinese fonts
  # sh -c 'echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen' && \
  # locale-gen && \
  pacman -S --noconfirm --needed wqy-bitmapfont wqy-zenhei ttf-arphic-ukai ttf-arphic-uming opendesktop-fonts wqy-microhei wqy-microhei-lite && \
  pacman -S --noconfirm --needed adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts noto-fonts-cjk
# To manually install Google fonts
# Modified from: https://stackoverflow.com/questions/56937689/how-to-install-fonts-in-docker
RUN wget https://github.com/google/fonts/archive/master.tar.gz -O gf.tar.gz
RUN tar -xf gf.tar.gz --directory /usr/share
RUN chown -R :users /usr/share/fonts-main
RUN mkdir -p /usr/share/fonts/truetype/google-fonts
RUN find /usr/share/fonts-main/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
RUN rm -f gf.tar.gz
RUN fc-cache -f && rm -rf /var/cache/*

RUN \
  echo "**** input method ****" && \
  pacman -S --noconfirm --needed \
    fcitx \
    fcitx-qt5 \
    fcitx-im \
    fcitx-googlepinyin \
    fcitx-configtool \
    opencc
  # You may read https://github.com/eliranwong/ArchLinuxWebtop#input-method-fcitx-optional for setup if you need to use fcitx.

RUN \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
