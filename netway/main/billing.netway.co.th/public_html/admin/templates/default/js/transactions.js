
$(function () {

    var invoicebody = $('#bodycont'),
        tpl_item = document.getElementById('add-item-tpl') ? Handlebars.compile(document.getElementById('add-item-tpl').innerHTML): '',
        currency = {},
        partialin = $('#partial-in'),
        partialout = $('#partial-out'),
        picker =  $('#type-invoice select[name=invoice_id]'),
        totalin = $('#total-in'),
        totalout = $('#total-out'),
        table = $('#import-items'),
        form = $('#transaction-form');


    table.zero = function(){
        var self = $(this);
        self.find('tr').not('.placeholder').remove();
        self.data('totalin',0);
        self.data('totalout',0);
    };

    table.calculate = function(){

        var self = $(this),
        tin = 0,
        tout = 0;

        self.find('tr').not('.placeholder').each(function(){

            tin= tin + parseFloat($(this).find('.amountin').val());
            tout= tout + parseFloat($(this).find('.amountout').val());

        });

        self.data('totalin',tin);
        self.data('totalout',tout);
    };

    form.on('submit',function(){
        table.calculate();

        var trtype = $('input[name=type]:checked').val();
        var ifloat = parseFloat(totalin.val()),
            ofloat = parseFloat(totalout.val()),
            tablein = parseFloat(table.data('totalin')),
            tableout = parseFloat(table.data('totalout'));

        if (ifloat <= 0 && ofloat <= 0) {
            alert('Please enter total amount in / out first');

            return false;
        }

        if(trtype === 'bulk'){
            if(table.find('tr').not('.placeholder').length < 1){
                alert('Please attach at least one invoice');
                return false;
            }

            if(tablein < ifloat) {
                return confirm("Total amount in of sub-transactions of attached invoices is less than total amount entered. \r\nDifference will go into client profile as credit, please confirm ");
            } else if(tablein > ifloat) {
                alert('Total amount in of sub-transactions of attached invoices cannot be greater than total amount entered');
                return false;
            }
        }

        return true;
    });

    totalin.on('change', function (){
        table.calculate();
        var ifloat = parseFloat(totalin.val()),
            ofloat = parseFloat(totalout.val()),
            tablein = parseFloat(table.data('totalin')),
            tableout = parseFloat(table.data('totalout'));

        if(ifloat < tablein){
            totalin.val(table.data('totalin'))
        }
        if(ofloat < tableout){
            totalout.val(table.data('totalout'))
        }
    })

    table.on('change', '.amountin, .amountout', function(){
        table.calculate();

        var self = $(this),
            ifloat = parseFloat(totalin.val()),
            ofloat = parseFloat(totalout.val()),
            tablein = parseFloat(table.data('totalin')),
            tableout = parseFloat(table.data('totalout'));

        var max_round = function(val){
            return Math.max(0, Math.round(val * 100) / 100);
        }

        if (self.is('.amountin')) {
            tablein > ifloat && self.val(max_round(ifloat - (tablein - self.val()) ));
        } else {
            tableout > ofloat && self.val(max_round(0, ofloat - (tableout - self.val()) ));
        }
    })

    invoicebody.on('click', '#invoice-draft #clientloader a.btn', function (e) {
        var select = $('#clientloader select'),
            value = select.val();
        if (value != 0 && value != '')
            select.trigger('confirm');
        return false;
    });

    invoicebody.initpicker = function() {
       picker.chosenedge(
            {
                width:'100%',
                enable_split_word_search: true,
                display_disabled_options: false,
                search_contains: true
            }
        ).change(function(){
           var self = $(this),
               option = self.find(':selected'),
                balance = option.data('balance');

            if(self.val() && balance !== undefined) {
                partialin.val(balance.replace(/-/,''));

            }
       });

        table.zero();

    };

    function importItems(items_cb) {
        table.calculate();

        var ain = partialin.val(),
            fin = parseFloat(ain),
            aout = partialout.val(),
            fout = parseFloat(aout),
            ifloat = parseFloat(totalin.val()),
            ofloat = parseFloat(totalout.val()),
            tablein = parseFloat(table.data('totalin')),
            tableout = parseFloat(table.data('totalout')),
            items = {
            id: picker.val(),
            name: '',
            amountin: ain,
            amountout: aout,
            amountinf: currency.format(fin),
            amountoutf: currency.format(fout)
        };


        var msg = [];
        try {
            items_cb && items_cb(items);
        } catch (e) {
            msg.push(e)
        }

        if (!items.id && !msg.length)
            msg.push('Select invoice to attach!')



        if (ifloat <= 0 && ofloat <= 0)
            msg.push('Please enter total amount in / out first');

        if (fin <= 0  && fout <= 0)
            msg.push('Enter positive value for: Amount in or Amount out');

        if (ifloat > 0 && (fin + tablein) > ifloat) {
            msg.push('Sub-transaction Amount in cannot be higher than: ' + currency.format(ifloat - tablein) );
        }
        if(ofloat > 0 && (fout + tableout) > ofloat) {
            msg.push('Sub-transaction Amount in cannot be higher than: ' + currency.format(fout - tableout));
        }

        if (msg.length) {
            alert(msg.join("\n"));
            return false;
        }


        picker.children().each(function () {
            if (items.id == this.value ) {
                this.disabled = true;
                items.name = $(this).data('name');
            }
        });
        picker.val('').trigger('change').trigger('chosen:updated');


        partialin.val('0.00');
        partialout.val('0.00');

        table.prepend(tpl_item(items));
        table.calculate();


        return false;
    }

    $('#add').click(function () {
        importItems();
        return false;
    });



    table.on('click', '.rem', function () {
        var self = $(this),
            tr = self.parents('tr:first'),
            id = tr.find('input[name*=id]').val();

        tr.remove();
        picker.children().each(function () {
            if (id == this.value ) {
                this.disabled = false;
            }
        });
        picker
            .trigger('change')
            .trigger('chosen:updated');

        table.calculate();

        return false;
    })

    invoicebody.on('change confirm','#invoice-draft #clientloader select',function(e) {
        var id = $(this).val(),
            trtype = $('input[name=type]:checked');
        if(id) {
            $.get('?cmd=clients&action=getClientCurrency&id='+id, function(data){
                if(data.currency){
                    currency = new CurrencyFormat(data.currency);
                    $('.currency_sign').text(data.currency.sign);
                    $('.currency_code').text(data.currency.code);
                }
            });
            $.post('?cmd=transactions&action=listclientinvoices',{client_id:id},function(data) {
                var resp = parse_response(data);
                if(resp) {
                    $('#type-invoice').html(resp);
                    picker =  $('#type-invoice select[name=invoice_id]');
                    invoicebody.initpicker();
                }
            });

            $('#form-submit').removeAttr('disabled');
            $('#client-name').text($(this).find('option:selected').text());
        } else {
            $('#form-submit').attr('disabled','disabled');
        }

        return false;
    });

    invoicebody.on('change confirm', '#invoice-draft .invoice-type input, #invoice-draft #clientloader select', function (e) {
        var self = $(this),
            step = self.parents('.draft-step:first'),
            navs = $('#client_tab .hbnav li'),
            type = $('input[name=type]:checked').val();

        $('.type-invoice,.type-bulk,.type-credit').hide();
        $('.type-'+type).show();

        table.zero();

        if (self.is('select') && e.type != 'confirm')
            return false;

        step.hide();
        step.next().show();
        navs.removeClass('active');
        var index = step.index() + 1;

        navs.eq(index).addClass('active');

        return false;
    });

    invoicebody.on('click', '#invoice-draft .draft-steps a', function (e) {
        var self = $(this),
            navs = $('#client_tab .hbnav li'),
            steps = $('#client_tab .draft-step');

        var index = self.parent().index(),
            aindex = navs.filter('.active:last').index();

        if (aindex < index) {
            return false; //lock disabled steps
        }

        navs.removeClass('active');
        self.parent().addClass('active');
        steps.hide().eq(index).show();
        //$('#invoice-actions').hide()
        return false;
    });


    $('.setStatus', '#bodycont').dropdownMenu({}, function (action, el, pos) {

        window.location = action;

    });
});