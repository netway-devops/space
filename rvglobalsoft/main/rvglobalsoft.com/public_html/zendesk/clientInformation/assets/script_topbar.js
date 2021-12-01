var socket      = io('https://server2.rvglobalsoft.com:3004');
var oRv         = new RvInfo;

// Initialise the Zendesk JavaScript API client
// https://developer.zendesk.com/apps/docs/apps-v2
var client = ZAFClient.init();
client.invoke('resize', { width: '1000px', height: '500px' });


client.on('showClientDetail', function() {
    var currentClientId     = localStorage.getItem('rvClientId');
    var aClients    = JSON.parse(localStorage.getItem('rvClients'));
    debug({currentClientId: currentClientId, aClients: aClients});
    
    $.each(aClients, function( index, clientId ) {
        var tab     = $('#rvTabs').find('div#tabClientId'+ clientId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabClientId'+ clientId +'" class="item"><a href="javascript:void(0);" onclick="changeTabClient('+ clientId +');">'
            + '<i class="icon user"></i>#'+ clientId +' &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabClient('+ clientId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentClientId'+ clientId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=clients&action=show&id='+ clientId +'" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabClient(currentClientId);
    
});

function changeTabClient (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabClientId'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentClientId'+ id).addClass('active');
}

function closeTabClient (id)
{
    var aClients    = JSON.parse(localStorage.getItem('rvClients'));
    aClients        = _.without(aClients, id);
    localStorage.setItem('rvClients', JSON.stringify(aClients));
    $('#rvTabs div#tabClientId'+ id).remove();
    $('div#tabContentClientId'+ id).remove();
    activeFirstTab();
}

client.on('listClientDomain', function() {
    var currentClientId     = localStorage.getItem('rvClientDomainId');
    var aClients    = JSON.parse(localStorage.getItem('rvClientDomains'));
    debug({currentClientId: currentClientId, aClients: aClients});
    
    $.each(aClients, function( index, clientId ) {
        var tab     = $('#rvTabs').find('div#tabClientDomain'+ clientId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabClientDomain'+ clientId +'" class="item"><a href="javascript:void(0);" onclick="changeTabClientDomain('+ clientId +');">'
            + '<i class="icon List Layout"></i>#'+ clientId +' Domains &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabClientDomain('+ clientId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentClientDomain'+ clientId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=domains&action=clientdomains&id='+ clientId +'&zat=true" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabClientDomain(currentClientId);
    
});

function changeTabClientDomain (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabClientDomain'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentClientDomain'+ id).addClass('active');
}

function closeTabClientDomain (id)
{
    var aClients    = JSON.parse(localStorage.getItem('rvClientDomains'));
    aClients        = _.without(aClients, id);
    localStorage.setItem('rvClientDomains', JSON.stringify(aClients));
    $('#rvTabs div#tabClientDomain'+ id).remove();
    $('div#tabContentClientDomain'+ id).remove();
    activeFirstTab();
}

client.on('showDomainDetail', function() {
    var currentDomainId     = localStorage.getItem('rvDomainId');
    var aDomains    = JSON.parse(localStorage.getItem('rvDomains'));
    debug({currentDomainId: currentDomainId, aDomains: aDomains});
    
    $.each(aDomains, function( index, domainId ) {
        var tab     = $('#rvTabs').find('div#tabDomainId'+ domainId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabDomainId'+ domainId +'" class="item"><a href="javascript:void(0);" onclick="changeTabDomain('+ domainId +');">'
            + '<i class="icon genderless"></i>#'+ domainId +' &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabDomain('+ domainId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentDomainId'+ domainId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=domains&action=edit&id='+ domainId +'&zat=true" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabDomain(currentDomainId);
    
});

function changeTabDomain (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabDomainId'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentDomainId'+ id).addClass('active');
}

function closeTabDomain (id)
{
    var aDomains    = JSON.parse(localStorage.getItem('rvDomains'));
    aDomains        = _.without(aDomains, id);
    localStorage.setItem('rvDomains', JSON.stringify(aDomains));
    $('#rvTabs div#tabDomainId'+ id).remove();
    $('div#tabContentDomainId'+ id).remove();
    activeFirstTab();
}

client.on('listClientDomain', function() {
    var currentClientId     = localStorage.getItem('rvClientDomainId');
    var aClients    = JSON.parse(localStorage.getItem('rvClientDomains'));
    debug({currentClientId: currentClientId, aClients: aClients});
    
    $.each(aClients, function( index, clientId ) {
        var tab     = $('#rvTabs').find('div#tabClientDomain'+ clientId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabClientDomain'+ clientId +'" class="item"><a href="javascript:void(0);" onclick="changeTabClientDomain('+ clientId +');">'
            + '<i class="icon List Layout"></i>#'+ clientId +' Domains &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabClientDomain('+ clientId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentClientDomain'+ clientId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=domains&action=clientdomains&id='+ clientId +'&zat=true" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabClientDomain(currentClientId);
    
});

function changeTabClientDomain (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabClientDomain'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentClientDomain'+ id).addClass('active');
}

function closeTabClientDomain (id)
{
    var aClients    = JSON.parse(localStorage.getItem('rvClientDomains'));
    aClients        = _.without(aClients, id);
    localStorage.setItem('rvClientDomains', JSON.stringify(aClients));
    $('#rvTabs div#tabClientDomain'+ id).remove();
    $('div#tabContentClientDomain'+ id).remove();
    activeFirstTab();
}

client.on('listClientAccount', function() {
    var currentClientId     = localStorage.getItem('rvClientAccountId');
    var aClients    = JSON.parse(localStorage.getItem('rvClientAccounts'));
    debug({currentClientId: currentClientId, aClients: aClients});
    
    $.each(aClients, function( index, clientId ) {
        var tab     = $('#rvTabs').find('div#tabClientAccount'+ clientId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabClientAccount'+ clientId +'" class="item"><a href="javascript:void(0);" onclick="changeTabClientAccount('+ clientId +');">'
            + '<i class="icon List Layout"></i>#'+ clientId +' Accounts &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabClientAccount('+ clientId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentClientAccount'+ clientId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=accounts&action=clientaccounts&id='+ clientId +'&zat=true" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabClientAccount(currentClientId);
    
});

function changeTabClientAccount (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabClientAccount'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentClientAccount'+ id).addClass('active');
}

function closeTabClientAccount (id)
{
    var aClients    = JSON.parse(localStorage.getItem('rvClientAccounts'));
    aClients        = _.without(aClients, id);
    localStorage.setItem('rvClientAccounts', JSON.stringify(aClients));
    $('#rvTabs div#tabClientAccount'+ id).remove();
    $('div#tabContentClientAccount'+ id).remove();
    activeFirstTab();
}

client.on('showAccountDetail', function() {
    var currentAccountId    = localStorage.getItem('rvAccountId');
    var aAccounts   = JSON.parse(localStorage.getItem('rvAccounts'));
    debug({currentAccountId: currentAccountId, aAccounts: aAccounts});
    
    $.each(aAccounts, function( index, accountId ) {
        var tab     = $('#rvTabs').find('div#tabAccountId'+ accountId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabAccountId'+ accountId +'" class="item"><a href="javascript:void(0);" onclick="changeTabAccount('+ accountId +');">'
            + '<i class="icon cube"></i>#'+ accountId +' &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabAccount('+ accountId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentAccountId'+ accountId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=accounts&action=edit&id='+ accountId +'&zat=true" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabAccount(currentAccountId);
    
});

function changeTabAccount (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabAccountId'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentAccountId'+ id).addClass('active');
}

function closeTabAccount (id)
{
    var aAccounts   = JSON.parse(localStorage.getItem('rvAccounts'));
    aAccounts       = _.without(aAccounts, id);
    localStorage.setItem('rvAccounts', JSON.stringify(aAccounts));
    $('#rvTabs div#tabAccountId'+ id).remove();
    $('div#tabContentAccountId'+ id).remove();
    activeFirstTab();
}

client.on('listClientOrder', function() {
    var currentClientId     = localStorage.getItem('rvClientOrderId');
    var aClients    = JSON.parse(localStorage.getItem('rvClientOrders'));
    debug({currentClientId: currentClientId, aClients: aClients});
    
    $.each(aClients, function( index, clientId ) {
        var tab     = $('#rvTabs').find('div#tabClientOrder'+ clientId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabClientOrder'+ clientId +'" class="item"><a href="javascript:void(0);" onclick="changeTabClientOrder('+ clientId +');">'
            + '<i class="icon List Layout"></i>#'+ clientId +' Orders &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabClientOrder('+ clientId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentClientOrder'+ clientId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=orders&action=clientorders&id='+ clientId +'&zat=true" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabClientOrder(currentClientId);
    
});

function changeTabClientOrder (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabClientOrder'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentClientOrder'+ id).addClass('active');
}

function closeTabClientOrder (id)
{
    var aClients    = JSON.parse(localStorage.getItem('rvClientOrders'));
    aClients        = _.without(aClients, id);
    localStorage.setItem('rvClientOrders', JSON.stringify(aClients));
    $('#rvTabs div#tabClientOrder'+ id).remove();
    $('div#tabContentClientOrder'+ id).remove();
    activeFirstTab();
}

client.on('showOrderDetail', function() {
    var currentOrderId      = localStorage.getItem('rvOrderId');
    var aOrders     = JSON.parse(localStorage.getItem('rvOrders'));
    debug({currentOrderId: currentOrderId, aOrders: aOrders});
    
    $.each(aOrders, function( index, orderId ) {
        var tab     = $('#rvTabs').find('div#tabOrderId'+ orderId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabOrderId'+ orderId +'" class="item"><a href="javascript:void(0);" onclick="changeTabOrder('+ orderId +');">'
            + '<i class="icon shop"></i>#'+ orderId +' &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabOrder('+ orderId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentOrderId'+ orderId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=orders&action=edit&id='+ orderId +'" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabOrder(currentOrderId);
    
});

function changeTabOrder (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabOrderId'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentOrderId'+ id).addClass('active');
}

function closeTabOrder (id)
{
    var aOrders     = JSON.parse(localStorage.getItem('rvOrders'));
    aOrders         = _.without(aOrders, id);
    localStorage.setItem('rvOrders', JSON.stringify(aOrders));
    $('#rvTabs div#tabOrderId'+ id).remove();
    $('div#tabContentOrderId'+ id).remove();
    activeFirstTab();
}

client.on('listClientInvoice', function() {
    var currentClientId     = localStorage.getItem('rvClientInvoiceId');
    var aClients    = JSON.parse(localStorage.getItem('rvClientInvoices'));
    debug({currentClientId: currentClientId, aClients: aClients});
    
    $.each(aClients, function( index, clientId ) {
        var tab     = $('#rvTabs').find('div#tabClientInvoice'+ clientId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabClientInvoice'+ clientId +'" class="item"><a href="javascript:void(0);" onclick="changeTabClientInvoice('+ clientId +');">'
            + '<i class="icon List Layout"></i>#'+ clientId +' Invoices &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabClientInvoice('+ clientId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentClientInvoice'+ clientId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/index.php?cmd=invoices&action=clientinvoices&id='+ clientId +'&zat=true" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabClientInvoice(currentClientId);
    
});

function changeTabClientInvoice (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabClientInvoice'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentClientInvoice'+ id).addClass('active');
}

function closeTabClientInvoice (id)
{
    var aClients    = JSON.parse(localStorage.getItem('rvClientInvoices'));
    aClients        = _.without(aClients, id);
    localStorage.setItem('rvClientInvoices', JSON.stringify(aClients));
    $('#rvTabs div#tabClientInvoice'+ id).remove();
    $('div#tabContentClientInvoice'+ id).remove();
    activeFirstTab();
}

client.on('showInvoiceDetail', function() {
    var currentInvoiceId    = localStorage.getItem('rvInvoiceId');
    var aInvoices   = JSON.parse(localStorage.getItem('rvInvoices'));
    debug({currentInvoiceId: currentInvoiceId, aInvoices: aInvoices});
    
    $.each(aInvoices, function( index, invoiceId ) {
        var tab     = $('#rvTabs').find('div#tabInvoiceId'+ invoiceId);
        if (tab.length) {
            return true;
        }
        
        $('#rvTabs').append('<div id="tabInvoiceId'+ invoiceId +'" class="item"><a href="javascript:void(0);" onclick="changeTabInvoice('+ invoiceId +');">'
            + '<i class="icon tag"></i>#'+ invoiceId +' &nbsp; '
            + '<a href="javascript:void(0);" onclick="closeTabInvoice('+ invoiceId +');" class="ui mini right corner label"><i class="remove circle icon"></i></a>'
            + '</a></div>');
        
        var content = '<div id="tabContentInvoiceId'+ invoiceId +'" class="ui bottom attached tab segment tabContent">'
            + '<iframe src="https://rvglobalsoft.com/7944web/?cmd=invoices&action=edit&id='+ invoiceId +'" width="100%" height="400" frameborder="0" vspace="0" hspace="0"></iframe>'
            + '</div>';
        if (! $('div.tabContent').length) {
            $('#rvTabs').after(content);
        } else {
            $('div.tabContent:last').after(content);
        }
        
    });
    
    client.invoke('popover', 'show');
    changeTabInvoice(currentInvoiceId);
    
});

function changeTabInvoice (id)
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div#tabInvoiceId'+ id).addClass('active');
    $('div.tabContent').removeClass('active');
    $('div#tabContentInvoiceId'+ id).addClass('active');
}

function closeTabInvoice (id)
{
    var aInvoices   = JSON.parse(localStorage.getItem('rvInvoices'));
    aInvoices       = _.without(aInvoices, id);
    localStorage.setItem('rvInvoices', JSON.stringify(aInvoices));
    $('#rvTabs div#tabInvoiceId'+ id).remove();
    $('div#tabContentInvoiceId'+ id).remove();
    activeFirstTab();
}

function activeFirstTab ()
{
    $('#rvTabs div.item').removeClass('active');
    $('#rvTabs div.item:first').addClass('active');
    $('div.tabContent').removeClass('active');
    $('div.tabContent:first').addClass('active');
}

function debug (data)
{
    /*
    console.dir(data);
    $('#consoleBox').prepend('<pre>'+ JSON.stringify(data, null, 2) +'</pre><hr />');
    */
}