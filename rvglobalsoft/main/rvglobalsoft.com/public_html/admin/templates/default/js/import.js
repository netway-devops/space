function init_import_form() {
    $(".chosen").chosenedge({
        width: "100%",
        disable_search_threshold: 5,
        allow_single_deselect: true,
        display_disabled_options: false,
        enable_split_word_search: true,
        search_contains: true
    });

    var tpl_item = Handlebars.compile(document.getElementById('import-item-tpl').innerHTML);
    var fhandles = {},
        table = $('#import-items'),
        clients = $('#client-search'),
        products = $("#import-product"),
        alerts = $('#alerts'),
        domains = $('#domains');

    clients.chosensearch();

    if (domains.length) {
        fhandles.select_all = function (data) {
            domains.children().each(function () {
                if (this.text.endsWith(data.product.name)) {
                    this.selected = true;
                }
            });
        };

        fhandles.get_items = function (data) {
            if (!domains.val())
                throw Error('Select at last one domain to import!');

            domains.find(':selected').each(function () {
                if (this.value !== '') {
                    data.items.push({
                        id: this.value,
                        name: this.text,
                    })
                }
            });
        };

        fhandles.unset_items = function (items) {
            domains.children().each(function () {
                if (items.indexOf(this.value) !== -1) {
                    this.disabled = false;
                }
            });
            domains
                .trigger('change')
                .trigger('chosen:updated');
        };

        fhandles.set_items = function (items) {
            domains.children().each(function () {
                if (items.indexOf(this.value) !== -1) {
                    this.disabled = true;
                }
            });
            domains.val('')
                .trigger('change')
                .trigger('chosen:updated');
            products.trigger('change')
        };

        domains.on('change', function () {
            var all = false,
                value = (domains.val() || []).filter(function (id) {
                    return id !== '';
                });

            if (!value.length) {
                all = true;
                value = domains.children().map(function () {
                    return this.disabled ? '' : this.value;
                }).get().filter(function (id) {
                    return id !== '';
                });
            }

            var tlds = value.map(function (name) {
                // name.co.uk-> ['.co.uk', '.uk']
                return name.split('.').reduce(function (re, part, i, self) {
                    if (i === 0) {
                        return re
                    }
                    re.push('.' + self.slice(i).join('.'));
                    return re;
                }, []);
            });

            if (all) {
                tlds = unique([].concat.apply([], tlds));
            } else {
                tlds = intersection.apply(null, tlds);
            }

            products.find('option').prop('disabled', false).each(function () {
                if (tlds.indexOf(this.text) < 0) {
                    $(this).prop('disabled', true)
                }
            });

            products.val(products.val())
                .trigger('change')
                .trigger('chosen:updated');
        }).trigger('change');

        products.on('change', function () {
            var btn = $('#add-all');
            if (!products[0].selectedOptions.length) {
                btn.prop('disabled', true).addClass('disabled');
                return;
            }

            btn.prop('disabled', false).removeClass('disabled');
            $('span', btn).text(products[0].selectedOptions[0].text + ' domains')
        }).trigger('change');
    }

     function hashstr(str) {
        var hash = 0, i, chr;
        if (str.length === 0) return hash;
        for (i = 0; i < str.length; i++) {
            chr   = str.charCodeAt(i);
            hash  = ((hash << 5) - hash) + chr;
            hash |= 0; // Convert to 32bit integer
        }
        return hash;
    };
    function importItems(items_cb) {

        var data = {
            product: {
                id: products.val(),
                name: products[0].selectedOptions.length && products[0].selectedOptions[0].text,
                category: products[0].selectedOptions.length
                    && products[0].selectedOptions[0].parentElement.getAttribute('label')
            },
            client: {
                id: clients.val(),
                name: clients[0].selectedOptions.length && clients[0].selectedOptions[0].text
            },
            items: [],
            value: ''
        };


        var msg = [];
        try {
            items_cb && items_cb(data);
            fhandles.get_items(data);
        } catch (e) {
            msg.push(e)
        }

        if (!data.items.length && !msg.length)
            msg.push('Select at last one item to import!')

        if (!data.client.id)
            msg.push('Select target client!');

        if (!data.product.id)
            msg.push('Select target product!')

        if (msg.length) {
            alert(msg.join("\n"));
            return false;
        }

        var ids = data.items.map(function (item) {
            return item.id
        });
        data.value = ids.join(',');


        data.index = hashstr(data.value + '_' + data.product.id + '_' + data.client.id);
        table.prepend(tpl_item(data));
        fhandles.set_items(ids);

        return false;
    }

    $('#add-all').click(function () {
        importItems(function (data) {
            fhandles.select_all(data)
        });
        return false;
    });

    $('#add').click(function () {
        importItems();
        return false;
    });

    table.on('click', '.rem', function () {
        var self = $(this),
            tr = self.parents('tr:first'),
            items = tr.find('input[name*=items]').val();

        tr.remove();
        fhandles.unset_items(items.split(','));
        return false;
    })


    function unique(array) {
        var a = array.concat();
        for (var i = 0; i < a.length; ++i) {
            for (var j = i + 1; j < a.length; ++j) {
                if (a[i] === a[j])
                    a.splice(j--, 1);
            }
        }
        return a;
    }

    function intersection(...lists) {
        var result = [], currentList, currentValue;
        if (lists.length === 1)
            return lists[0];

        for (var i = 0; i < lists.length; i++) {
            currentList = lists[i];
            for (var y = 0; y < currentList.length; y++) {
                currentValue = currentList[y];
                if (result.indexOf(currentValue) === -1) {
                    if (lists.filter(function (obj) {
                        return obj.indexOf(currentValue) === -1
                    }).length === 0) {
                        result.push(currentValue);
                    }
                }
            }
        }
        return result;
    }
}