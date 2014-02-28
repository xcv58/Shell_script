GITRESPOSITORY := .git
CWD := $(shell pwd)

pushall:
	if [ -t 1 ] ; then echo terminal; fi
	if [ -d $(GITRESPOSITORY) ];\
	then ls -d $(CWD)/../*/ | xargs -o gupdate;\
	else ls -d $(CWD)/*/ | xargs -o gupdate;\
	fi
