if [ $# -eq 0 ]
then
    echo "No arguments supplied! You should type 0 or 1 or 2 or 3."
else if [[ $@ == [0-3]* ]]
then
    target=${@%%[^0-9]*}
    # target=${@//[^0-9]/}
    target=${target::1}
    target="ASST"$target
    echo "Build for" $target
    cd ~/src/kern/conf
    ./config $target
    cd ~/src/kern/compile/$target
    bmake depend
    bmake
    bmake install
fi
fi
cd ~/root
if [[ $@ == *rw* ]]
then
    sys161 -w kernel
else if [[ $@ == *r* ]]
then
if [[ $# > 1 ]]
then
    sys161 kernel ${!#}
else
    sys161 kernel
fi
fi
fi
