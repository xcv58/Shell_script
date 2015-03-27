projectpath="/Users/xcv58/Work/anomalyrdfgraph/"
cd $projectpath
if [[ $# == 0 ]]
then
    /usr/local/bin/mvn package -e
    exit
fi

runcommand="java -Xmx6g -cp target/anomalyrdfgraph-0.1-SNAPSHOT.jar com.xcv58.anomalyrdfgraph.App"
askInputMessage="Please select dataset:\n
1: Social Only\n
2: Referral Only\n
3: Social + Referral\n
4: NetworkConnections\n
5: temp"
echo $askInputMessage
read inputOption
if [[ $inputOption == 1 ]]; then
    input="/Users/xcv58/Work/anomalyrdfgraph/SNAKE2/SocialGraph.csv"
fi
if [[ $inputOption == 2 ]]; then
    input="/Users/xcv58/Work/anomalyrdfgraph/SNAKE2/ReferralGraph.csv"
fi
if [[ $inputOption == 3 ]]; then
    input="/Users/xcv58/Work/anomalyrdfgraph/SNAKE2/ReferralGraph.csv /Users/xcv58/Work/anomalyrdfgraph/SNAKE2/SocialGraph.csv"
fi
if [[ $inputOption == 4 ]]; then
    input="/Users/xcv58/private/NetworkConnections.csv"
fi
if [[ $inputOption == 5 ]]; then
    input="/Users/xcv58/Work/anomalyrdfgraph/SNAKE2/temp.csv"
fi
# if [[ $@ == h* ]]
# then
# ReferralGraph.csv
# Labels.csv
# SocialGraph.csv
# else
# input="/Users/xcv58/private/NetworkConnections.csv"
# fi
output="out/clusters"
runcommand="$runcommand $input $output"
if [[ $@ == *rw* ]]
then
    if [[ $# > 1 ]]
    then
        shift
        $runcommand $@
    else
        $runcommand
    fi
else if [[ $@ == *r* ]]
     then
         if [[ $# > 1 ]]
         then
             shift
             $runcommand $@
         else
             $runcommand
         fi
     fi
fi
# if [ $# -eq 0 ]
# then
#     echo "No arguments supplied! You should type 0 or 1 or 2 or 3."
# else if [[ $@ == [0-3]* ]]
#      then
#          target=${@%%[^0-9]*}
#          # target=${@//[^0-9]/}
#          target=${target::1}
#          target="ASST"$target
#          if [[ $1 == *o ]]
#          then
#              target=$target-OPT
#          fi
#          echo "Build for" $target
#          cd ~/src/kern/conf
#          ./config $target > /dev/null
#          cd ~/src/kern/compile/$target
#          bmake depend > /dev/null
#          bmake | sed -e '/mips-harvard-os161.*/d'
#          bmake install | tail -n 1
#      fi
# fi

# cd ~/root
# if [[ $@ == *rw* ]]
# then
#     if [[ $# > 1 ]]
#     then
#         shift
#         sys161 -w kernel $@
#     else
#         sys161 -w kernel
#     fi
# else if [[ $@ == *r* ]]
#      then
#          if [[ $# > 1 ]]
#          then
#              shift
#              sys161 kernel $@
#          else
#              sys161 kernel
#          fi
#      fi
# fi
