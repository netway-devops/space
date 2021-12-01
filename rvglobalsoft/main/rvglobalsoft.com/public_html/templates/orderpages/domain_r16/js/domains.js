$(function () {
    var textarea = $('#orderpage .domain-search textarea'),
        mode,
        listToDisplay,
        cache = {},
        lastValue = '',
        typing,
        requests = [];

    autosize(textarea);

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

    var tpltarget = $('#orderpage .domain-search-results'),
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
            if (lastValue === val)
                return;

            clearTimeout(typing);
            if (val.length < 3)
                return;

            lastValue = val;
            for (var i = 0; i < requests.length; i++) {
                requests[i].abort();
            }
            requests = [];

            typing = setTimeout(lookup, 260)
        }).trigger('input')
    })

    function checkdomain(item) {
        var defered =
            HBCart.Api.checkDomain(item.sld, item.tld).done(function (data) {
            data.canTransfer = data.status == '';
            data.canRegister = data.status == 'ok';
            data.price = data.canRegister ? item.register : (
                data.canTransfer ? item.transfer : null
                )
            cache[item.hostname] = data;
            if(data.premium && data.canRegister) {
                data.price.price = data.prices["1"].register;
            }

            $.extend(item, data);
            $('#' + item.htmlId).html(tpl.rowdata(item, tplopt));
        })
        requests.push(defered);
        return defered;
    }

    function firstperiod(type, periods) {
        for (var i = 0, l = periods.length; i < l; i++) {
            if (periods[i][type] >= 0)
                return {
                    period: periods[i].value,
                    title: periods[i].title,
                    price: periods[i][type]
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
                })

                if (nearEnd) {
                    var html = '',
                        offset = data.display.length,
                        items = data.items.splice(0, Math.min(10, data.items.length)),
                        prv_tpldata = $.extend({}, tplopt);

                    //add items to the end of data.display set
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
                    })
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
            clearTimeout(timeout)
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

        for (var i = 0, l = HBCart.cart.category.products.length; i < l; i++) {
            var product = HBCart.cart.category.products[i],
                domain = sld + product.name,
                tld_in_query = tlds.indexOf(product.name),
                tags = product.tags || [];

            if (mode == 'transfer' && tld_in_query < 0)
                continue;

            group.items.push({
                id: product.id,
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

            if(tld_in_query >= 0)
                tlds_found.push(product.name);
        }

        if (tlds_found.length != tlds_l) {
            for (var i = 0; i < tlds_l; i++) {
                if(tlds_found.indexOf(tlds[i]) >= 0)
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
                return b.inquery - a.inquery

            if (a.inCart !== b.inCart)
                return b.inCart - a.inCart

            if (a.featured !== b.featured)
                return b.featured - a.featured

            return a.index - b.index

        })
        group.display = group.items.splice(0, 20);
        return group;
    }

    function lookup() {
        listToDisplay = {};
        var query = {};

        var hostnames = textarea.val().split(/\n/),
            wipe = /^[-\.]+|[-\.]+$|^((?!xn).{2})--|[!@#$€%^&*()<>=+`~'"\[\\\/\],;| _]|^w{1,3}$|^w{1,3}\./g;
            //^[-\.]+ / remove leading hyphen and dot
            //[-\.]+$ / remove end hyphen and dot
            //^((?!xn).{2})-- / Cannot have a hyphen in third and fourth position, unless it starts with 'xn'
            //[!@#$€%^&*()<>=+`~'"\[\\\/\],;| _] / not allowed characters
            //^w{1,3}$|^w{1,3}\. / strip www from query

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
                if (!listToDisplay[d].display[subi])
                    continue;

                var item = listToDisplay[d].display[subi];
                hasitems++;

                if (!cache[item.hostname]) {
                    if (subi < 11)
                        checkdomain(item);
                    else
                        item.lazy = 1;
                    continue;
                }

                $.extend(item, cache[item.hostname]);
            }
            if (!hasitems)
                break;

            subi++;
        }

        tpltarget.html(tpl.main({items: listToDisplay}, tplopt));

        $('.result-group', tpltarget).each(function () {
            var group = $(this),
                groupid = group.data('id'),
                rows = group.children(),
                rowheight = null;

            group.data('group', listToDisplay[groupid]);

            rows.each(function () {
                var row = $(this),
                    rowid = row.data('id');

                row.data('item', listToDisplay[groupid].display[rowid]);
                if (rowheight == null)
                    rowheight = (row.outerHeight(true) - row.outerHeight()) / 2 + row.outerHeight();
            })
            if (rows.length > 10) {
                group.height(rowheight * 10);
            }

            lazyWhois(group);
        });

    }

    function modeFromUrl() {
        if (['#register', '#transfer'].indexOf(window.location.hash) > -1)
            return window.location.hash.substr(1);
        return window.location.href.match(/\/transfer/) ? 'transfer' : 'register';
    }

    function modeswitch(_mode) {
        if (_mode != 'transfer' && _mode != 'register') {
            return false;
        }

        mode = _mode;
        $('#orderpage .domain-modes').removeClass('active').filter('.mode-' + mode).addClass('active');
        $('#orderpage').attr('class', '').addClass(mode);

        var textarea = $('#orderpage .domain-textarea textarea');
        textarea.prop('placeholder', textarea.data('mode-' + mode));

        lookup();
        return true;
    }

    $('#orderpage').on('click', '.domain-modes a', function () {
        var hash = $(this).attr('href');
        if (window.history.pushState) {
            window.history.pushState(null, null, window.location.href.replace(/#.*$/, '') + hash);
            modeswitch(modeFromUrl());
        } else {
            window.location.hash = hash;
        }

        return false;
    });

    $(window).on("hashchange", function () {
        modeswitch(modeFromUrl());
    });
    modeswitch(modeFromUrl());

    function counter(cart) {
        tplopt.data.domains = Object.keys(cart.domains).length;
        $('.cart-cnt').text(tplopt.data.domains);

        if (tplopt.data.domains < 1) {
            tplopt.data.domains = 0;
            $('.domain-order').hide();
        } else {
            $('.domain-order').show();
        }
    }
    counter(HBCart.cart);

    $('#orderpage').on('click', '.result-row .domain-transfer, .result-row .domain-register', function (e) {
        e.preventDefault();
        var self = $(this),
            row = self.parents('.result-row:first'),
            item = row.data('item');

        if (!item || !item.price)
            return;

        if (item.canTransfer)
            HBCart.Api.transferDomain(item.id, item.hostname, item.price.period, {queue: false})
                .always(counter);
        else
            HBCart.Api.registerDomain(item.id, item.hostname, item.price.period, {queue: false})
                .always(counter);

        $('.cart-cnt').text(++tplopt.data.domains);
        row.addClass('active')
    })

    $('#orderpage').on('click', '.result-row .result-remove', function (e) {
        e.preventDefault();
        var self = $(this),
            row = self.parents('.result-row:first'),
            item = row.data('item');

        if (!item)
            return;

        HBCart.Api.removeDomain(item.hostname, {queue: false}).always(counter);
        row.removeClass('active')
    })

    $('#orderpage').on('click', '.result-row .result-whois-link', function (e) {
        e.preventDefault();
        var self = $(this),
            token = $('meta[name="csrf-token"]').attr('content'),
            params = self.attr('href').match(/#whois\/(.+)(\..+?)$/),
            url = '?cmd=checkdomain&action=whois&sld=' + params[1] + '&tld=' + params[2] + '&security_token=' + token;

        window.open(url, params[1] + params[2], 'width=500, height=500, scrollbars=1')
    })


    $('#orderpage').on('click', '.result-cart', function (e) {
        e.preventDefault();
        $('#order-submit')[0].click();
        return false;
    })

    $('#orderpage').on('click', '.domain-input button', lookup)
})