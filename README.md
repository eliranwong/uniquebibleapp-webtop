# Tweak Audio Branch

This branch is created to tweak audio for macOS users.

# Unique Bible App [weptop version]

Unique Bible App desktop version runs on Arch Linux webtop

With this package, you can now run Unique Bible App full desktop version on Windows / macOS / ChromeOS / Linux simply with a web browser.

# About Unique Bible App
https://github.com/eliranwong/UniqueBible

# About Webtops
https://www.linuxserver.io/blog/2021-05-05-meet-webtops-a-linux-desktop-environment-in-your-browser

# Install Docker FIRST

You can install docker on Windows, macOS, Linux, ChromeOS.

You may check our notes about docker setup at: https://github.com/eliranwong/ArchLinuxWebtop#setup-docker

Or learn more about docker at https://www.docker.com

# For end-users

With <a href="https://www.docker.com">docker</a> installed FIRST, run:

Use either one of the following, depending on your OS:

For macOS Users:

> docker run -d --name=uniquebibleapp --security-opt seccomp=unconfined -e PUID=501 -e PGID=20 -e TZ=Europe/London -e SUBFOLDER=/ -e KEYBOARD=en-gb-qwerty -p 3000:3000 -v ~/uniquebibleapp-webtop:/config -v /var/run/docker.sock:/var/run/docker.sock -v ~/.config/pulse:/config/.config/pulse --shm-size="1gb" --restart unless-stopped eliranwong/uniquebibleapp

For other OS Users:

> sudo docker run -d --name=uniquebibleapp --security-opt seccomp=unconfined -e PUID=1000 -e PGID=1000 -e TZ=Europe/London -e SUBFOLDER=/ -e KEYBOARD=en-gb-qwerty -p 3000:3000 -v ~/uniquebibleapp-webtop:/config -v /var/run/docker.sock:/var/run/docker.sock --shm-size="1gb" --restart unless-stopped eliranwong/uniquebibleapp

Notes:

1) Check host user id, by running the following command and change "-e PUID=1000 -e PGID=1000" if applicable

> id [username]

2) "~/uniquebibleapp-webtop" is the local path for storing webtop home directory.  You may change to suit your own needs. 

# To run Unique Bible App

To run Unique Bible App, simple open "localhost:3000" in a web browser.

Running Unique Bible App the first time takes extra time before you can load "localhost:3000", as have a script to help you download and setup everything needed for running UniqueBible.app.  During the setup you may see a Terminal app opened and running the setup process.  Please expect to wait for at least 10 minutes for the setup.  This applies to the first run ONLY.  When the setup is finished, Unique Bible App will launch to fill up the web browser.  During the setup, please do not try to launch the app yourself, or it will cause extra delay.

# CLI command

You can also launch Unique Bible App from a terminal app by running:

> uba

# Run Unique Bible App in non-fullscreen mode

You can change Unique Bible App main window size via menu: UniqueBible > Window Layout > Window Size.

# Restart Unique Bible App

By default, Unique Bible App is automatically launched when you first log into the web interface.  In case you close it and want to restart it, right click on the webtop and select "Unique Bible App".

# Reload docker container

In case you want to reload the container, run in host terminal:

> docker restart uniquebibleapp

# Additional GUI apps

To facilitate the use of Unique Bible App, we also install a few GUI apps for you, e.g.:

> thunar, gthumb, vlc, geany,vlc

You can launch these apps via command line tools or right-click webtop GUI context menu.

# For developers

To build a docker image from this repository:

> git clone https://github.com/eliranwong/uniquebibleapp-webtop.git

> cd uniquebibleapp-webtop

> docker build -t uniquebibleapp .

# For macOS users ONLY

On macOS, to enable audio or text-to-speech features, 

1) <b>On host macOS terminal, run:</b>

> brew install pulseaudio

> pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon

(One may use the following line to check which shell is being used. recent macOS versions use zsh by default, older versions use bash by default):

> echo $SHELL

(For zsh users)

> echo 'pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon' >> ~/.zshrc

(For bash users)

> echo 'pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon' >> ~/.bash_profile

2) <b>On Arch Linux webtop terminal, run:</b>

> sudo pacman -Syu --noconfirm

> sudo pacman -S --noconfirm pulseaudio

> export PULSE_SERVER=host.docker.internal

> sudo sh -c 'echo "PULSE_SERVER=host.docker.internal" >> /etc/environment'

Read more at https://github.com/eliranwong/ArchLinuxWebtop#setup-audio-macos-users-only

# Uninstall Unique BIble App + webtop

* To remove Unique Bible App docker image

> sudo docker rm -f uniquebibleapp

Check uniquebibleapp image id with:

> sudo docker images

Remove image file

> sudo docker rmi [imageid]

* To remove uniquebibleapp data

It depends on what local path you specified in docker build command, e.g.:

> rm -rf ~/uniquebibleapp-webtop/UniqueBible

* To remove all webtop data

Again, it depends on what local path you specified in docker build command, e.g.:

> rm -rf ~/uniquebibleapp-webtop
