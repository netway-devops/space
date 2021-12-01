<div id="refund-menu" bootbox data-title="Refund invoice" data-btntitle="{$lang.refund}" style="display: none">
    <form action="?cmd=invoices&action=edit&id={$invoice_id}&list={$currentlist}" method="post"
          onsubmit="$('#bodycont').addLoader();">
        <input type="hidden" name="refund" value="1" />
        <div class="form-group">
            <label>Refund type</label>
            <select name="refund_type" id="refundtype" class="form-control">
                {foreach from=$rtypes item=rt}
                    <option value="{$rt}">
                        {$lang[$rt]}
                    </option>
                {/foreach}
            </select>
        </div>
        {if $transactions}
            <table class="table table-striped" >
                <thead>
                <tr>
                    <th colspan="2">Transactions</th>
                    <th>Amount to refund</th>
                </tr>
                </thead>
                <tbody>
                {foreach from=$transactions item=t}
                    <tr>
                        <td style="width:30px">
                            <input name="transaction[{$t.id}][id]" type="checkbox"
                                   value="{$t.id}" checked class="refund-toggle"/>
                        </td>
                        <td>{$t.module} - {$t.trans_id}</td>
                        <td style="width: 160px">
                            <input type=text value="{$t.amount|price:$currency:false}" max="{$t.amount}" min="0" size="16"
                                   placeholder="Max: {$t.amount|price:$currency}"
                                   name="transaction[{$t.id}][amount]"
                                   class="foc text-right refund-amount"/>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {/if}
        {if $credit_note}
            <hr />
            <div class="form-group">
                <label>Credit Note</label>
                <div class="checkbox">
                    <label>
                        <input name="creditnote" type="checkbox" value="1" id="creditnote-toggle"
                               {if $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid'}checked{/if}/>
                        Issue new Credit note
                    </label>
                </div>
            </div>
            <table class="table table-striped" id="creditnote-table">
                <thead>
                <tr>
                    <th colspan="2">Invoice items</th>
                    <th style="width: 160px" class="text-center">Qty</th>
                    <th style="width: 160px">Amount to refund</th>
                </tr>
                </thead>
                <tbody>
                {foreach from=$items item=item}
                    <tr class="credit-row" id="credit_item_{$item.id}">
                        <td style="width:30px">
                            <input type="checkbox" id="item{$item.id}" value="1" data-rel="{$item.id}"
                                   name="credititem[{$item.id}][enabled]" checked="checked"
                                   class="credititem"/>
                        </td>
                        <td>{$item.description|nl2br}</td>
                        <td>
                            <input type=text value="{$item.qty}" max="{$item.qty}" min="0" size="8"
                                   name="credititem[{$item.id}][qty]"
                                   class="foc creditqty text-center"/>
                        </td>
                        <td>
                            <input type=text value="{$item.amount|price:$currency:false}" max="{$item.amount}" min="0" size="16"
                                   placeholder="Max: {$item.amount|price:$currency}"
                                   name="credititem[{$item.id}][amount]"
                                   class="foc creditamount text-right"/>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {/if}
        <hr />
        <div class="form-group">
            <label>
                Total amount to refund
                <a href="#" class="vtip_description">
                    <span>
                        If you want to use automatic gateway refund, maximum refund amount will be capped to selected
                        transaction amount
                    </span>
                </a>
            </label>
            {if !$transactions}
                <p><em>There are not transactions to refund</em></p>
            {/if}
            <strong id="refundamount" type="text"></strong>
        </div>
        <div class="form-group">
            <label>Post action</label>
            <select name="post_action" class="form-control">
                <option value="nothing">Return to invoice</option>
                <option value="terminate">Terminate related account</option>
                <option value="close">Close client profile</option>
                <option value="close_ban">Close client profile, ban client IP</option>
                <option value="delete">Delete client account</option>
                <option value="suspend">Suspend client account</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="1" name="notify"/>
                Notify customer
            </label>
        </div>
        {securitytoken}
    </form>
</div>
{literal}
<script type="text/javascript">
    $(function () {
        $('#refund-menu').bootboxform({
            size: 'large'
        }).on('bootbox-form.shown', function (e, dialog) {
            var refund_in_toggle =  $('.refund-toggle', dialog),
                refund_in_amount =  $('.refund-amount', dialog),
                refund_total = $('#refundamount', dialog),
                credit_table = $('#creditnote-table', dialog),
                format = new CurrencyFormat({/literal}{$currency|@json_encode}{literal});

            $('.credititem', dialog).change(function () {
                var that = $(this);
                that.closest('tr').find('.creditamount, .creditqty').prop('disabled', !that.is(':checked'));
            });

            $('#creditnote-toggle', dialog).on('click init', function () {
                credit_table.toggle(this.checked);
            }).trigger('init');

            $('input[max]', dialog).on('change blur', function () {
                var self = $(this),
                    val = format.unformat(self.val()) * 1.0,
                    max = self.attr('max') * 1.0;

                if (val > max) {
                    self.val(format.formatNumber(max)).trigger('init');
                }
            });

            var handle_transactions = function(){
                var total = 0;
                refund_in_toggle.each(function (i) {
                    var input = refund_in_amount.eq(i);
                    input.prop('disabled', !this.checked);
                    total += this.checked ?  format.unformat(input.val()) * 1 : 0;
                });
                refund_total.text(format.format(total));
            };

            refund_in_amount.on('change blur init', handle_transactions);
            refund_in_toggle.on('change init', handle_transactions);
            refund_in_toggle.eq(0).trigger('init');

        }).trigger('show')
    });
</script>
{/literal}