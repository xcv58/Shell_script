remoteupdate() {
    git remote update
}

commit() {
    git add -A
    git commit -m "$input"
}

push() {
    git push --all
}

usage() {
    echo "This script only accept one parameter: absolute path, or related path under current work directory."
}

interactiveCommit() {
    askInputMessage="Need to commit, Please key in command or message:"
    echo $askInputMessage
    read input
    while [[ $input =~ ((git)|(rm)|(vim)|(cat)|(eamcs)|(gdiff)).* ]]
    do
        $input
        echo $askInputMessage
        read input
    done
    echo $"\nYour message for commit:\n$input"
    commit
}

autoCommit() {
    input="Auto commit by script"
    commit
}

update() {
    cd $origin
    if [ -d $1 ]
    then
        cd $1
        targetPath=$PWD
        echo "Process:\n $targetPath"
        cd $targetPath
        if [ -d $targetPath/.git ]
        then
            needCommit=$(git status -s | wc -l)
            if [ $needCommit -gt 0 ]
            then
                if $quiet ; then
                    autoCommit
                else
                    interactiveCommit
                fi
            fi
            # echo $"All done!\nPush to all repositories..."
            push
        else
            echo "$targetPath is not a git repository "
        fi
    else
        echo "$1 is not a directory!"
        usage
    fi
    echo
}

origin=$PWD
quiet=false
while getopts "qh" arg
do
    case $arg in
        h)
            usage
            ;;
        q)
            quiet=true
            ;;
        ?)
            echo "Unknown argument"
            ;;
    esac
    shift
done

if [ $# -ge 1 ]
then
    for i
    do
        update $i $#
    done
else
    update .
fi
