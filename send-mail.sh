sendMail() {
    result=$(tail -2 ~/.emacsbuildlog)
    apikey=$(cat ~/.api/mailgun.apikey)
    read -p "Input the sender: " sender
    read -p "Input the receiver: " receiver
    read -p "Input the subject: " subject
    read -p "Input the text: " text
    curl -s --user "${apikey}" \
         https://api.mailgun.net/v2/xcv58.com/messages \
         -F from="xcv58 <${sender}@xcv58.com>" \
         -F to="${receiver}" \
         -F subject="${subject}" \
         -F text="${text}"
}

sendMail
