#!/bin/bash

function main {
    if [ "$1" != "apache2ctl" ]; then
        args=$(getopt -n "$(basename $0)" -o h --long help,debug,version -- "$@")
        eval set --"$args"
        while true; do
            case "$1" in
                -h | --help ) print_usage; shift ;;
                --debug ) DEBUG=true; shift ;;
                --version ) print_version; shift ;;
                --) shift ; break ;;
                * ) break ;;
            esac
        done
        shift $((OPTIND-1))
        apache_config
        exec apache2ctl -D FOREGROUND
    else
        apache_config
        exec "$@"
    fi
}

function print_usage {
cat << EOF
Usage: "$(basename $0)" [Options]... [Vhosts]...
  -h  --help     display this help and exit
      --debug    output debug information
      --version  output version information and exit
E-mail bug reports to: <developer@wilke.systems>.
EOF
exit
}

function print_version {
cat << EOF
MIT License
Copyright (c) 2017 Wilke.Systems
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
exit
}

function apache_config {
    [ "$DEBUG" = "true" ] && set -x

    if [ ! -z "$APACHE2_GID" -a -z "${APACHE2_GID//[0-9]/}" -a "$APACHE2_GID" != "$(id --group www-data)" ]; then
        groupmod -g $APACHE2_GID www-data
    fi

    if [ ! -z "$APACHE2_UID" -a -z "${APACHE2_UID//[0-9]/}" -a "$APACHE2_UID" != "$(id --user www-data)" ]; then
        usermod -u $APACHE2_UID www-data
    fi

    if [ -d /etc/docker-entrypoint.d ]; then
        for APACHE2_PACKAGE in /etc/docker-entrypoint.d/*.tar.gz; do
            tar xfz $APACHE2_PACKAGE -C /
        done
    fi
}

main "$@"
