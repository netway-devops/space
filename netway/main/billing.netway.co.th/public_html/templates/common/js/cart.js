var HBCart;
(function (HBCart) {
    ;
    var ready = false, redyfn = [];
    var Cart = /** @class */ (function () {
        function Cart(data) {
            this.summary = {
                subtoal: 0,
                total: 0,
                credit: 0,
                discount: 0,
                recurring: [],
                tax: []
            };
            this.product = {
                id: null,
                category_id: null,
                name: '',
                price: 0,
                setup: 0,
                recurring_price: 0,
                config: [],
                domains_offered: []
            };
            this.domains = {};
            this.currency = {
                id: 0,
                rate: 1,
                precision: 2,
                decimal: '.',
                thousands: ','
            };
            this.update(data);
        }
        Cart.prototype.update = function (cart) {
            var key;
            if (typeof cart !== 'object') {
                return;
            }
            if (cart.sid) {
                settings.session = cart.sid;
                delete (cart.sid);
            }
            for (key in cart) {
                this[key] = cart[key];
            }
            if (this.product && this.product.config && this.product.config.product)
                for (key in this.product.config.product) {
                    var opt = this.product.config.product[key];
                    this.product[opt.name] = opt;
                }
            $(document).trigger('cart.updated');
        };
        return Cart;
    }());
    function init(data, settings) {
        if (data === void 0) { data = {}; }
        if (settings === void 0) { settings = {}; }
        updateSettings(settings);
        if (settings.requestBodyClass) {
            $(document).on('cart.requestStarted', function () {
                return $('body').addClass(settings.requestBodyClass);
            });
            $(document).on('cart.requestComplete', function () {
                return $('body').removeClass(settings.requestBodyClass);
            });
        }
        var readyCallback = function () {
            ready = true;
            for (var i = 0, l = redyfn.length; i < l; i++) {
                redyfn[i].call(document, HBCart.cart);
            }
            return $(document).trigger('cart.ready', [HBCart.cart]);
        };
        if ($.isEmptyObject(data)) {
            var options = {
                type: 'POST',
                complete: readyCallback
            }, params = $.extend({
                cat_id: settings.categoryId,
                id: settings.productId,
                languagechange: settings.language,
                currency: settings.currency,
            }, settings.params);
            Queue.add('/cart/v1', params, options);
        }
        else {
            HBCart.cart.update(data);
            return readyCallback();
        }
    }
    HBCart.init = init;
    ;
    function whenReady(callback) {
        if (ready)
            callback.call(document, HBCart.cart);
        else
            redyfn.push(callback);
    }
    HBCart.whenReady = whenReady;
    function updateSettings(newsettings) {
        if (newsettings === void 0) { newsettings = {}; }
        return $.extend(settings, newsettings);
    }
    HBCart.updateSettings = updateSettings;
    ;
    var Api;
    (function (Api) {
        function getCart(options) {
            if (options === void 0) { options = {}; }
            options.type = 'GET';
            return Queue.add('/cart/v1', null, options);
        }
        Api.getCart = getCart;
        function post(data, options) {
            if (options === void 0) { options = {}; }
            options.type = 'POST';
            return Queue.add('/cart/v1', data, options);
        }
        function setDomain(hostname, options) {
            if (options === void 0) { options = {}; }
            for (var i = 0, l = HBCart.cart.product.config.product.length; i < l; i++) {
                var conf = HBCart.cart.product.config.product[i];
                if (conf.id === 'domain')
                    conf.value = hostname;
            }
            return post({
                id: HBCart.cart.product.id,
                domain: hostname
            }, options);
        }
        Api.setDomain = setDomain;
        function setCycle(cycle, options) {
            if (options === void 0) { options = {}; }
            return post({
                id: HBCart.cart.product.id,
                cycle: cycle
            }, options);
        }
        Api.setCycle = setCycle;
        function setProduct(id, options) {
            if (options === void 0) { options = {}; }
            return post({
                id: id
            }, options);
        }
        Api.setProduct = setProduct;
        function product() {
            var data = {
                id: HBCart.cart.product.id, domain: false
            };
            for (var i = 0, l = HBCart.cart.product.config.product.length; i < l; i++) {
                var conf = HBCart.cart.product.config.product[i];
                data[conf.id] = conf.value;
            }
            return data;
        }
        function forms() {
            var data = {
                custom: {},
            };
            for (var i = 0, l = HBCart.cart.product.config.forms.length; i < l; i++) {
                var form = HBCart.cart.product.config.forms[i];
                if (form.value && !$.isEmptyObject(form.value)) {
                    data.custom[form.id] = form.value;
                    continue;
                }
                if (form.multiple || !form.required)
                    continue;
                data.custom[form.id] = form.value = {};
                form.value[form.item[0].id] = '';
            }
            return data;
        }
        function pushForms(options) {
            return post(forms(), options);
        }
        Api.pushForms = pushForms;
        function setForm(id, value, options) {
            if (options === void 0) { options = {}; }
            for (var i = 0, l = HBCart.cart.product.config.forms.length; i < l; i++) {
                var form = HBCart.cart.product.config.forms[i];
                if (form.id != id)
                    continue;
                if (typeof value == 'object') {
                    form.value = value;
                    return pushForms(options);
                }
                var tmp = {};
                for (var i_1 = 0, l_1 = form.items.length; i_1 < l_1; i_1++) {
                    if (value == form.items[i_1].id) {
                        tmp[value] = 1;
                        form.value = tmp;
                        return pushForms(options);
                    }
                }
                tmp[form.items[0].id] = value;
                form.value = tmp;
            }
            return pushForms(options);
        }
        Api.setForm = setForm;
        function resetForms(options) {
            if (options === void 0) { options = {}; }
            return post({
                id: HBCart.cart.product.id,
                custom: [-1]
            }, options);
        }
        Api.resetForms = resetForms;
        function resetForm(id, options) {
            if (options === void 0) { options = {}; }
            var itemId, data = {
                id: HBCart.cart.product.id,
                custom: {}
            };
            for (var i = 0, l = HBCart.cart.product.config.forms.length; i < l; i++) {
                var form = HBCart.cart.product.config.forms[i];
                if (form.id == id) {
                    itemId = form.items[0].id;
                }
            }
            data.custom[id] = {};
            data.custom[id][itemId] = '';
            return post(data, options);
        }
        Api.resetForm = resetForm;
        function domainForms(domain) {
            var data = {
                custom: {},
            }, key = HBCart.cart.domains[domain.trim()].index;
            for (var i = 0, l = HBCart.cart.domains[domain].config.forms.length; i < l; i++) {
                var form = HBCart.cart.domains[domain].config.forms[i];
                if (form.value && !$.isEmptyObject(form.value)) {
                    data.custom[form.id + '_' + key] = form.value;
                    continue;
                }
                if (form.multiple || !form.required)
                    continue;
                data.custom[form.id + '_' + key] = form.value = {};
                form.value[form.item[0].id] = '';
            }
            return data;
        }
        function pushDomainForms(domain, options) {
            var data = domainForms(domain);
            data['do'] = 'setdomainsforms';
            data['key'] = HBCart.cart.domains[domain.trim()].index;
            return post(data, options);
        }
        Api.pushDomainForms = pushDomainForms;
        function setDomainForm(domain, id, value, options) {
            if (options === void 0) { options = {}; }
            for (var i = 0, l = HBCart.cart.domains[domain].config.forms.length; i < l; i++) {
                var form = HBCart.cart.domains[domain].config.forms[i];
                if (form.id != id)
                    continue;
                if (typeof value == 'object') {
                    form.value = value;
                    return pushDomainForms(domain, options);
                }
                var tmp = {};
                for (var i_2 = 0, l_2 = form.items.length; i_2 < l_2; i_2++) {
                    if (value == form.items[i_2].id) {
                        tmp[value] = 1;
                        form.value = tmp;
                        return pushDomainForms(domain, options);
                    }
                }
                tmp[form.items[0].id] = value;
                form.value = tmp;
            }
            return pushDomainForms(domain, options);
        }
        Api.setDomainForm = setDomainForm;
        function resetDomainForm(domain, id, options) {
            if (options === void 0) { options = {}; }
            var itemId, data = {
                id: HBCart.cart.domains[domain].id,
                custom: {}
            };
            for (var i = 0, l = HBCart.cart.domains[domain].config.forms.length; i < l; i++) {
                var form = HBCart.cart.domains[domain].config.forms[i];
                if (form.id == id) {
                    itemId = form.items[0].id;
                }
            }
            data.custom[id] = {};
            data.custom[id][itemId] = '';
            return post(data, options);
        }
        Api.resetDomainForm = resetDomainForm;
        function subitems(type, prefix) {
            if (!HBCart.cart.product.config[type])
                return {};
            var data = {
                id: HBCart.cart.product.id
            }, cyclekey = prefix + '_cycles';
            data[prefix] = { 0: 0 };
            data[cyclekey] = {};
            for (var i = 0, l = HBCart.cart.product.config[type].length; i < l; i++) {
                var item = HBCart.cart.product.config[type][i];
                if (!item.value)
                    continue;
                data[prefix][item.id] = 1;
                data[cyclekey][item.id] = item.value;
            }
            return data;
        }
        function addItem(type, id, cycle) {
            for (var i = 0, l = HBCart.cart.product.config[type].length; i < l; i++) {
                var item = HBCart.cart.product.config[type][i];
                if (item.id != id)
                    continue;
                item.value = cycle || HBCart.cart.product.recurring;
            }
        }
        function removeItem(type, id) {
            for (var i = 0, l = HBCart.cart.product.config[type].length; i < l; i++) {
                var item = HBCart.cart.product.config[type][i];
                if (item.id != id)
                    continue;
                item.value = null;
            }
        }
        function pushAddon(options) {
            if (options === void 0) { options = {}; }
            return post(subitems('addons', 'addon'), options);
        }
        Api.pushAddon = pushAddon;
        function addAddon(id, cycle, options) {
            if (options === void 0) { options = {}; }
            addItem('addons', id, cycle);
            return pushAddon(options);
        }
        Api.addAddon = addAddon;
        function removeAddon(id, options) {
            if (options === void 0) { options = {}; }
            removeItem('addons', id);
            return pushAddon(options);
        }
        Api.removeAddon = removeAddon;
        function clearAddons(options) {
            if (options === void 0) { options = {}; }
            return post({
                id: HBCart.cart.product.id,
                addons: [-1]
            }, options);
        }
        Api.clearAddons = clearAddons;
        function pushSubproducts(options) {
            if (options === void 0) { options = {}; }
            return post(subitems('subproducts', 'subproducts'), options);
        }
        Api.pushSubproducts = pushSubproducts;
        function addSubproduct(id, cycle, options) {
            if (options === void 0) { options = {}; }
            addItem('subproducts', id, cycle);
            return pushSubproducts(options);
        }
        Api.addSubproduct = addSubproduct;
        function removeSubproduct(id, options) {
            if (options === void 0) { options = {}; }
            removeItem('subproducts', id);
            return pushSubproducts(options);
        }
        Api.removeSubproduct = removeSubproduct;
        function clearSubproducts(options) {
            if (options === void 0) { options = {}; }
            return post({
                id: HBCart.cart.product.id,
                subproducts: [-1]
            }, options);
        }
        Api.clearSubproducts = clearSubproducts;
        function addDomain(id, name, period, type, options) {
            name = name.trim();
            HBCart.cart.domains[name] = {
                id: id,
                name: name,
                price: 0,
                setup: 0,
                recurring_price: 0,
                period: period,
                type: type,
                config: []
            };
            return post({
                cat_id: HBCart.cart.category.id,
                domain: {
                    id: id,
                    name: name,
                    period: period,
                    type: type,
                }
            }, options);
        }
        function registerDomain(id, name, period, options) {
            return addDomain(id, name, period, 'register', options);
        }
        Api.registerDomain = registerDomain;
        function transferDomain(id, name, period, options) {
            return addDomain(id, name, period, 'transfer', options);
        }
        Api.transferDomain = transferDomain;
        function removeDomain(name, options) {
            delete HBCart.cart.domains[name.trim()];
            return post({
                cat_id: HBCart.cart.category.id,
                domain: {
                    name: name,
                }
            }, options);
        }
        Api.removeDomain = removeDomain;
        function removeDomainInStep2(name, options) {
            var index = HBCart.cart.domains[name.trim()].index;
            delete HBCart.cart.domains[name.trim()];
            return post({
                do: 'removeitem',
                step: 2,
                target: 'domain',
                target_id: index,
            }, options);
        }
        Api.removeDomainInStep2 = removeDomainInStep2;
        function changeDomainPeriod(name, period, options) {
            HBCart.cart.domains[name.trim()].period = period;
            return post({
                do: 'changedomainperiod',
                key: HBCart.cart.domains[name.trim()].index,
                period: period,
            }, options);
        }
        Api.changeDomainPeriod = changeDomainPeriod;
        function addDomainConfig(data, options) {
            if (options === void 0) { options = {}; }
            return post($.extend(data, //ns, contacts, period
            { do: 'setdomainsconfig', simulate: 1 }), options);
        }
        Api.addDomainConfig = addDomainConfig;
        function pushDomains(options) {
            if (options === void 0) { options = {}; }
            var data = {
                cat_id: HBCart.cart.category.id,
                domains: []
            };
            data.domains.push(-1);
            for (var hostname in HBCart.cart.domains) {
                var domain = HBCart.cart.domains[hostname];
                data.domains.push({
                    id: domain.id,
                    name: domain.name,
                    period: domain.period,
                    type: domain.type,
                });
            }
            return post(data, options);
        }
        Api.pushDomains = pushDomains;
        function getCheckDomainId(tld) {
            if (HBCart.cart.product && HBCart.cart.category.id === HBCart.cart.product.category_id) {
                for (var _i = 0, _a = HBCart.cart.product.domains_offered; _i < _a.length; _i++) {
                    var offer = _a[_i];
                    if (offer.name === tld) {
                        return offer.cat_id;
                    }
                }
            }
            return HBCart.cart.category.id;
        }
        function checkDomain(name, tld, options) {
            if (options === void 0) { options = {}; }
            options.type = 'POST';
            return Queue.add('/cart/v1/checkdomain', {
                cat_id: getCheckDomainId(tld),
                sld: name,
                tld: tld
            }, options);
        }
        Api.checkDomain = checkDomain;
        function domains(type, prefix) {
            var data = {
                id: HBCart.cart.product.id,
                domains: [],
            };
            var i = 0;
            for (var name_1 in HBCart.cart.domains) {
                var item = HBCart.cart.domains[name_1];
                data['domains'][i++] = {
                    id: item.id,
                    name: item.name,
                    period: item.period,
                };
            }
            return data;
        }
        function pushConfig(options) {
            if (options === void 0) { options = {}; }
            var data = $.extend(product(), forms(), subitems('subproducts', 'subproducts'), subitems('addons', 'addon'));
            return post(data, options);
        }
        Api.pushConfig = pushConfig;
        function clearConfig(options) {
            if (options === void 0) { options = {}; }
            return post({
                id: HBCart.cart.product.id,
                custom: [0],
                addon: [0],
                subproducts: [0]
            }, options);
        }
        Api.clearConfig = clearConfig;
        function addCoupon(code, options) {
            if (options === void 0) { options = {}; }
            var data = {
                id: null,
                promocode: code
            };
            if (HBCart.cart.product && HBCart.cart.product.id)
                data.id = HBCart.cart.product.id;
            return post(data, options);
        }
        Api.addCoupon = addCoupon;
        function removeCoupon(options) {
            if (options === void 0) { options = {}; }
            return post({
                id: HBCart.cart.product.id,
                removecoupon: 1
            }, options);
        }
        Api.removeCoupon = removeCoupon;
        function setCurrency(cur, options) {
            if (cur === void 0) { cur = 0; }
            if (options === void 0) { options = {}; }
            return post({
                id: HBCart.cart.product.id,
                currency: cur
            }, options);
        }
        Api.setCurrency = setCurrency;
        function setLanguage(lang, options) {
            if (lang === void 0) { lang = 'english'; }
            if (options === void 0) { options = {}; }
            return post({
                languagechange: lang
            }, options);
        }
        Api.setLanguage = setLanguage;
        function setTaxRegion(country, region, options) {
            if (options === void 0) { options = {}; }
            return post({
                country: country,
                state: region
            }, options);
        }
        Api.setTaxRegion = setTaxRegion;
        function signup(form, options) {
            if (options === void 0) { options = {}; }
            return post(form, options);
        }
        Api.signup = signup;
        function login(email, password, options) {
            if (options === void 0) { options = {}; }
            var data = {
                action: 'login',
                username: email,
                password: password
            };
            return post(data, options);
        }
        Api.login = login;
        function logout(options) {
            if (options === void 0) { options = {}; }
            options.type = 'GET';
            return Queue.add('/cart/v1/logout', {}, options);
        }
        Api.logout = logout;
        function setupOrder(options) {
            if (options === void 0) { options = {}; }
            var pr = product();
            if (!$.isEmptyObject(domains('', ''))) {
                delete pr.domain;
            }
            var data = $.extend(pr, forms(), subitems('subproducts', 'subproducts'), subitems('addons', 'addon'), { make: 'order' });
            return post(data, options);
        }
        Api.setupOrder = setupOrder;
        function clearOrderId() {
            HBCart.cart.order = null;
        }
        Api.clearOrderId = clearOrderId;
        function submitOrder(gateway, note, tos, options) {
            if (note === void 0) { note = ''; }
            if (tos === void 0) { tos = false; }
            if (options === void 0) { options = {}; }
            if (HBCart.cart.order)
                throw Error('Order subbmited, use clearOrder to reset it');
            var data = {
                gateway: gateway,
                note: note,
                tos: tos ? 1 : '',
            };
            return Queue.add('/cart/v1/order', data, options);
        }
        Api.submitOrder = submitOrder;
        function translate(list, options) {
            if (options === void 0) { options = {}; }
            options.type = 'POST';
            return Queue.add('/cart/v1/translate', { w: list }, options);
        }
        Api.translate = translate;
    })(Api = HBCart.Api || (HBCart.Api = {}));
    var Utils;
    (function (Utils) {
        function wrapKeys(obj, type, override) {
            if (type === void 0) { type = 'properties'; }
            var key, value, wrapped;
            wrapped = {};
            for (key in obj) {
                value = obj[key];
                wrapped["" + type + "[" + key + "]"] = override != null ? override : value;
            }
            return wrapped;
        }
        Utils.wrapKeys = wrapKeys;
        function unwrapKeys(obj, type, override) {
            if (type === void 0) { type = 'properties'; }
            var key, unwrapped, unwrappedKey, value;
            unwrapped = {};
            for (key in obj) {
                value = obj[key];
                unwrappedKey = key.replace("" + type + "[", "").replace("]", "");
                unwrapped[unwrappedKey] = override != null ? override : value;
            }
            return unwrapped;
        }
        Utils.unwrapKeys = unwrapKeys;
        function extend(object, properties) {
            var key, val;
            for (key in properties) {
                val = properties[key];
                object[key] = val;
            }
            return object;
        }
        Utils.extend = extend;
        function clone(object) {
            var key, newInstance;
            if ((object == null) || typeof object !== 'object') {
                return object;
            }
            newInstance = new object.constructor();
            for (key in object) {
                newInstance[key] = clone(object[key]);
            }
            return newInstance;
        }
        Utils.clone = clone;
        function ensureArray(value) {
            if (Array.isArray(value)) {
                return value;
            }
            if (value != null) {
                return [value];
            }
            else {
                return [];
            }
        }
        Utils.ensureArray = ensureArray;
        function number_format(num, decimals, dec_point, thousands_sep) {
            if (dec_point === void 0) { dec_point = '.'; }
            if (thousands_sep === void 0) { thousands_sep = ','; }
            num = (num + '').replace(/[^0-9+\-Ee.]/g, '');
            var n = !isFinite(+num) ? 0 : +num, prec = !isFinite(+decimals) ? 0 : Math.abs(decimals), s = [], toFixedFix = function (n, prec) {
                var k = Math.pow(10, prec);
                return '' + Math.round(n * k) / k;
            };
            // Fix for IE parseFloat(0.55).toFixed(0) = 0;
            s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
            if (s[0].length > 3) {
                s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, thousands_sep);
            }
            if ((s[1] || '').length < prec) {
                s[1] = s[1] || '';
                s[1] += new Array(prec - s[1].length + 1).join('0');
            }
            return s.join(dec_point);
        }
        Utils.number_format = number_format;
        function isNumber(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        }
        Utils.isNumber = isNumber;
        function formatMoney(amount, currency) {
            var output = '';
            if (currency.before)
                output += currency.before;
            amount *= currency.rate;
            output += number_format(amount, currency.precision, currency.decimal, currency.thousands);
            if (currency.after)
                output += ' ' + currency.after;
            return output;
        }
        Utils.formatMoney = formatMoney;
        function createCookie(name, value, days) {
            var expires;
            if (days) {
                var date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toUTCString();
            }
            else {
                expires = "";
            }
            document.cookie = encodeURIComponent(name) + "=" + encodeURIComponent(value) + expires + "; path=/";
        }
        Utils.createCookie = createCookie;
        function readCookie(name) {
            var nameEQ = encodeURIComponent(name) + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) === ' ')
                    c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) === 0)
                    return decodeURIComponent(c.substring(nameEQ.length, c.length));
            }
            return null;
        }
        Utils.readCookie = readCookie;
    })(Utils = HBCart.Utils || (HBCart.Utils = {}));
    ;
    var Queue;
    (function (Queue) {
        var queue = [];
        var processing = false;
        function notify(data, textStatus, request) {
            if (!data)
                return;
            var session = request.getResponseHeader('X-Cart-Session');
            if (session) {
                settings.session = session;
                Utils.createCookie('Cart-Session', session, 7);
            }
            if (data.errors && data.errors.length) {
                $(document).trigger('cart.errors', [data.errors]);
            }
            if (data.info && data.info.length) {
                $(document).trigger('cart.info', [data.info]);
            }
        }
        function add(url, data, options) {
            var url = settings.url + 'index.php?' + url;
            if (typeof options.step != 'undefined' || options.step) {
                data.step = options.step;
            }
            if (typeof options.simulate != 'undefined' || options.simulate) {
                data.simulate = options.simulate;
            }
            var request = {
                url: url,
                data: data,
                type: options.type || 'POST',
                dataType: options.dataType || 'json',
                xhrFields: {
                    withCredentials: settings.withCredentials
                },
                success: Utils.ensureArray(options.success),
                error: Utils.ensureArray(options.error),
                complete: Utils.ensureArray(options.complete),
                deffered: $.Deferred()
            };
            request.success.push(notify);
            if (typeof options.updateCart == 'undefined' || options.updateCart) {
                request.success.push($.proxy(HBCart.cart.update, HBCart.cart));
            }
            if (options.queue === false)
                queue.unshift(request);
            else
                queue.push(request);
            if (processing) {
                request.success.push(request.deffered.resolve);
                request.error.push(request.deffered.reject);
                request.deffered.abort = request.deffered.reject;
                return request.deffered;
            }
            $(document).trigger('cart.requestStarted', [HBCart.cart]);
            return process();
        }
        Queue.add = add;
        function process() {
            var params;
            if (!queue.length) {
                processing = false;
                $(document).trigger('cart.requestComplete', [HBCart.cart]);
                return;
            }
            processing = true;
            params = queue.shift();
            if (params.deffered.state() != 'pending')
                return process();
            params.complete.push(process);
            return $.ajax(params);
        }
    })(Queue || (Queue = {}));
    HBCart.cart = new Cart({});
    var settings = {
        url: window.location.href,
        session: Utils.readCookie('Cart-Session'),
        categoryId: null,
        productId: null,
        language: null,
        currency: null,
        params: {},
        withCredentials: true,
        requestBodyClass: null,
    };
})(HBCart || (HBCart = {}));
