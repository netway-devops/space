function setAction(act) {
    $('#add-domain').find('.slidme').hide();
    switch (act) {
        case 'register':
            $('#domain_textarea').show();
            $('#form1').find('input[name="domain"]').val('illregister');
            break;
        case 'transfer':
            $('#domain_textarea').show();
            $('#form1').find('input[name="domain"]').val('illtransfer');
            break;
        case 'update':
            $('#illupdate').show();
            $('#form1').find('input[name="domain"]').val('illupdate');
            break;
        case 'sub':
            $('#illsub').show();
            $('#form1').find('input[name="domain"]').val('illsub');
            break;
    }
}

$(function () {
    var orderpage = $('.orderpage-domain'),
        textarea = orderpage.find('.domain-search textarea'),
        listToDisplay,
        typing,
        mode,
        requests = [];
    Handlebars.registerHelper('eq', function (options) {
        var argv = Array.prototype.slice.call(arguments);
        if (argv.length > 1) {
            options = argv[argv.length - 1];
            if (argv[0] == argv[1]) {
                return options.fn(this);
            }
            return options.inverse(this);
        }
        for (var key in options.hash) {
            if (this[key] == options.hash[key])
                return options.fn(this);
        }
        return options.inverse(this);
    });
    Handlebars.registerHelper('dots', function (string, tld, trimtoLength, options) {
        if (string.length + tld.length < trimtoLength)
            return string;

        var sp = Math.ceil(string.length / 2),
            cutoff = Math.floor((string.length + tld.length - trimtoLength) / 2) + 1;
        return string.substr(0, sp - cutoff) + '...' + string.substr(sp + cutoff);
    });
    Handlebars.registerHelper('$', function (price, format, options) {
        if (!format || !format.iso)
            format = HBCart.cart.currency;
        return HBCart.Utils.formatMoney(price, format)
    });
    var tpltarget = orderpage.find('.domain-search-results'),
        tpl = {
            rowdata: Handlebars.compile($('#result-row-data').html()),
            row: Handlebars.compile($('#result-row').html()),
            main: Handlebars.compile($('#result-group').html()),
        },
        tplopt = {
            data: {
                domains: 0
            }
        };
    Handlebars.registerPartial('resultRow', tpl.row);
    Handlebars.registerPartial('resultRowData', tpl.rowdata);
    HBCart.whenReady(function () {
        textarea.on('input keyup', function (e) {
            var val = textarea.val().trim();
            clearTimeout(typing);
            if (val.length < 3)
                return;
            for (var i = 0; i < requests.length; i++) {
                requests[i].abort();
            }
            requests = [];
            typing = setTimeout(lookup, 260)
        }).trigger('input')
    });

    function checkdomain(item) {
        var old = HBCart.cart.category.id;
        HBCart.cart.category.id = item.cat_id;
        var defered =
            HBCart.Api.checkDomain(item.sld, item.tld).done(function (data) {
                var mode = $('input[name="domainmode"]:checked').val();
                data.canTransfer = data.status == '';
                data.canRegister = data.status == 'ok';
                if (mode === 'register') {
                    data.canTransfer = false
                } else if (mode === 'transfer') {
                    data.canRegister = false;
                }
                data.price = data.canRegister ? item.register : (
                    data.canTransfer ? item.transfer : null
                );
                if (data.premium && data.canRegister) {
                    data.price.price = data.prices["1"].register;
                }
                $.extend(item, data);
                $('#' + item.htmlId).html(tpl.rowdata(item, tplopt));
            });
        requests.push(defered);
        HBCart.cart.category.id = old;
        return defered;
    }

    function firstperiod(type, periods) {
        for (var i = 0, l = periods.length; i < l; i++) {
            if (periods[i][type] >= 0) {
                return {
                    period: periods[i].value,
                    title: periods[i].title,
                    price: periods[i][type]
                }
            }
        }
    }

    function lazyWhois(group) {
        var lazywhois = {},
            data = group.data('group'),
            rows = $(".result-row.lazy", group);
        rows.removeClass('lazy');
        rows.Lazy({
            appendScroll: group,
            visibleOnly: true,
            scrollDirection: 'vertical',
            threshold: 0,
            throttle: 250,
            whois: function (element) {
                var row = $(element),
                    nearEnd = data.items.length && row.nextAll().length < 20,
                    item = row.data('item');
                lazywhois[item.hostname] = checkdomain(item);
                lazywhois[item.hostname].done(function () {
                    delete lazywhois[item.hostname];
                }).fail(function () {
                    delete lazywhois[item.hostname];
                    row.data('handled', false)
                });
                if (nearEnd) {
                    var html = '',
                        offset = data.display.length,
                        items = data.items.splice(0, Math.min(10, data.items.length)),
                        prv_tpldata = $.extend({}, tplopt);
                    data.display.splice.apply(data.display, [data.display.length, 0].concat(items));
                    for (var i = 0, l = items.length; i < l; i++) {
                        items[i].lazy = 1;
                        prv_tpldata.data.key = i + offset;
                        html += tpl.row(items[i], prv_tpldata);
                    }
                    group.append(html);
                    group.children('.lazy').each(function () {
                        var row = $(this),
                            rowid = row.data('id');

                        row.data('item', items[rowid - offset]);
                    });
                    lazyWhois(group);
                }
            },
            onUnload: function (element) {
                var row = $(element),
                    item = row.data('item'),
                    hostname = item.hostname;
                if (lazywhois[hostname] && lazywhois[hostname].state() == 'pending')
                    lazywhois[hostname].abort();
            }
        });
        var timeout;
        group.on('scroll', function () {
            clearTimeout(timeout);
            timeout = setTimeout(function () {
                group.trigger('resize');
            }, 1000)
        })
    }

    function lookupgroup(sld, tlds) {
        var tlds_l = tlds.length,
            tlds_found = [],
            group = {
                query: sld,
                items: [],
                display: []
            };
        for (var i = 0, l = HBCart.cart.product.domains_offered.length; i < l; i++) {
            var product = HBCart.cart.product.domains_offered[i],
                domain = sld + product.name,
                tld_in_query = tlds.indexOf(product.name),
                tags = product.tags || [];
            group.items.push({
                id: product.id,
                cat_id: product.cat_id,
                hostname: domain,
                sld: sld,
                tld: product.name,
                status: -1,
                inquery: tld_in_query >= 0 ? tlds_l - tld_in_query : -1,
                featured: tags.indexOf('featured') > -1,
                line: tld_in_query,
                inCart: typeof HBCart.cart.domains[domain] !== 'undefined',
                transfer: firstperiod('transfer', product.periods),
                register: firstperiod('register', product.periods),
                price: firstperiod(mode, product.periods),
                htmlId: 'r_' + btoa(encodeURIComponent(product.id + domain)).replace(/=+/, '')
            });
            if (tld_in_query >= 0)
                tlds_found.push(product.name);
        }
        if (tlds_found.length != tlds_l) {
            for (var i = 0; i < tlds_l; i++) {
                if (tlds_found.indexOf(tlds[i]) >= 0)
                    continue;
                var tld_in_query = tlds.indexOf(tlds[i])
                group.items.push({
                    hostname: sld + tlds[i],
                    sld: sld,
                    tld: tlds[i],
                    inquery: tlds_l - tld_in_query,
                    line: tld_in_query,
                    status: 'notsupported',
                })
            }
        }
        if (!group.items.length)
            return null;
        group.items.sort(function (a, b) {
            if (a.inquery !== b.inquery)
                return b.inquery - a.inquery;
            if (a.inCart !== b.inCart)
                return b.inCart - a.inCart;
            if (a.featured !== b.featured)
                return b.featured - a.featured;
            return a.index - b.index
        });
        group.display = group.items.splice(0, 20);
        return group;
    }

    function lookup() {
        listToDisplay = {};
        var query = {};
        var hostnames = textarea.val().split(/\n/),
            wipe = /^[-\.]+|[-\.]+$|^((?!xn).{2})--|[!@#$€%^&*()<>=+`~'"\[\\\/\],;| _]|^w{1,3}$|^w{1,3}\./g;
        $.each(hostnames, function (i, hostname) {
            hostname = hostname.trim().toLowerCase().replace(wipe, '$1');
            var dot = (hostname + '.').indexOf('.'),
                parts = [hostname.slice(0, dot), hostname.slice(dot + 1)],
                sld = parts[0],
                tld = parts[1] ? '.' + parts[1].replace(wipe, '') : '';
            hostname = sld + (tld || '');
            if (hostname.length < 2)
                return;
            if (!query[sld])
                query[sld] = [];
            if (tld)
                query[sld].push(tld);
        });
        $.each(query, function (sld, tlds) {
            listToDisplay['G' + sld] = lookupgroup(sld, tlds);
        });
        var subi = 0;
        while (true) {
            var hasitems = 0;
            for (var d in listToDisplay) {
                if (!listToDisplay.hasOwnProperty(d) || !listToDisplay[d] || !listToDisplay[d].display[subi])
                    continue;
                var item = listToDisplay[d].display[subi];
                hasitems++;
                if (subi < 11)
                    checkdomain(item);
                else
                    item.lazy = 1;
                continue;
            }
            if (!hasitems)
                break;
            subi++;
        }
        tpltarget.html(tpl.main({items: listToDisplay}, tplopt));
        $('.result-group', tpltarget).each(function () {
            var group = $(this),
                groupid = group.data('id'),
                rows = group.children();
            group.data('group', listToDisplay[groupid]);
            rows.each(function () {
                var row = $(this),
                    rowid = row.data('id');
                row.data('item', listToDisplay[groupid].display[rowid]);
            });
            lazyWhois(group);
        });
    }

    orderpage.on('change', 'input[name="domainmode"]', function () {
        mode = $(this).val();
        if (mode !== 'transfer' && mode !== 'register') {
            tpltarget.html('');
            $('#form1').hide();
            return false;
        }
        $('#form1').show();
        orderpage.attr('class', '').addClass(mode);
        var val = textarea.val();
        textarea.val('').val(val).trigger('input');
        return true;
    }).trigger('change');
    orderpage.on('click', '.result-row .domain-transfer, .result-row .domain-register', function (e) {
        e.preventDefault();
        var self = $(this),
            row = self.parents('.result-row:first'),
            item = row.data('item');
        if (!item || !item.price)
            return;
        row.addClass('active');
    });
    orderpage.on('click', '.result-row .result-remove', function (e) {
        e.preventDefault();
        var self = $(this),
            row = self.parents('.result-row:first'),
            item = row.data('item');
        if (!item)
            return;
        row.find('.result-button').removeClass('active');
        row.find('.result-button').find('input[type="checkbox"]').prop('checked', false);
        row.removeClass('active');
    });
    orderpage.on('click', '.result-row .result-whois-link', function (e) {
        e.preventDefault();
        var self = $(this),
            token = $('meta[name="csrf-token"]').attr('content'),
            params = self.attr('href').match(/#whois\/(.+)(\..+?)$/),
            url = '?cmd=checkdomain&action=whois&sld=' + params[1] + '&tld=' + params[2] + '&security_token=' + token;
        window.open(url, params[1] + params[2], 'width=500, height=500, scrollbars=1')
    });
    $('#form1').on('submit', function (e) {
        $('.result-row.active').each(function () {
            var row = $(this),
                detls = $(this).find('.result-row-details'),
                sld = detls.attr('data-sld'),
                tld = detls.attr('data-tld'),
                period = detls.attr('data-period'),
                dom = sld + tld;
            row.append('<input name="sld[' + dom + ']" value="' + sld + '" type="hidden" >')
                .append('<input name="tld[' + dom + ']" value="' + tld + '" type="hidden" >')
                .append('<input name="period[' + dom + ']" value="' + period + '" type="hidden" >');
        });
        return true;
    });
});