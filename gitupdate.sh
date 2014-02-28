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
    push
}

update() {
    # ls -d $PWD/*/
    if [ -d $1 ]
    then
        cd $1
        targetPath=$PWD
        echo $targetPath
        cd $targetPath
        if [ -d $targetPath/.git ]
        then
            # remoteupdate
            needCommit=$(git status -s | wc -l)
            if [ $needCommit -gt 0 ]
            then
                interactiveCommit
            fi
            echo $"All done!\nPush to all repositories..."
            push
        else
            echo "$targetPath is not a git repository "
        fi
    else
        echo "$1 is not a directory!"
    fi
    echo
}

if [ $# -ge 1 ]
then
    for i
    do
    echo "Processing: $i"
    update $i
    done
else
    usage
fi
