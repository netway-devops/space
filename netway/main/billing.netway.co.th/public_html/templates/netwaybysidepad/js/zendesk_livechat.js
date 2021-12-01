function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

zE(function() {
    
    if (typeof oClient !== 'undefined' && oClient.hasOwnProperty('email') && oClient.email != '') {
        zE.identify({
            name    : oClient.name,
            email   : oClient.email
        });
    }
    
});

zChat.init({
    account_key: '4ZseMHW6vmOik7SGmfrDQUTK88zVOOsB'
});

zChat.on('connection_update', function(eventData) {
    if (eventData == 'connected') {
        var oVisitor    = zChat.getVisitorInfo();
        var ctr         = getCookie('client_time_ref');
        
        $.getJSON('https://netway.co.th/?cmd=zendeskhandle&action=getClientInfo&ctr='+ ctr, function (data) {
            if (oVisitor.email != data.email) {
                var name        = data.name;
                var email       = data.email;
                if (! email) {
                    name        = '';
                    email       = '';
                }
                var visitorInfo = {
                    display_name : name,
                    email        : email
                };
                zChat.setVisitorInfo(visitorInfo, function(err) {  });
            }
            
        });
        
    }
});
