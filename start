#!/bin/bash
set -e

case "$1" in
  install)
    echo "Installing skype..."
    install -m 0755 /scripts/skype /target/
    ;;
  uninstall)
    echo "Uninstalling skype..."
    rm -rf /target/skype
    ;;
  bash)
    exec $@
    ;;
  *)
    # uid and gid of host user
    USER_UID=${USER_UID:-1000}
    USER_GID=${USER_GID:-1000}

    # create user group
    if ! getent group ${SKYPE_USER} >/dev/null; then
      groupadd -f -g ${USER_GID} ${SKYPE_USER} >/dev/null 2>&1
    fi

    # create user with uid and gid matching that of the host user
    if ! getent passwd ${SKYPE_USER} >/dev/null; then
      adduser --disabled-login --uid ${USER_UID} --gid ${USER_GID} \
        --gecos 'Skype' ${SKYPE_USER} >/dev/null 2>&1
    fi

    # grant access to video devices
    for device in /dev/video*
    do
      if [[ -c $device ]]; then
        VIDEO_GID=$(stat -c %g $device)
        break
      fi
    done

    if [[ -n $VIDEO_GID ]]; then
      usermod -a -G $VIDEO_GID ${SKYPE_USER}
    fi

    # take ownership
    chown ${SKYPE_USER}:${SKYPE_USER} -R /home/${SKYPE_USER}

    # launch application as ${SKYPE_USER}
    cd /home/${SKYPE_USER}
    exec sudo -u ${SKYPE_USER} -H PULSE_SERVER=/run/pulse/native QT_GRAPHICSSYSTEM="native" $@
    ;;
esac
