#! /usr/bin/python
import quip
import datetime
import sys
import re
from os.path import expanduser
if len(sys.argv) <= 1:
    print "Please input arguments"
    exit()

HOME = expanduser("~")
ACCESS_TOKEN = open(HOME + "/.api/quip.apikey", 'r').read().split('\n')[0]
THREAD_ID="AYWAAAC1CSQ"

try:
    client = quip.QuipClient(access_token=ACCESS_TOKEN)
    user = client.get_authenticated_user()

    record = " ".join(sys.argv[1:])
    date = datetime.date.today().strftime('%Y%m%d')

    thread = client.get_thread(THREAD_ID)
    line = [line for line in thread["html"].split('\n') if line != ""][1]
    title_scetion_id = line.split('\'')[1]
    m = re.search('20\d{6}', line)
    if m and m.group(0) == date:
        content = "<p>" + record + "</p>"
        edit_mode = 2
    else:
        content = "<p class='line'>" + date + "</p><p>" + record + "</p><p> </p>"
        edit_mode = 3
    client.edit_document(THREAD_ID, content, edit_mode, "html", title_scetion_id)
    print date, record
except:
    print "Failed"
