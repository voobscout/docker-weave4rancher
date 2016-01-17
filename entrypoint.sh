#!/bin/bash
set -e
if [ "$1" = 'weave' ]; then

    if [ -d /entrypoint.d ]; then
        for f in /entrypoint.d/*.sh; do
            [ -f "$f" ] && . "$f"
        done
    fi

    weave_dir="/opt/bin"
    weave_binary="/opt/bin/weave"
    weave_url="git.io/weave"

    weave_install() {
        curl -L ${weave_url} -o ${weave_binary}
        chmod +x ${weave_binary}
    }

    mk_bin_dir() {
        mkdir -p ${weave_dir}
        weave_install
    }


    [ -d /opt/bin ] && weave_install || mk_bin_dir

    logger -t WEAVE.WORKS -s "installed binary..."

    if ! [ -r /opt/weave.auth ]; then
        echo $(< /dev/urandom tr -dc A-Za-z0-9 | head -c16 ; echo) > /opt/weave.auth
    fi

    WEAVE_PASSWORD=$(cat /opt/weave.auth)
    /opt/bin/weave launch --ipalloc-range "$2" --password "$WEAVE_PASSWORD"
else
    exec "$@"
fi
