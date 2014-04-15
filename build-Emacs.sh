build() {
    cd ~/emacs
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
}
build
date
