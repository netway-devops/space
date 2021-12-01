namespace HBCart {

    interface Callback {
        (): string;

        call(): any;

        call(context: any, ...args: any[]): any;

        apply(): any;

        apply(context: any, args: any[]): any;
    };

    declare var $: any;
    var ready = false,
        redyfn: Callback[] = [];

    class Cart {
        summary: any = {
            subtoal: 0,
            total: 0,
            credit: 0,
            discount: 0,
            recurring: [],
            tax: []
        }
        product: any = {
            id: null,
            category_id: null,
            name: '',
            price: 0,
            setup: 0,
            recurring_price: 0,
            config: [],
            domains_offered: []
        }
        domains: any = {}
        category: any
        categories: any[]
        currency: any = {
            id: 0,
            rate: 1,
            precision: 2,
            decimal: '.',
            thousands: ','
        }
        currencies: any
        client: any
        error: any[]
        info: any[]
        validated: boolean
        order: any

        constructor(data: Object) {
            this.update(data);
        }

        update(cart: any) {
            let key: any;

            if (typeof cart !== 'object') {
                return;
            }

            if (cart.sid) {
                settings.session = cart.sid;
                delete (cart.sid)
            }

            for (key in cart) {
                this[key] = cart[key];
            }
            if (this.product && this.product.config && this.product.config.product)
                for (key in this.product.config.product) {
                    let opt = this.product.config.product[key]
                    this.product[opt.name] = opt;
                }
            $(document).trigger('cart.updated');
        }
    }

    export function init(data: any = {}, settings: any = {}) {
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
            for (let i = 0, l = redyfn.length; i < l; i++) {
                redyfn[i].call(document, cart)
            }
            return $(document).trigger('cart.ready', [cart]);
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
        } else {
            cart.update(data);
            return readyCallback();
        }
    };

    export function whenReady(callback: Callback) {
        if (ready)
            callback.call(document, cart);
        else
            redyfn.push(callback);
    }

    export function updateSettings(newsettings: Object = {}) {
        return $.extend(settings, newsettings);
    };

    export namespace Api {

        export function getCart(options: any = {}) {
            options.type = 'GET';
            return Queue.add('/cart/v1', null, options);
        }

        function post(data: any, options: any = {}) {
            options.type = 'POST';
            return Queue.add('/cart/v1', data, options);
        }

        export function setDomain(hostname: string, options: any = {}) {
            for (let i = 0, l = cart.product.config.product.length; i < l; i++) {
                let conf = cart.product.config.product[i];
                if (conf.id === 'domain')
                    conf.value = hostname;
            }

            return post({
                id: HBCart.cart.product.id,
                domain: hostname
            }, options)
        }

        export function setCycle(cycle: string, options: any = {}) {
            return post({
                id: HBCart.cart.product.id,
                cycle: cycle
            }, options)
        }

        export function setProduct(id: number, options: any = {}) {
            return post({
                id: id
            }, options)
        }

        function product() {
            var data = {
                id: HBCart.cart.product.id, domain: false
            };
            for (let i = 0, l = cart.product.config.product.length; i < l; i++) {
                let conf = cart.product.config.product[i];
                data[conf.id] = conf.value;
            }
            return data
        }

        function forms() {
            var data = {
                custom: {},
            };
            for (let i = 0, l = cart.product.config.forms.length; i < l; i++) {
                let form = cart.product.config.forms[i];
                if (form.value && !$.isEmptyObject(form.value)) {
                    data.custom[form.id] = form.value;
                    continue;
                }

                if (form.multiple || !form.required)
                    continue;

                data.custom[form.id] = form.value = {}
                form.value[form.item[0].id] = '';
            }
            return data;
        }

        export function pushForms(options) {
            return post(forms(), options);
        }

        export function setForm(id: number, value: any, options: any = {}) {
            for (let i = 0, l = cart.product.config.forms.length; i < l; i++) {
                let form = cart.product.config.forms[i];
                if (form.id != id)
                    continue;

                if (typeof value == 'object') {
                    form.value = value;
                    return pushForms(options);
                }
                var tmp = {};
                for (let i = 0, l = form.items.length; i < l; i++) {
                    if (value == form.items[i].id) {
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

        export function resetForms(options: any = {}) {
            return post({
                id: HBCart.cart.product.id,
                custom: [-1]
            }, options);
        }

        export function resetForm(id: number, options: any = {}) {
            var itemId,
                data = {
                    id: HBCart.cart.product.id,
                    custom: {}
                };
            for (let i = 0, l = cart.product.config.forms.length; i < l; i++) {
                let form = cart.product.config.forms[i];
                if (form.id == id) {
                    itemId = form.items[0].id;
                }
            }
            data.custom[id] = {};
            data.custom[id][itemId] = '';

            return post(data, options);
        }


        function domainForms(domain: string) {
            var data = {
                custom: {},
            },
                key = cart.domains[domain.trim()].index;
            for (let i = 0, l = cart.domains[domain].config.forms.length; i < l; i++) {
                let form = cart.domains[domain].config.forms[i];
                if (form.value && !$.isEmptyObject(form.value)) {
                    data.custom[form.id + '_' + key] = form.value;
                    continue;
                }

                if (form.multiple || !form.required)
                    continue;

                data.custom[form.id + '_' + key] = form.value = {}
                form.value[form.item[0].id] = '';
            }
            return data;
        }

        export function pushDomainForms(domain: string, options) {
            var data = domainForms(domain);
            data['do'] = 'setdomainsforms';
            data['key'] = cart.domains[domain.trim()].index;
            return post(data, options);
        }

        export function setDomainForm(domain: string, id: number, value: any, options: any = {}) {
            for (let i = 0, l = cart.domains[domain].config.forms.length; i < l; i++) {
                let form = cart.domains[domain].config.forms[i];
                if (form.id != id)
                    continue;

                if (typeof value == 'object') {
                    form.value = value;
                    return pushDomainForms(domain, options);
                }
                var tmp = {};
                for (let i = 0, l = form.items.length; i < l; i++) {
                    if (value == form.items[i].id) {
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

        export function resetDomainForm(domain: string, id: number, options: any = {}) {
            var itemId,
                data = {
                    id: HBCart.cart.domains[domain].id,
                    custom: {}
                };
            for (let i = 0, l = cart.domains[domain].config.forms.length; i < l; i++) {
                let form = cart.domains[domain].config.forms[i];
                if (form.id == id) {
                    itemId = form.items[0].id;
                }
            }
            data.custom[id] = {};
            data.custom[id][itemId] = '';

            return post(data, options);
        }

        function subitems(type: string, prefix: string) {
            if (!cart.product.config[type])
                return {};

            var data = {
                    id: HBCart.cart.product.id
                },
                cyclekey = prefix + '_cycles';
            data[prefix] = {0: 0};
            data[cyclekey] = {};

            for (let i = 0, l = cart.product.config[type].length; i < l; i++) {
                let item = cart.product.config[type][i];
                if (!item.value)
                    continue;
                data[prefix][item.id] = 1;
                data[cyclekey][item.id] = item.value;
            }
            return data;
        }

        function addItem(type: string, id: number, cycle: string) {
            for (let i = 0, l = cart.product.config[type].length; i < l; i++) {
                let item = cart.product.config[type][i];
                if (item.id != id)
                    continue;
                item.value = cycle || cart.product.recurring;
            }
        }

        function removeItem(type: string, id: number) {
            for (let i = 0, l = cart.product.config[type].length; i < l; i++) {
                let item = cart.product.config[type][i];
                if (item.id != id)
                    continue;
                item.value = null;
            }
        }

        export function pushAddon(options: any = {}) {
            return post(subitems('addons', 'addon'), options);
        }

        export function addAddon(id: number, cycle: string, options: any = {}) {
            addItem('addons', id, cycle);
            return pushAddon(options);
        }

        export function removeAddon(id: number, options: any = {}) {
            removeItem('addons', id);
            return pushAddon(options);
        }

        export function clearAddons(options: any = {}) {
            return post({
                id: HBCart.cart.product.id,
                addons: [-1]
            }, options);
        }

        export function pushSubproducts(options: any = {}) {
            return post(subitems('subproducts', 'subproducts'), options);
        }

        export function addSubproduct(id: number, cycle: string, options: any = {}) {
            addItem('subproducts', id, cycle);
            return pushSubproducts(options);
        }

        export function removeSubproduct(id: number, options: any = {}) {
            removeItem('subproducts', id);
            return pushSubproducts(options);
        }

        export function clearSubproducts(options: any = {}) {
            return post({
                id: HBCart.cart.product.id,
                subproducts: [-1]
            }, options);
        }

        function addDomain(id: number, name: string, period: number, type: string, options: any) {
            name = name.trim();
            cart.domains[name] = {
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
                cat_id: cart.category.id,
                domain: {
                    id: id,
                    name: name,
                    period: period,
                    type: type,
                }
            }, options);
        }

        export function registerDomain(id: number, name: string, period: number, options: any) {
            return addDomain(id, name, period, 'register', options);
        }

        export function transferDomain(id: number, name: string, period: number, options: any) {
            return addDomain(id, name, period, 'transfer', options);
        }

        export function removeDomain(name: string, options: any) {
            delete cart.domains[name.trim()];
            return post({
                cat_id: cart.category.id,
                domain: {
                    name: name,
                }
            }, options);
        }

        export function removeDomainInStep2(name: string, options: any) {
            var index = cart.domains[name.trim()].index;
            delete cart.domains[name.trim()];
            return post({
                do: 'removeitem',
                step: 2,
                target: 'domain',
                target_id: index,
            }, options);
        }

        export function changeDomainPeriod(name: string, period: number, options: any) {
            cart.domains[name.trim()].period = period;
            return post({
                do: 'changedomainperiod',
                key: cart.domains[name.trim()].index,
                period: period,
            }, options);
        }

        export function addDomainConfig(data: object, options: any = {}) {
            return post($.extend(
                data, //ns, contacts, period
                {do: 'setdomainsconfig', simulate: 1}
            ), options);
        }

        export function pushDomains(options: any = {}) {
            var data = {
                cat_id: cart.category.id,
                domains: []
            };
            data.domains.push(-1);
            for (var hostname in cart.domains) {
                var domain = cart.domains[hostname];
                data.domains.push({
                    id: domain.id,
                    name: domain.name,
                    period: domain.period,
                    type: domain.type,
                })
            }
            return post(data, options);
        }

        function getCheckDomainId(tld: string): number {
            if (cart.product && cart.category.id === cart.product.category_id) {
                for (let offer of cart.product.domains_offered) {
                    if (offer.name === tld) {
                        return offer.cat_id;
                    }
                }
            }
            return cart.category.id;
        }

        export function checkDomain(name: string, tld: string, options: any = {}) {
            options.type = 'POST';
            return Queue.add('/cart/v1/checkdomain', {
                cat_id: getCheckDomainId(tld),
                sld: name,
                tld: tld
            }, options);
        }

        function domains(type: string, prefix: string) {
            var data = {
                id: HBCart.cart.product.id,
                domains: [],
            };
            var i = 0;
            for (let name in cart.domains) {
                let item = cart.domains[name];

                data['domains'][i++] = {
                    id: item.id,
                    name: item.name,
                    period: item.period,
                };
            }
            return data;
        }

        export function pushConfig(options: any = {}) {
            var data = $.extend(
                product(),
                forms(),
                subitems('subproducts', 'subproducts'),
                subitems('addons', 'addon')
            );
            return post(data, options);
        }

        export function clearConfig(options: any = {}) {
            return post({
                id: HBCart.cart.product.id,
                custom: [0],
                addon: [0],
                subproducts: [0]
            }, options);
        }

        export function addCoupon(code: string, options: any = {}) {
            var data = {
                id: null,
                promocode: code
            };

            if (HBCart.cart.product && HBCart.cart.product.id)
                data.id = HBCart.cart.product.id;
            return post(data, options);
        }

        export function removeCoupon(options: any = {}) {
            return post({
                id: HBCart.cart.product.id,
                removecoupon: 1
            }, options);
        }

        export function setCurrency(cur: any = 0, options: any = {}) {
            return post({
                id: HBCart.cart.product.id,
                currency: cur
            }, options);
        }

        export function setLanguage(lang: any = 'english', options: any = {}) {
            return post({
                languagechange: lang
            }, options);
        }

        export function setTaxRegion(country: string, region: string, options: any = {}) {
            return post({
                country: country,
                state: region
            }, options)
        }

        export function signup(form: any, options: any = {}) {
            return post(form, options)
        }

        export function login(email: string, password: string, options: any = {}) {
            var data = {
                action: 'login',
                username: email,
                password: password
            }
            return post(data, options)
        }

        export function logout(options: any = {}) {
            options.type = 'GET';
            return Queue.add('/cart/v1/logout', {}, options);
        }

        export function setupOrder(options: any = {}) {
            var pr = product();
            if (!$.isEmptyObject(domains('', ''))) {
                delete pr.domain;
            }
            var data = $.extend(
                pr,
                forms(),
                subitems('subproducts', 'subproducts'),
                subitems('addons', 'addon'),
                {make: 'order'}
            );
            return post(data, options);
        }

        export function clearOrderId() {
            HBCart.cart.order = null;
        }

        export function submitOrder(gateway, note = '', tos = false, options: any = {}) {
            if (HBCart.cart.order)
                throw Error('Order subbmited, use clearOrder to reset it')

            var data = {
                gateway: gateway,
                note: note,
                tos: tos ? 1 : '',
            };
            return Queue.add('/cart/v1/order', data, options);
        }

        export function translate(list: Array<string>, options: any = {}) {
            options.type = 'POST';
            return Queue.add('/cart/v1/translate', {w: list}, options);
        }
    }


    export namespace Utils {

        export function wrapKeys(obj: Object, type: string = 'properties', override) {
            var key, value, wrapped;
            wrapped = {};
            for (key in obj) {
                value = obj[key];
                wrapped["" + type + "[" + key + "]"] = override != null ? override : value;
            }
            return wrapped;
        }

        export function unwrapKeys(obj: Object, type: string = 'properties', override) {
            var key, unwrapped, unwrappedKey, value;

            unwrapped = {};
            for (key in obj) {
                value = obj[key];
                unwrappedKey = key.replace("" + type + "[", "").replace("]", "");
                unwrapped[unwrappedKey] = override != null ? override : value;
            }
            return unwrapped;
        }

        export function extend(object: Object, properties) {
            var key, val;
            for (key in properties) {
                val = properties[key];
                object[key] = val;
            }
            return object;
        }

        export function clone(object) {
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

        export function ensureArray(value) {
            if (Array.isArray(value)) {
                return value;
            }
            if (value != null) {
                return [value];
            } else {
                return [];
            }
        }

        export function number_format(num, decimals, dec_point = '.', thousands_sep = ',') {
            num = (num + '').replace(/[^0-9+\-Ee.]/g, '');
            var n = !isFinite(+num) ? 0 : +num,
                prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
                s = [],
                toFixedFix = function (n, prec) {
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

        export function isNumber(n: any) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        }

        export function formatMoney(amount, currency) {
            var output = '';
            if (currency.before)
                output += currency.before;

            amount *= currency.rate
            output += number_format(amount, currency.precision, currency.decimal, currency.thousands);

            if (currency.after)
                output += ' ' + currency.after;
            return output;
        }

        export function createCookie(name, value, days) {
            var expires;

            if (days) {
                var date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toUTCString();
            } else {
                expires = "";
            }
            document.cookie = encodeURIComponent(name) + "=" + encodeURIComponent(value) + expires + "; path=/";
        }

        export function readCookie(name) {
            var nameEQ = encodeURIComponent(name) + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) === ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) === 0) return decodeURIComponent(c.substring(nameEQ.length, c.length));
            }
            return null;
        }
    }
    ;

    namespace Queue {
        var queue: Object[] = [];
        var processing: boolean = false;

        function notify(data, textStatus, request) {
            if (!data)
                return;

            var session = request.getResponseHeader('X-Cart-Session');
            if (session) {
                settings.session = session
                Utils.createCookie('Cart-Session', session, 7);
            }

            if (data.errors && data.errors.length) {
                $(document).trigger('cart.errors', [data.errors]);
            }
            if (data.info && data.info.length) {
                $(document).trigger('cart.info', [data.info]);
            }
        }

        export function add(url: string, data?: any, options?: any) {
            var url = settings.url + 'index.php?' + url;
            if (typeof options.step != 'undefined' || options.step) {
                data.step = options.step;
            }
            if (typeof options.simulate != 'undefined' || options.simulate) {
                data.simulate = options.simulate;
            }

            let request = {
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
                request.success.push($.proxy(cart.update, cart));
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
            $(document).trigger('cart.requestStarted', [cart]);
            return process();
        }

        function process() {
            var params;
            if (!queue.length) {
                processing = false;
                $(document).trigger('cart.requestComplete', [cart]);
                return;
            }
            processing = true;
            params = queue.shift();
            if (params.deffered.state() != 'pending')
                return process();

            params.complete.push(process);
            return $.ajax(params);
        }
    }


    export var cart = new Cart({});
    var settings = {
        url: window.location.href,
        session: Utils.readCookie('Cart-Session'),
        categoryId: null,
        productId: null,
        language: null, //inital language
        currency: null, //inital currency
        params: {},
        withCredentials: true, //share session with hostbill site ?
        requestBodyClass: null,
    };

}

