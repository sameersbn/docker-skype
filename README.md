# Table of Contents

- [Introduction](#introduction)
- [Contributing](#contributing)
- [Installation](#installation)
- [How it works](#how-it-works)
- [Limitations](#limitations)
- [Upgrading](#upgrading)
- [Uninstallation](#uninstallation)

# Introduction

Dockerized skype with voice call support via pulseaudio and does not required any complicated setup.

The image does require pulseaudio for audio support which is installed on all major linux distributions out of the box.

# Contributing

If you find this image useful here's how you can help:

- Send a Pull Request with your awesome new features and bug fixes
- Help new users with [Issues](https://github.com/sameersbn/docker-skype/issues) they may encounter
- Send me a tip via [Bitcoin](https://www.coinbase.com/sameersbn) or using [Gratipay](https://gratipay.com/sameersbn/)

# Installation

Install the wrapper scripts using:

```bash
docker run -it --rm -v /usr/local/bin:/target \
sameersbn/skype:latest install
```

This will install wrapper scripts to launch `skype`

**If skype is installed on the host, then the host skype is executed and the docker image is not started.**

# How it works

The wrapper scripts volume mount the X11 and pulseaudio sockets in the launcher container. The X11 socket allows for the user interface display on the host, while the pulseaudio socket allows for the audio output to be rendered on the host.

When the image is launched the following directories are mounted as volumes

 - `${HOME}/.Skype`
 - `${HOME}/Downloads`

This makes sure that your profile details are stored on the host and files received via Skype are available on your host.

# Limitations

- Video calls do not work
- Minimize to system tray does not work.

# Upgrading

To upgrade to newer releases, simply update the image

```
docker pull sameersbn/skype:latest
```

# Uninstallation

```bash
docker run -it --rm -v /usr/local/bin:/target \
sameersbn/skype:latest uninstall
```
