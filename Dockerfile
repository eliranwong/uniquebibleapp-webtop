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
    locate \
    plocate \
    gcc \
    glibc \
    gtk3 \
    jre-openjdk \
    go \
    lame \
    python-pip \
    python-setuptools \
    # Install PySide2
    pyside2 \
    pyside2-tools \
    qt5-webengine \
    # Alternately, install PyQt5
    # python-pyqt5 \
    # python-pyqt5-sip \
    # python-pyqt5-webengine \
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
    breeze-icons \
    konsole \
    leafpad \
    # mousepad \
    geany \
    firefox \
    # libreoffice-still \
    # sqlitebrowser \
    gthumb \
    vlc && \
  # Install Firfox addon Video DownloadHelper Companion App 1.6.3
  wget https://github.com/mi-g/vdhcoapp/releases/download/v1.6.3/net.downloadhelper.coapp-1.6.3-1_amd64.tar.gz && \
  tar xf net.downloadhelper.coapp-1.6.3-1_amd64.tar.gz -C /usr/local && \
  /usr/local/net.downloadhelper.coapp-1.6.3/bin/net.downloadhelper.coapp-linux-64 install --system

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

#RUN \
  #echo "**** fix audio for macOS users ****" && \
  # macOS users should read https://github.com/eliranwong/ArchLinuxWebtop#setup-audio-macos-users-only
  #sh -c 'echo "PULSE_SERVER=host.docker.internal" >> /etc/environment'

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
# To manually install wps-fonts
# RUN git clone https://github.com/iamdh4/ttf-wps-fonts.git
# RUN mkdir /usr/share/fonts/wps-fonts
# RUN mv ttf-wps-fonts/* /usr/share/fonts/wps-fonts
# RUN chown -R :users /usr/share/fonts/wps-fonts
# RUN rm -rf ttf-wps-fonts
# Build font information caches
RUN fc-cache -f && rm -rf /var/cache/*

RUN \
  echo "**** input method ****" && \
  pacman -S --noconfirm --needed \
    fcitx5-im \
    fcitx5-chinese-addons \
    fcitx5-pinyin-zhwiki \
    rime-pinyin-zhwiki \
    opencc && \
  sh -c 'echo "XMODIFIERS=@im=fcitx" >> /etc/environment' && \
  sh -c 'echo "GTK_IM_MODULE=fcitx" >> /etc/environment' && \
  sh -c 'echo "QT_IM_MODULE=fcitx" >> /etc/environment'
  # You may read https://wiki.archlinux.org/title/Fcitx5 to learn more about fcitx.

# Change openbox keyboard shortcuts
RUN sed -E -i.bak 's/<keybind key="A-Tab">/<keybind key="C-A-Tab">/g' /etc/xdg/openbox/rc.xml

# Install AUR packages
RUN echo "**** install aur packages ****"
RUN git clone https://aur.archlinux.org/yay-git.git /opt/yay
# RUN chown -R abc:users /opt/yay
# RUN runuser -l abc -c 'cd /opt/yay && makepkg -si --noconfirm --needed && cd -'
# RUN runuser -l abc -c 'yay -Syu --noconfirm --needed wps-office wps-office-fonts ttf-wps-fonts'

RUN \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*

# add local files
COPY /root /

# update locate database
RUN updatedb

# ports and volumes
EXPOSE 3000
VOLUME /config
