#!/usr/bin/env bash
#gnupg
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

install_gnupg_php() {
    echo "Installing GnuPG for PHP"
    sudo apt-get --assume-yes install libgpgme11-dev
    sudo pecl channel-update pecl.php.net
    sudo pecl install gnupg

	  if [ ! -f ~/gnupg.ini ]; then
        touch ~/gnupg.ini
		    echo "extension=gnupg.so" >> ~/gnupg.ini
	  fi

    sudo cp ~/gnupg.ini /etc/php/7.2/mods-available/gnupg.ini
    sudo cp ~/gnupg.ini /etc/php/7.3/mods-available/gnupg.ini
    sudo cp ~/gnupg.ini /etc/php/7.4/mods-available/gnupg.ini
    sudo phpenmod gnupg
}

install_gnupg_php
