<div id="creditnote-menu" bootbox data-title="Issue credit note" style="display: none">

    <form action="?cmd=invoices&action=issuecreditnote&id={$invoice_id}&list={$currentlist}" method="post"
          onsubmit="$('#bodycont').addLoader();">
        <div class="form-group">
            <label>Action</label>
            <select class="form-control" name="cnote_type" id="refundtype">
                <option value="just_note">Issue credit note</option>
                <option value="note_and_credit">Issue credit note + add credit to this invoice</option>
            </select>
        </div>
        <table class="table table-striped" id="cnotebox">
            <thead>
                <tr>
                    <th colspan="2">Description</th>
                    <th class="text-center">Qty</th>
                    <th>Amount to credit</th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$items item=item}
                    <tr class="credit-row" id="credit_item_{$item.id}">
                        <td style="width:30px">
                            <input type="checkbox" id="item{$item.id}" value="1" data-rel="{$item.id}"
                                   name="credititem[{$item.id}][enabled]" checked="checked"
                                   class="credititem" />
                        </td>
                        <td>{$item.description|nl2br}</td>
                        <td>
                            <input type=text value="{$item.qty}" max="{$item.qty}" min="0" size="8"
                                   name="credititem[{$item.id}][qty]"
                                   class="foc creditqty text-center"/>
                        </td>
                        <td>
                            <input type=text value="{$item.amount}" max="{$item.amount}" min="0" size="16"
                                   name="credititem[{$item.id}][amount]"
                                   class="foc creditamount text-right" />
                        </td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
        <hr />
        <div class="form-group">
            <label>Credit note total</label>
            <strong id="creditamount" type="text"></strong>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="1" name="notify"/>
                Notify customer
            </label>
        </div>
        <input type="hidden" value="1" name="issuecreditnote" />
        {securitytoken}
    </form>
    {literal}
    <script type="text/javascript">

        $(function () {
            $('#creditnote-menu').bootboxform({
                size: 'large'
            }).on('bootbox-form.shown', function (e, dialog) {
                var credit_in_toggle =  $('.credititem', dialog),
                    credit_in_qty =  $('.creditqty', dialog),
                    credit_in_amount =  $('.creditamount', dialog),
                    credit_total = $('#creditamount', dialog),
                    format = new CurrencyFormat({/literal}{$currency|@json_encode}{literal});

                $('input[max]', dialog).on('change blur', function () {
                    var self = $(this),
                        val = self.val() * 1.0,
                        max = self.attr('max') * 1.0;

                    if (val > max) {
                        self.val(max).trigger('init');
                    }
                });

                var handle_items = function(){
                    var total = 0;
                    credit_in_toggle.each(function (i) {
                        var input = credit_in_amount.eq(i),
                            qty = credit_in_qty.eq(i);
                        input.prop('disabled', !this.checked);
                        total += this.checked ? input.val() * qty.val() : 0;
                    });
                    credit_total.text(format.format(total));
                };

                credit_in_amount.on('change blur init', handle_items);
                credit_in_qty.on('change init', handle_items);
                credit_in_toggle.on('change init',function (e) {
                    var that = $(this);
                    that.closest('tr').find('.creditamount, .creditqty').prop('disabled', !that.is(':checked'));

                    handle_items.call(this, e);
                });

                credit_in_toggle.eq(0).trigger('init');

            }).trigger('show')
        });
    </script>
    {/literal}
</div>