#!/bin/sh

platform=`uname`

if [ "`id -u`" = "0" ] ; then
    if [ $platform = 'Linux' ]; then

        cat <<EOF > /etc/apt/sources.list

deb http://ftp.debian.org/debian/ testing main contrib non-free
#deb-src http://ftp.debian.org/debian/ testing main contrib non-free

deb http://security.debian.org/ testing/updates main contrib non-free
#deb-src http://security.debian.org/ testing/updates main contrib non-free
EOF

        apt-get update
        apt-get -y dist-upgrade
	    apt-get -y install make less build-essential python mercurial \
            python-virtualenv vim-nox

    elif [ $platform = 'FreeBSD' ]; then

        # http://mindref.blogspot.com/2012/08/freebsd-makeconf.html
        # http://mindref.blogspot.com/2012/08/freebsd-csup-update.html

        export BATCH=
        make -DBATCH install clean -C /usr/ports/ports-mgmt/portmaster
        make -DEXTRA_ENCODINGS install clean -C /usr/ports/converters/libiconv
        make -DWITHOUT_EXAMPLES install clean -C /usr/ports/lang/python27
        make install clean -C /usr/ports/devel/mercurial
        make install clean -C /usr/ports/devel/py-virtualenv
        make -DWITH_PYTHON -DWITHOUT_X11 -DEXUBERANT_CTAGS install clean -C /usr/ports/editors/vim
        unset BATCH
        rehash

    fi
fi

cat <<EOF > ~/.hgrc
[hostfingerprints]
bitbucket.org = 24:9c:45:8b:9c:aa:ba:55:4e:01:6d:58:ff:e4:28:7d:2a:14:ae:3b
EOF

hg clone https://bitbucket.org/akorn/dotfiles dotfiles
make install -sC dotfiles
