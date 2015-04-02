#!/usr/bin/python
import os, subprocess

base_dir = os.path.dirname(os.path.realpath(__file__))
target_dir = '/usr/local/bin'
alias_file = os.path.join(os.path.expanduser("~"), '.zshrc_scpt_alias.zsh')
ALIAS = 'alias '

def link(file):
    origin_file = os.path.join(base_dir, file)
    target_file = os.path.join(target_dir, file)
    command = 'ln -sf %s %s' % (origin_file, target_file)
    alias = 'alias %s="osascript %s"\n' % (os.path.splitext(file)[0], target_file)
    print command
    subprocess.check_call(command, shell=True)
    return alias

def flush(lines, f):
    for line in lines:
        f.write(line)
    return

def getdict(alias_list):
    return dict([(i.split('=')[0].split(' ')[1], i) for i in alias_list])

def getFileLines(file):
    if os.path.isfile(file):
        f = open(file, 'r')
        lines = f.readlines()
        f.close()
    else:
        lines = []
        pass
    return lines


def alias(alias_list):
    print 'update %s' % alias_file
    lines = getFileLines(alias_file)

    origin_alias_list = [i for i in lines if i.startswith(ALIAS)]
    other_command = [i for i in lines if not i.startswith(ALIAS)]

    alias_dict = getdict(origin_alias_list)
    alias_dict.update(getdict(alias_list))

    new_alias_list = sorted([alias_dict[i] for i in alias_dict])

    f = open(alias_file, 'w')
    flush(other_command, f)
    flush(new_alias_list, f)
    f.close()
    return

def main(suffix):
    alias_list = []
    for (dirpath, dirnames, filenames) in os.walk(base_dir):
        for file in [i for i in filenames if i.endswith(suffix)]:
            one_alias = link(file)
            alias_list.append(one_alias)
            pass
        pass
    alias(alias_list)
    return

main('.scpt')
main('.applescript')
