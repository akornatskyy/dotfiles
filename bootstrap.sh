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
	    apt-get -y install make less build-essential python python-dev \
            mercurial python-virtualenv vim-nox

    elif [ $platform = 'FreeBSD' ]; then

        # http://mindref.blogspot.com/2012/08/freebsd-makeconf.html
        # http://mindref.blogspot.com/2012/08/freebsd-csup-update.html

        export BATCH=
        [ -z "`pkg_info | grep portmaster`" ] && make -DBATCH install clean -sC /usr/ports/ports-mgmt/portmaster
        [ -z "`pkg_info | grep libiconv`" ] && make -DEXTRA_ENCODINGS install clean -sC /usr/ports/converters/libiconv
        [ -z "`pkg_info | grep python27`" ] && make -DWITHOUT_EXAMPLES install clean -sC /usr/ports/lang/python27
        [ -z "`pkg_info | grep mercurial`" ] && make install clean -sC /usr/ports/devel/mercurial
        [ -z "`pkg_info | grep virtualenv`" ] && make -DWITHOUT_DOCS install clean -sC /usr/ports/devel/py-virtualenv
        [ -z "`pkg_info | grep vim`" ] && make -DWITH_PYTHON -DWITHOUT_X11 -DEXUBERANT_CTAGS install clean -sC /usr/ports/editors/vim
        unset BATCH

    fi
fi

rm -f ~/.hgrc
cat <<EOF > ~/.hgrc
[hostfingerprints]
bitbucket.org = 24:9c:45:8b:9c:aa:ba:55:4e:01:6d:58:ff:e4:28:7d:2a:14:ae:3b
EOF

rm -rf dotfiles
hg clone -q https://bitbucket.org/akorn/dotfiles dotfiles
make install -sC dotfiles
