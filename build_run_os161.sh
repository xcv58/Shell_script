mv /usr/local/bin/gccbak /usr/local/bin/gcc
if [ $# -eq 0 ]
then
    echo "No arguments supplied! You should type 0 or 1 or 2 or 3."
else if [[ $@ == [0-3]* ]]
then
    target=${@%%[^0-9]*}
    # target=${@//[^0-9]/}
    target=${target::1}
    target="ASST"$target
    if [[ $1 == *o ]]
    then
        target=$target-OPT
    fi
    echo "Build for" $target
    cd ~/src/kern/conf
    ./config $target > /dev/null
    cd ~/src/kern/compile/$target
    bmake depend > /dev/null
    bmake | sed -e '/mips-harvard-os161.*/d'
    bmake install | tail -n 1
fi
fi
mv /usr/local/bin/gcc /usr/local/bin/gccbak
cd ~/root
if [[ $@ == *rw* ]]
then
    sys161 -w kernel
else if [[ $@ == *r* ]]
then
if [[ $# > 1 ]]
then
    shift
    sys161 kernel $@
else
    sys161 kernel
fi
fi
fi
