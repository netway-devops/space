var RvAdmin         = function () {
    this.apiid      = 'b0bf50abcc73b77339f6';
    this.apikey     = 'd9e15c98807cea7ff1f3';
};

RvAdmin.prototype.refreshIframe     = function (id) {
    $(id).attr( 'src', function ( i, val ) { return val; });
};

