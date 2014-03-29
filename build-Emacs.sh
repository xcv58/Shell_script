build() {
    mv /usr/local/bin/gcc /usr/local/bin/gccbak
    cd ~/emacs
    rm ~/.emacsbuildlog
    git pull github master
    git pull origin master
    ./configure --with-ns
    make install
    if [ -d ~/emacs/nextstep/Emacs.app ]
    then
        if [ -d /Applications/EmacsBAK.app ]
        then
            rm -rf /Applications/EmacsBAK.app
        fi
        mv /Applications/Emacs.app /Applications/EmacsBAK.app
        mv ~/emacs/nextstep/Emacs.app /Applications/Emacs.app
    fi
    mv /usr/local/bin/gccbak /usr/local/bin/gcc
}
build
