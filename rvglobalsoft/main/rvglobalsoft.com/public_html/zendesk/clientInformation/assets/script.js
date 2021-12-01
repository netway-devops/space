var socket      = io('https://server2.rvglobalsoft.com:3004');
var oRv     = new RvClient;

// Usage {{#ifvalue variable equals="image"}}
Handlebars.registerHelper("ifvalue", function(conditional, options) {
    if (conditional == options.hash.equals) {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
});

// Initialise the Zendesk JavaScript API client
// https://developer.zendesk.com/apps/docs/apps-v2
var client = ZAFClient.init();
client.invoke('resize', { width: '100%', height: '400px' });

var ticketRequester     = client.get('ticket.requester');
ticketRequester.then(function (data) {
   // debug(data);
    
    var requester       = data['ticket.requester'];
    oRv.email       = (requester.email !== undefined) ? requester.email : '';
    if (oRv.email !== '') {
        $('.searchKeyword').val(oRv.email);
        oRv.keyword = oRv.email;
        oRv.getClient();
    }
});

var instanceNavbar      = client.get('instances').then( function (instancesData) {
    var instances       = instancesData.instances;
    for (var instanceGuid in instances) {
        if (instances[instanceGuid].location === 'nav_bar') {
            return client.instance(instanceGuid);
        }
    }
});

instanceNavbar.then( function (navBar) {
    navBar.invoke('preloadPane');
});

var instanceTopbar      = client.get('instances').then( function (instancesData) {
    var instances       = instancesData.instances;
    for (var instanceGuid in instances) {
        if (instances[instanceGuid].location === 'top_bar') {
            return client.instance(instanceGuid);
        }
    }
});

instanceTopbar.then( function (topBar) {
    topBar.invoke('preloadPane');
});


oRv.showSearchBox();

socket.on('getClient', function (data) {
    data        = JSON.parse(data);
   
    
    var oData   = (data.data !== undefined) ? data.data : {};
    $.get({ url : 'templates/clients.html', cache : false }, function (result) {
        var template    = Handlebars.compile(result);
        var result      = template(oData);
        $('#clientsBox').html(result);
        
        if (oData.client.id !== undefined) {
            oRv.getClientDetail(oData.client.id);
        }
        
    });
    
});

socket.on('getClientDetail', function (data) {
    data        = JSON.parse(data);
    
    
    var oData   = (data.data !== undefined) ? data.data : {};
    $.get({ url : 'templates/client_detail.html', cache : false }, function (result) {
        var template    = Handlebars.compile(result);
        var result      = template(oData);
        $('#clientDetailBox').html(result);
        oRv.clientDetailShow();
        oRv.getClientService();
        oRv.getClientOrders();
        oRv.getClientInvoice();
        
    });
    
});

socket.on('getClientService', function (data) {
    data        = JSON.parse(data);
    debug(data);
    
    var oData   = (data.data !== undefined) ? data.data : {};
    $.get({ url : 'templates/client_service.html', cache : false }, function (result) {
        var template    = Handlebars.compile(result);
        var result      = template(oData);
        $('#clientServiceBox').html(result);
    });
    
});

socket.on('getClientOrders', function (data) {
    data        = JSON.parse(data);
    debug(data);
    
    var oData   = (data.data !== undefined) ? data.data : {};
    $.get({ url : 'templates/client_order.html', cache : false }, function (result) {
        var template    = Handlebars.compile(result);
        var result      = template(oData);
        $('#clientOrderBox').html(result);
    });
    
});

socket.on('getClientInvoice', function (data) {
    data        = JSON.parse(data);
    debug(data);
    
    var oData   = (data.data !== undefined) ? data.data : {};
    $.get({ url : 'templates/client_invoice.html', cache : false }, function (result) {
        var template    = Handlebars.compile(result);
        var result      = template(oData);
        $('#clientInvoiceBox').html(result);
    });
    
});



function debug (data)
{
    /*
    console.dir(data);
    $('#consoleBox').prepend('<pre>'+ JSON.stringify(data, null, 2) +'</pre><hr />');
    */
}