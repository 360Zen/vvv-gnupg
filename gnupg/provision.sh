#!/usr/bin/env bash
# GnuPGat
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

install_gnupg_php() {
    echo "Installing GnuPG for PHP"
    sudo apt-get --assume-yes install libgpgme11-dev
    sudo pecl channel-update pecl.php.net

    for version in "7.0" "7.1" "7.2" "7.3" "7.4" "8.0"
    do
        if [[ $(command -v php$version) ]]; then
            echo " * Checking GnuPG for PHP ${version}"
            if [ -e "/etc/php/${version}/mods-available/gnupg.ini" ]; then
                echo " * GnuPG PHP v${version} extension is already installed"
            else
                echo " * Installing GnuPG for PHP ${version}"
                sudo pecl -d php_suffix="$version" install gnupg > /dev/null 2>&1
                # do not remove files, only register the packages as not installed so we can install for other php version
                sudo pecl uninstall -r gnupg > /dev/null 2>&1
                cp -f "${DIR}/gnupg.ini" "/etc/php/${version}/mods-available/gnupg.ini"
                phpenmod -v "${version}" gnupg
                echo " * Installed PHP v${version} GnuPG driver"
            fi
        fi
    done

}

install_gnupg_php
