command="/usr/bin/ssh -C -N -c blowfish -o ServerAliveInterval=3 -o ExitOnForwardFailure=yes doReverse_`hostname -s`"
${command}
