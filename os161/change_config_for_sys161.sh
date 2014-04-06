usage() {
    echo "You should type 1-6 as argument."
    echo "1 means 512kb"
    echo "2 means 1Mb"
    echo "3 means 2Mb"
    echo "4 means 4Mb"
    echo "5 means 8Mb"
    echo "6 means 16Mb"
}
if [[ $@ == [0-6] ]]
then
    cp ~/root/sys161$@ ~/root/sys161.conf
else
    usage
fi
