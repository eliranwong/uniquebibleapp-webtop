# Unique Bible App [weptop version]

Unique Bible App desktop version runs on Arch Linux webtop

We create a docker image to help <a href="https://github.com/eliranwong/UniqueBible">Unique Bible App</a> users to install and run full desktop version with minimum effort.

With <a href="https://www.docker.com">docker</a> installed, you simply need a web browser to access Unique Bible App desktop version, even OFFLINE.

# Recommended

We recommend our users to use this webtop version for running Unique Bible App, so they may get the most of our Unique Bible App.  We integrated some extra features to the webtop version, e.g. Google text-to-speech feature, menu to desktop GUI applications.

There are other different ways to install Unique Bible App, but setup of essentail packages and dependencies may be challenging to non-technical users.  Therefore, we package and setup everything for you, to save you from all the troubles.

Using webtop version of Unique Bible App also gives you a unified experience across different operating systems or platforms, e.g. Windows, macOS (both Intel & Apple chips are supported), ChromeOS, Linux distributions.

On top of our standard docker image, we have customised an additional image for users running macOS with Apple chips, e.g. M1.  You may check our notes below for more details.

# Screenshot

<img width="1440" alt="Screenshot 2022-02-18 at 19 09 09" src="https://user-images.githubusercontent.com/25262722/154747249-adf94293-eaab-43aa-9461-04d4d688b3d1.png">

# About Unique Bible App

https://github.com/eliranwong/UniqueBible

https://github.com/eliranwong/uniquebibleapp-webtop

# About Webtop

By webtop, we mean running desktop or desktop applications on a web browser.

https://www.linuxserver.io/blog/2021-05-05-meet-webtops-a-linux-desktop-environment-in-your-browser

# Storage Size

You need 12GB on your computer to install our webtop version.

Yes, it is huge, because we try our best to package everything for you.

# Examples of Installation on Different Platforms

* <a href="https://github.com/eliranwong/UniqueBible/wiki/UniqueBibleApp-webtop-on-Windows">Windows</b>, <a href="https://github.com/eliranwong/UniqueBible/wiki/UniqueBibleApp-webtop-on-macOS">macOS</a>, <a href="https://github.com/eliranwong/UniqueBible/wiki/UniqueBibleApp-webtop-on-Chrome-OS">Chrome OS</a>, <a href="https://github.com/eliranwong/UniqueBible/wiki/UniqueBibleApp-webtop-on-Linux">Linux</a>

# Install Docker FIRST

If you have not installed docker, install it first!

Docker is cross-platform.  You can run it on Windows, macOS, Linux and ChromeOS.

You may check our notes about docker setup at: https://github.com/eliranwong/ArchLinuxWebtop#setup-docker

Or learn more about docker at https://www.docker.com

# For end-users

We provide three different images to suit different users (differences are highlighted in bold below), select one to fit your operation system:

With <a href="https://www.docker.com">docker</a> installed FIRST, run:

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

2) "\~/uniquebibleapp-webtop" is the local path for storing webtop home directory.  You may change to suit your own needs. For example, you can change it to "\~/Documents" so that your webtop home directory matches and shares your Documents folder, located in your host home directory.  However, do not use "\~/", which means your home directory, because your host home directory may have files of the same filenames as those in the webtop home directory, e.g. .bashrc.

3) You only need to execute one of the three options above, according to your computer operation system.

4) This command is for setup ONLY.  You only need to excecute this ONCE.

# To open Unique Bible App

To run Unique Bible App, simply open the following url in a web browser:

> localhost:3000

<b>It takes extra time when Unique Bible App runs the first time</b> before you can load "localhost:3000", as the first run downloads and sets up Unique Bible App latest version.  The first time "localhost:3000" is loaded, you may see a Terminal app opened and running the setup process.  Please expect to wait for around 10 minutes for the setup.  <b>This applies to the first run ONLY</b>.  When the setup is finished, Unique Bible App will automatically launch.  During the setup, please do <b>NOT</b> try to launch the app manually, or it will cause extra delay.

# Touble-shooting "Can't open the page localhost:3000"

You can open localhost:3000 only when docker is running.

Some OSs autostarts docker but some does not.

For example, on macOS, you need to open "Docker Desktop" first before you can open localhost:3000.

# CLI command

You can also launch Unique Bible App from a terminal app by running:

> uba

# Access Unique Bible App Files

If you want to add bibles or some other resources manually to Unique Bible App, you may want to know where is the UniqueBible folder.

If you follow our suggestions in https://github.com/eliranwong/uniquebibleapp-webtop#for-end-users

Unique Bible App is installed in home directory on both host os and webtop.

With web browser, you can access the files in /config/UniqueBible/ with file manager Thunar.

You can also use your host file manager to access the "UniqueBibleApp" folder, located in your home directory.

# Toggle Webtop fullscreen view

Click the sidemenu button [a black dot], you can find a button to toggle the whole webtop in fullscreen view.

# Toggle Unique Bible App fullscreen view

You can change Unique Bible App main window size via menu: UniqueBible > Window Layout > Window Size.

Alternately, use keyboard key combo "Ctrl + Shift + U" to toggle fullscreen view.

From version 28.07, Unique Bible App added a button on toolbar for users to toggle fullscreen view easily.

# Restart Unique Bible App

By default, Unique Bible App is automatically launched when you first log into the web interface.  In case you close it and want to restart it, right click on the webtop and select "Unique Bible App".

# Reload docker container

In case you want to reload the container, run in host terminal:

> docker restart uniquebibleapp

# Input Method & GUI Applications & Window Manager

To facilitate the use of Unique Bible App, we also setup an input method, fcitx, and a few GUI apps, e.g.:

> thunar, gthumb, vlc, geany, vlc

You can launch these apps via command line tools or right-click webtop GUI context menu.

From version 28.07 onwards, we added GUI apps shortcuts to Unique Bible App menu, so that users can launch them without going to desktop first.

Keyboard shortcuts is avilalble to individual apps, e.g. control+M to hide/show Thunar's menu bar.

If key combination is same as the host OS, you need to use the virtual keyboard to trigger key combo on webtop.  For example, on macOS, you can use option+TAB to switch between apps on webtop and command+TAB to switch between apps opened on host OS.  On Chrome OS, however, you need to use the virtual keyboard, via the sidemenu button, to trigger alt+TAB, as triggering alt+TAB on physical keyboard switches between apps opened on host OS.

Our webtop uses Openbox as the window manager to handle window applications, like Unique Bible App.  You can use key combo, e.g. to switch between four virtual desktops or applications.  For example, alt+ESCAPE could be useful when you want to view other applications opened and placed behind Unique Bible App, which is running in fullscreen view.  You may refer to https://wiki.debian.org/Openbox#Openbox_default_key_combinations for common key combinations on Openbox.

We changed a openbox keyboard binding from "Alt + Tab" to "Ctrl + Alt + Tab" for switching opened applications, to avoid being overrided by the same key binding used by host OS.

For more about autostart in Openbox, read http://openbox.org/wiki/Help:Autostart 

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

# Uninstall Unique Bible App

* To uninstall Unique Bible App ONLY

You can use file manager thunar to delete folder "/config/uniquebibleapp-webtop/UniqueBible"

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
