usage() {
    echo "Please type the dot file."
    exit
}
if [[ $# == 0 ]]; then
    usage
fi
origin=$1
if [ -f $origin ]; then
    target=${origin%.*}.pdf
    dot $origin -Tpdf -o $target
    # open $target
else
    echo File $origin doesn\'t exist or has other issue.
fi
