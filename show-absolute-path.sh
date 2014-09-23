SCRIPT_FILE=`which $0`
if [ -L $SCRIPT_FILE ]; then
    SCRIPT_FILE=`readlink $SCRIPT_FILE`
fi
SCRIPT_PATH=`dirname $SCRIPT_FILE`
SCRIPT_FILE=`basename $SCRIPT_FILE`
echo Path: $SCRIPT_PATH
echo Filename: $SCRIPT_FILE
