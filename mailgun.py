#!/usr/bin/env python
import os, subprocess, time

import click

API_URL='https://api.mailgun.net/v3/xcv58.com/messages'

def load_api():
    f = file(os.path.expanduser('~/.api/mailgun.apikey'), 'r')
    return f.readline().rstrip()

@click.command()
@click.option('--key', help='api key for mailgun')
@click.option('--sender', default='i@xcv58.com', help='sender email address')
@click.option('--to', '-t', prompt='receiver email', help='receiver email address')
@click.option('--subject', '-s', default='no subject', prompt='subject', help='email subject')
@click.option('--content', '-c', default='', help='email content')
def send(key, sender, to, subject, content):
    if not key:
        key = load_api()
    content += time.strftime("%H:%M:%S")
    command = 'curl -s --user %s %s -F from=%s -F to=%s -F subject=%s -F text=%s' % (key, API_URL, sender, to, subject, content)
    print command
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in p.stdout.readlines():
        print line,
        retval = p.wait()


if __name__ == '__main__':
    send()
