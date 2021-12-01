#!/bin/bash

cd ~/gitworks/space/netway/develop/billing.netway.co.th

#check ngrok is running
NGROKURL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -Po '"public_url":"https.*?[^\\]",' | cut -d : -f 2,3 | tr -d \",)


# if ngrok is running, i will kill it
if [ -n "$NGROKURL" ]
then
    # stop ngrok service
    echo "Ngrok is running with url $NGROKURL"
    NGROKPID=$(pgrep ngrok)
    kill -9 "$NGROKPID"
    echo "Stoped Ngrok service. (PID=$NGROKPID)"

    #comment content .htaccess
    sed -i 's|\(Substitute\)|#\1|g; s|\(RewriteCond.*\\\.ngrok\\\.io\)|#\1|g; s|\(RewriteRule.*HTTP_X_FORWARDED_HOST\)|#\1|g; s|\(AddOutputFilterByType.*SUBSTITUTE\)|#\1|g;' ~/gitworks/space/netway/develop/billing.netway.co.th/public_html/.htaccess.develop

    #unset apache ENV var
    docker exec -i netway_develop_apache2_1 bash -c "sed -i '/export NGROKURL=/d' /etc/apache2/envvars && service apache2 restart"

    echo "Successful."
    exit 1
# if ngrok is not running, i will wake it up
else
    #start ngrok service
    echo "Ngrok service is not running"
    ./ngrok http -host-header=billing.netway.co.th.develop https://billing.netway.co.th.develop > /dev/null &
    sleep 4
    NGROKURL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -Po '"public_url":"https.*?[^\\]",' | cut -d : -f 2,3 | tr -d \",)
    echo "Started Ngrok service (You can copy the url below to distribute to others.)"
    echo ""
    echo "$NGROKURL"
    echo ""

    #uncomment content in .htaccess
    sed -i 's|#.*\(Substitute\)|\1|g; s|#.*\(RewriteCond.*\\\.ngrok\\\.io\)|\1|g; s|#.*\(RewriteRule.*HTTP_X_FORWARDED_HOST\)|\1|g; s|#.*\(AddOutputFilterByType.*SUBSTITUTE\)|\1|g;' ~/gitworks/space/netway/develop/billing.netway.co.th/public_html/.htaccess.develop

    #inject apache ENV var
    docker exec -i netway_develop_apache2_1 bash -c "echo 'export NGROKURL=$NGROKURL' >> /etc/apache2/envvars && service apache2 restart"

    echo "Successful."
    exit 1
fi


