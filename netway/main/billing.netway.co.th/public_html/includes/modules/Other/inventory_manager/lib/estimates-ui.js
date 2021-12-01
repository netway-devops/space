function inventory_manager_items() {
    var uihook = $('#addliners'),
        inventoryline = $('#inventory-tr'),
        supported = $('#estimate_id').length>0 || $('#invoice-draft').length>0 || false;

    if (!supported || !uihook.length || inventoryline.length)
        return;

    uihook.after('<tr id="inventory-tr">\
            <td colspan="' + (uihook.find('td').length == 5 ? '1' : '2') + '"><strong>From Inventory Manager</strong> <select id="inventorymgr"></select></td>\
            <td><input name="nline_qty" size="7" style="text-align:center" value="1"></td>\
            <td><input name="nline_tax" type="checkbox" value="1"></td>\
            <td><input name="nline_price" id="price-from-inventory" size="13"></td>\
            <td colspan="2"><a href="#add" id="add-from-inventory" class="menuitm">Add line</a></td>\
        </tr>');


    var select = $('#inventorymgr').chosen({
        no_results_text: 'No Items',
        placeholder_text_single: 'Search for an Item',
        disable_search_threshold: -1,
        search_contains: true,
        allow_single_deselect: true,
    });
    
    
    
    var id = $('input[name=invoice_id]').val(),
        price = $('#price-from-inventory'),
        chosen = select.data('chosen'),
        xhr, textToSearch;

    function _search(inp_event) {
        var search = $(this);
        textToSearch = search.val();

        function reset(html) {

            var tmp = search.val();
            if (html)
                select.html(html)
            else
                select.empty()

            select.trigger("liszt:updated").trigger("change", true)
            search.val(tmp);
            chosen.results_show()
        }

        function reload(data) {
            xhr = false;
            chosen.results_none_found = 'No items found';

            if (textToSearch != '') {
                request();
            } else {
                reset();
            }

            if (data.length) {

                var categories = {};
                for (var i = 0, l = data.length; i < l; i++) {
                    var opt = data[i];
                    if (typeof categories[opt.category] == 'undefined')
                        categories[opt.category] = [];

                    var descr = '';
                    if (opt.doc_type == 'estimate') {
                        if (opt.document_id == id)
                            continue;
                        descr += '(Assigned to Estimate #' + opt.document_id + ')';
                    }

                    categories[opt.category].push('<option value="' + opt.id
                        + '" data-price="' + opt.retail_price
                        + '" data-name="' + opt.name
                        + '">#' + opt.id + ' ' + opt.name + ' #' + opt.code + ' ' + descr + ' </option>');
                }
                var html = '';
                for (var cat in categories) {
                    html += '<optgroup label="' + cat + '">';
                    html += categories[cat].join("\n");
                    html += '</optgroup>';
                }

                reset(html)
            }
        }
        function request() {
            if (xhr)
                return;

            chosen.results_none_found = 'Searching for ...';
            var q = textToSearch;
            textToSearch = '';

            xhr = $.ajax({
                url: '?cmd=inventory_manager&action=query&lightweight=1',
                data: {
                    q: q
                },
                success: reload,
                error: function () {
                    reload([]);
                }
            });

        }

        if (textToSearch != '')
            request();
    }

    chosen.search_container.on('keyup', 'input', _search);


    select.on('change', function (ev, onRefresh) {
        var data = select.find(':selected').data();
        if (data)
            price.val(data.price)

    });

    $('#add-from-inventory').on('click', function () {
        var self = $(this),
            cmdUrl = window.location.href.replace(/(id|action)=[^&]*&?/g, '').replace(/&$|&#/, ''),
            data = {};

        self.parents('tr:first').find('select, input').each(function () {
            var self = $(this),
                name = self.attr('name');
            if (name) {
                data[name.replace('nline_', '')] = name == 'nline_tax' ? (self.is(':checked') ? 1 : '') : self.val()
            }
        })

        data.id = id;
        data.action = 'addline';
        data.line = select.find(':selected').data('name');
        data.fromInventoryId = select.val();

        select.empty().trigger("liszt:updated");
        //select.children(':selected').prop('selected', false).trigger("liszt:updated");

        $.post(cmdUrl, data, function (data) {
            var resp = parse_response(data);
            $.post(cmdUrl, {
                id: id,
                action: 'updatetotals'
            }, function (data) {
                var resp = parse_response(data);
                if (resp && resp.length > 10) {
                    var $resp = $(resp)
                    $('#updatetotals').html($resp.filter('#updatetotals').html());
                    $('#main-invoice').html($resp.filter('#main-invoice').html());
                }
            });

        });
        return false;
    });
}

$(function () {
    $('head').append('<style>\n\
        #inventory-tr td{\
            background: #FFE98E;\
            font-size: 12px;\
            padding: 5px 12px;\
        }\
        #inventory-tr td + td{ text-align: center}\
        #inventory-tr td + td:last-child{ text-align: left}\
        #inventory-tr td select {min-width: 400px}\
        #inventory-tr .group-result{display: block}\
    </style>');

    $(document).ajaxComplete(function (ev, xhr, ajax) {
        if(ajax.url.match('cmd=invoices') && ajax.url.match('id='))
            inventory_manager_items();
    });

    inventory_manager_items();
})