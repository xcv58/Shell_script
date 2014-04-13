config_file=~/root/sys161.conf
prefix="31	mainboard	ramsize="
max=16
min=0.3

usage() {
    echo "You should type one or two number as argument."
    echo "Minimum memory is 0.3Mb, Maximum memory is 16Mb."
    echo " 1  :memory size   1 Mb"
    echo " 2  :memory size   2 Mb"
    echo " 16 :memory size  16 Mb"
    echo " 0 5:memory size 0.5 Mb"
    echo " 1.1:memory size 1.1 Mb"
    echo " 1 1:memory size 1.1 Mb"
    echo " 2 2:memory size 2.2 Mb"
    exit
}

count_memory() {
    if [ $(echo "$result > $max" | bc) -ne 0 ]
    then
	echo "Memory is too large."
	usage
    fi
    if [ $(echo "$result < $min" | bc) -ne 0 ]
    then
	echo "Memory is too small."
	usage
    fi
    echo "Use $result Mb memory."
    result=$(echo "$result*1024" | bc)
    result=${result/.*}
    result=$(echo "(($result + 3)/4)*4" | bc)
    result=$(echo "$result*1024" | bc)
    result=$prefix$result
}

update_config() {
    sed -ig "s/^[[:space:]]*31.*ramsize=[0-9]*/$result/" $config_file
}

if [[ $# = 0 ]]
then
    echo "No argument"
    usage
fi
if [[ $# = 1 ]]
then
    result=$@
fi
if [[ $# = 2 ]]
then
    result=$1.$2
fi
if [[ $# > 2 ]]
then
    usage
fi
count_memory
update_config
# Uncomment below line if you wanna run your kernel immediately.
# cd ~/root/ && sys161 kernel
