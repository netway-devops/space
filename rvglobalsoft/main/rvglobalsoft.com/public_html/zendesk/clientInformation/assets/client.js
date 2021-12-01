var RvClient    = function () {
    this.zat        = 'true';
    this.apiid      = 'b0bf50abcc73b77339f6';
    this.apikey     = 'd9e15c98807cea7ff1f3';
    this.email      = '';
    this.keyword    = '';
    this.clientId   = 0;
};

RvClient.prototype.getClient    = function () {
    socket.emit('getClient', oRv);
};

RvClient.prototype.showSearchBox    = function () {
    $.get({ url : 'templates/search.html', cache : false }, function (result) {
        $('#searchBox').html(result);
    });
};

RvClient.prototype.searchClient     = function (obj, e) {
    var keyword     = obj.val();
    if(e.keyCode === 13 && keyword !== ''){
        oRv.keyword = keyword;
        oRv.getClient();
    }
};

RvClient.prototype.getClientDetail  = function (clientId) {
    oRv.clientId    = clientId;
    socket.emit('getClientDetail', oRv);
};

RvClient.prototype.getClientService     = function () {
    socket.emit('getClientService', oRv);
};

RvClient.prototype.getClientOrders      = function () {
    socket.emit('getClientOrders', oRv);
};

RvClient.prototype.getClientInvoice     = function () {
    socket.emit('getClientInvoice', oRv);
};


RvClient.prototype.clientDetailShow     = function () {
    $('#clientDetailBox').show();
    $('#searchBox').hide();
    $('#clientsBox').hide();
};

RvClient.prototype.clientDetailClose    = function () {
    $('#clientDetailBox').hide();
    $('#searchBox').show();
    $('#clientsBox').show();
};

RvClient.prototype.topbarShowClientDetail   = function (id) {
    localStorage.setItem('rvClientId', id);
    var aClients    = JSON.parse(localStorage.getItem('rvClients'));
    aClients        = aClients ? aClients : [];
    if (! _.contains(aClients, id)) {
        aClients.push(id);
    }
    localStorage.setItem('rvClients', JSON.stringify(aClients));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('showClientDetail');
    });
};

RvClient.prototype.topbarListClientDomain   = function (id) {
    localStorage.setItem('rvClientDomainId', id);
    var aClients    = JSON.parse(localStorage.getItem('rvClientDomains'));
    aClients        = aClients ? aClients : [];
    if (! _.contains(aClients, id)) {
        aClients.push(id);
    }
    localStorage.setItem('rvClientDomains', JSON.stringify(aClients));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('listClientDomain');
    });
};

RvClient.prototype.topbarShowDomainDetail   = function (id) {
    localStorage.setItem('rvDomainId', id);
    var aDomains    = JSON.parse(localStorage.getItem('rvDomains'));
    aDomains        = aDomains ? aDomains : [];
    if (! _.contains(aDomains, id)) {
        aDomains.push(id);
    }
    localStorage.setItem('rvDomains', JSON.stringify(aDomains));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('showDomainDetail');
    });
};

RvClient.prototype.topbarListClientAccount  = function (id) {
    
    localStorage.setItem('rvClientAccountId', id);
    var aClients    = JSON.parse(localStorage.getItem('rvClientAccounts'));
    aClients        = aClients ? aClients : [];
    if (! _.contains(aClients, id)) {
        aClients.push(id);
    }
    localStorage.setItem('rvClientAccounts', JSON.stringify(aClients));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('listClientAccount');
    });
};

RvClient.prototype.topbarShowAccountDetail   = function (id) {
    localStorage.setItem('rvAccountId', id);
    var aAccounts   = JSON.parse(localStorage.getItem('rvAccounts'));
    aAccounts       = aAccounts ? aAccounts : [];
    if (! _.contains(aAccounts, id)) {
        aAccounts.push(id);
    }
    localStorage.setItem('rvAccounts', JSON.stringify(aAccounts));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('showAccountDetail');
    });
};

RvClient.prototype.topbarListClientOrder  = function (id) {
    
    localStorage.setItem('rvClientOrderId', id);
    var aClients    = JSON.parse(localStorage.getItem('rvClientOrders'));
    aClients        = aClients ? aClients : [];
    if (! _.contains(aClients, id)) {
        aClients.push(id);
    }
    localStorage.setItem('rvClientOrders', JSON.stringify(aClients));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('listClientOrder');
    });
};

RvClient.prototype.topbarShowOrderDetail    = function (id) {
    localStorage.setItem('rvOrderId', id);
    var aOrders     = JSON.parse(localStorage.getItem('rvOrders'));
    aOrders         = aOrders ? aOrders : [];
    if (! _.contains(aOrders, id)) {
        aOrders.push(id);
    }
    localStorage.setItem('rvOrders', JSON.stringify(aOrders));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('showOrderDetail');
    });
};

RvClient.prototype.topbarListClientInvoice  = function (id) {
    
    localStorage.setItem('rvClientInvoiceId', id);
    var aClients    = JSON.parse(localStorage.getItem('rvClientInvoices'));
    aClients        = aClients ? aClients : [];
    if (! _.contains(aClients, id)) {
        aClients.push(id);
    }
    localStorage.setItem('rvClientInvoices', JSON.stringify(aClients));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('listClientInvoice');
    });
};

RvClient.prototype.topbarShowInvoiceDetail  = function (id) {
    localStorage.setItem('rvInvoiceId', id);
    var aInvoices   = JSON.parse(localStorage.getItem('rvInvoices'));
    aInvoices       = aInvoices ? aInvoices : [];
    if (! _.contains(aInvoices, id)) {
        aInvoices.push(id);
    }
    localStorage.setItem('rvInvoices', JSON.stringify(aInvoices));
    instanceTopbar.then( function (topBar) {
        topBar.trigger('showInvoiceDetail');
    });
};




