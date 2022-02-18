# Unique Bible App [weptop version]

Unique Bible App desktop version runs on Arch Linux webtop

We create a docker image to help <a href="https://github.com/eliranwong/UniqueBible">Unique Bible App</a> users to install and run full desktop version with minimum effort.

With <a href="https://www.docker.com">docker</a> installed, you simply need a web browser to access Unique Bible App desktop version, even OFFLINE.

There are other different ways to install Unique Bible App, but setup of essentail packages and dependencies may be challenging to non-technical users.  Therefore, we package and setup everything for you, to save you from all the troubles.

We recommend you to use this webtop version, so you may get the most of our Unique Bible App.  We added some extra features to the webtop version.

Using webtop version of Unique Bible App also gives you a unified experience across different operating systems or platforms, e.g. Windows, macOS (both Intel & Apple chips are supported), ChromeOS, Linux distributions.

On top of our standard docker image, we have customised an additional image for users running macOS with Apple chips, e.g. M1.  You may check our notes below for more details.

# About Unique Bible App

https://github.com/eliranwong/UniqueBible

# About Webtops

By webtop, we mean running desktop or desktop applications on a web browser.

https://www.linuxserver.io/blog/2021-05-05-meet-webtops-a-linux-desktop-environment-in-your-browser

# Install Docker FIRST

If you have not installed docker, install it first!

Docker is cross-platform.  You can run it on Windows, macOS, Linux and ChromeOS.

You may check our notes about docker setup at: https://github.com/eliranwong/ArchLinuxWebtop#setup-docker

Or learn more about docker at https://www.docker.com

# For end-users

With <a href="https://www.docker.com">docker</a> installed FIRST, run:

We provide three different images to suit different users (differences are highlighted in bold below), select one to fit your operation system:

<b>Option (1) - On Apple macOS (Apple chip M1):</b>

Read FIRST at: https://github.com/eliranwong/uniquebibleapp-webtop#for-macos-users-only

> docker run -d --name=uniquebibleapp --security-opt seccomp=unconfined <b>-e PUID=501 -e PGID=20</b> -e TZ=Europe/London -e SUBFOLDER=/ -e KEYBOARD=en-gb-qwerty -p 3000:3000 -v ~/uniquebibleapp-webtop:/config -v /var/run/docker.sock:/var/run/docker.sock <b>-v ~/.config/pulse:/config/.config/pulse</b> --shm-size="1gb" --restart unless-stopped eliranwong/<b>uniquebibleappapplechip</b>

<b>Option (2) - On Apple macOS (Intel chip):</b>

Read FIRST at: https://github.com/eliranwong/uniquebibleapp-webtop#for-macos-users-only

> docker run -d --name=uniquebibleapp --security-opt seccomp=unconfined <b>-e PUID=501 -e PGID=20</b> -e TZ=Europe/London -e SUBFOLDER=/ -e KEYBOARD=en-gb-qwerty -p 3000:3000 -v ~/uniquebibleapp-webtop:/config -v /var/run/docker.sock:/var/run/docker.sock <b>-v ~/.config/pulse:/config/.config/pulse</b> --shm-size="1gb" --restart unless-stopped eliranwong/<b>uniquebibleappaudiotweaked</b>

<b>Option (3) - Other Operation systems (e.g. Windows, Linux, ChomeOS):</b>

A single-line command to setup everything:

> sudo docker run -d --name=uniquebibleapp --security-opt seccomp=unconfined <b>-e PUID=1000 -e PGID=1000</b> -e TZ=Europe/London -e SUBFOLDER=/ -e KEYBOARD=en-gb-qwerty -p 3000:3000 -v ~/uniquebibleapp-webtop:/config -v /var/run/docker.sock:/var/run/docker.sock --shm-size="1gb" --restart unless-stopped eliranwong/<b>uniquebibleapp</b>

Notes:

1) Check host user id, by running the following command and change "-e PUID=1000 -e PGID=1000" if applicable

> id [username]

2) "~/uniquebibleapp-webtop" is the local path for storing webtop home directory.  You may change to suit your own needs. 

# To open Unique Bible App

To run Unique Bible App, simply open the following url in a web browser:

> localhost:3000

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

We also add some GUI apps to Unique Bible App menu, so that users can launch them without going to desktop first.

# For developers

To build a docker image from this repository:

> git clone https://github.com/eliranwong/uniquebibleapp-webtop.git

> cd uniquebibleapp-webtop

> docker build -t uniquebibleapp .

# For macOS users ONLY

On macOS, you need few extra steps to enable audio or text-to-speech features on our webtop, 

Run the following commands on your macOS Terminal app (Applications > Utilities > Terminal.app):

<b>1) Install brew</b>

We use <a href="https://brew.sh/">brew</a> to install pulseaudio for connection macOS speakers to our webtop.

If you haven't installed brew, install it:
  
> /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Install pulseaudio and run it:
  
> brew install pulseaudio

<b>2) Run pulseaudio</b>

> pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon

<b>3) Auto-run pulseaudio for future startup</b>

Depends on your macOS default SHELL, use only one of the following two commands:

(For zsh users)

> echo 'pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon' >> ~/.zshrc

(For bash users)

> echo 'pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon' >> ~/.bash_profile

<b>About SHELL mentioned above:</b>

Recent macOS versions use zsh by default, older versions use bash by default.  If you are not sure, run the following command to check:

> echo $SHELL

Read more at https://github.com/eliranwong/ArchLinuxWebtop#setup-audio-macos-users-only

# Uninstall Unique Bible App

* To uninstall Unique Bible App ONLY

You can use file manager thunar to delete folder "~/uniquebibleapp-webtop/UniqueBible"

Or run in terminal:

> rm -rf ~/uniquebibleapp-webtop/UniqueBible

This line above depends on what local path you specified in docker build command, e.g.:

# Reinstall Unique Bible App

To re-install Unique Bible App without uninstalling webtop, simply uninstall it and restart docker container "uniquebibleapp".

When container docker restarts "uniquebibleapp" and find that /config/uniquebibleapp-webtop/UniqueBible does not exist, it reinstall Unique Bible App for you.

# Uninstall Everything

* To remove all webtop data

> rm -rf ~/uniquebibleapp-webtop

Again, this line above depends on what local path you specified in docker build command, e.g.:

* To remove Unique Bible App docker image

> sudo docker rm -f uniquebibleapp

* Check uniquebibleapp image id with:

> sudo docker images

* Remove image file

> sudo docker rmi [imageid]
