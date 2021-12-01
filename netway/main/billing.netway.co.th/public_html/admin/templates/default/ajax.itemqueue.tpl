<div class="panel" id="invoice-queue-items" {if $place}style="margin-bottom: 5px;" {/if}>
    {if !$items}
        <em>There are not Invoice Items in queue yet</em>
    {else}
        <ul class="list-group">
            {foreach from=$items item=f}
                <li class="list-group-item row no-gutter">
                    <div class="col-xs-1 pull-right text-right">
                        {if !$place || ($account.billingcycle != 'One Time' && $account.billingcycle != 'Free')}
                            <a href="#" title="{$lang.Delete}" class="item-delete" data-id="{$f.id}">
                                <i class="fa fa-times" style="color:red"></i>
                            </a>
                        {/if}
                    </div>
                    <div class="{if !$place || ($account.billingcycle != 'One Time' && $account.billingcycle != 'Free')}col-xs-9{else}col-xs-10{/if}">
                        {if !$place || ($account.billingcycle != 'One Time' && $account.billingcycle != 'Free')}
                            <a href="#" data-edit="{$f|@json_encode|escape}" class="item-edit">{$f.description|escape}</a>
                        {else}
                            {$f.description|escape}
                        {/if}
                        <br/>
                        {if !$place}
                            <em>
                                {if $f.service}
                                    for
                                    <a href="?cmd=accounts&action=edit&id={$f.service.id}">#{$f.service.id} {$f.service.name}{if $f.service.domain} - {$f.service.domain}{/if}</a>
                                {elseif $f.rel_id}
                                    for
                                    {if $f.rel_type == 'Hosting'}
                                        service
                                        <a href="?cmd=accounts&action=edit&id={$service.id}">#{$f.rel_id}</a>
                                    {elseif $f.rel_type == 'Domain'}
                                        domain
                                        <a href="?cmd=accounts&action=edit&id={$service.id}">#{$f.rel_id}</a>
                                    {/if}
                                {else}
                                    for any service
                                {/if}
                            </em>
                        {/if}
                    </div>
                    <div class="col-xs-2">
                        {$f.total|price:$client_currency}
                    </div>
                </li>
            {/foreach}
        </ul>
    {/if}
</div>

{if !$forbidAccess.editClients}
    {if !$place || ($account.billingcycle != 'One Time' && $account.billingcycle != 'Free')}
        <a href="#" class="btn btn-default btn-sm item-add">
            <i class="fa fa-plus"></i> Add Item
        </a>
    {/if}
        <a href="{if !$place}?cmd=clients&action=itemqueue&client_id={$client_id}{else}?cmd=accounts&action=getqueue&id={$account_id}&account_id={$account_id}&product_id={if $pid}{$pid}{else}{$details.product_id}{/if}{/if}" id="itemqueue-refresh"
           class="btn btn-default btn-sm">
            <i class="fa fa-refresh"></i> Refresh
        </a>
    <div id="itemqueueform" class="modal-content" hidden bootbox data-title="Add new item to queue">
        <input type="hidden" name="client_id" value="{if !$place}{$client_id}{else}{$client.id}{/if}"/>

        <div class="row">
            <div class="col-md-5 col-sm-5">
                <div class="form-group">
                    <label class="control-label">{$lang.Description}</label>
                    <input type="text" name="queueitem[description]" class="form-control"
                           placeholder="Item name and description" data-required/>
                </div>
            </div>

            <div class="col-md-2 col-sm-2">
                <div class="form-group">
                    <label class="control-label">{$lang.qty}</label>
                    <input type="number" name="queueitem[qty]" class="form-control"
                           min="1" value="1" data-required/>
                </div>
            </div>
            <div class="col-md-2 col-sm-2">
                <label class="control-label">{$lang.tax}</label>
                <div class="input-group input-combo">
                    <input type="hidden" name="queueitem[taxed]" value="0" />
                    <input name="queueitem[tax_rate]" class="form-control"
                           type="text"  size="3" value="{$lang.nontax}" data-toggle="dropdown" />
                    <span class="caret"></span>
                    <ul class="tax-rates dropdown-menu dropdown-menu-right" role="menu">
                        <li><a data-value="{$lang.nontax}" data-notax id="tax-rate-none">{$lang.nontax}</a></li>
                        {foreach from=$client_tax_rates item=taxr}
                            <li><a data-value="{$taxr}">{$taxr}%</a></li>
                        {/foreach}
                    </ul>
                </div>
            </div>
            <div class="col-md-3 col-sm-3">
                <div class="form-group">
                    <label class="control-label">{$lang.price}</label>
                    <div class="input-group">
                        <input type="text" name="queueitem[amount]" class="form-control" value="1" data-required/>
                        <div class="input-group-addon">{if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label">{$lang.Note}</label>
            <textarea name="queueitem[note]" class="form-control"
                      placeholder="Short note about this item. It will be copied to invoice notes"></textarea>
        </div>

        {if $place == 'accounts'}
            <input type="hidden" name="queueitem[rel_type]" value="Hosting"/>
            <input type="hidden" name="queueitem[rel_id]" value="{$account_id}"/>
        {else}
            <div class="form-group">
                <label class="control-label">Add to next invoice for service</label>
                <select name="queueitem[rel_id]" class="form-control">
                    <option value="0">{$lang.Any}</option>
                    {foreach from=$services item=service}
                        <option value="{$service.id}">
                            #{$service.id} {$service.catname}: {$service.name}{if $service.domain} {$service.domain}{/if}</option>
                    {/foreach}
                </select>
            </div>
        {/if}
    </div>
{literal}
    <script type="text/javascript">
        $(function () {
            var $itemqueue = $('#itemqueue'),
                refresh_url = $itemqueue.find('#itemqueue-refresh').attr('href');

            $itemqueue.off('.itemqueue');

            function parse(data) {
                data = parse_response(data);

                if (data && data.length > 2) {
                    var automation_queue = $('#autoqueue');
                    if(automation_queue.length){
                        automation_queue.html(data);
                    }else{
                        $('#itemqueue').html(data);
                    }
                }
            }

            $('#itemqueueform', $itemqueue).bootboxform({
                formaction: refresh_url,
                callback: function (e, ele) {
                    var form = $('form', this)

                    form.find('[data-required]').trigger('input')
                    if(form.find('.has-error').length)
                        return false;

                    $.post(refresh_url, form.serializeForm(), parse);
                    return true;
                }
            }).on('bootbox-form.shown', function (e, dialog) {
                dialog.find('input, select, textarea').on('input',function () {
                    $(this).closest('.form-group').toggleClass('has-error', this.value.length === 0)
                });
                dialog.find('select').chosenedge({width: '100%'})
                dialog.on('click', '.tax-rates a', function () {
                    var self = $(this),
                        combo = self.closest('.input-combo');

                    combo.find('input[name$="[taxed]"]').val(self.data('notax') === undefined ? 1 : 0);
                    combo.find('input[name$="[tax_rate]"]').val(self.data('value')).trigger('change');
                })
            });


            $itemqueue.on('click.itemqueue', '.item-edit', function () {
                var data = $(this).data('edit'),
                    modal = $('#itemqueueform').clone(true);

                data.tax_rate = data.taxed === '1' ? data.tax_rate : $('#tax-rate-none').text();

                modal.on('bootbox-form.shown', function (e, dialog) {
                    Object.keys(data).map(function (value) {
                        var form = dialog.find('[name="queueitem[' + value + ']"]');
                        if (!form.length)
                            return;

                        if (form.is('[type=checkbox]')) {
                            form.prop('checked', data[value] == 1)
                        } else {
                            form.val(data[value])
                        }
                        if (form.is('select'))
                            form.trigger('chosen:updated')
                    });
                    dialog.find('form').append('<input type="hidden" name="item_id" value="' + data.id + '" />')
                }).trigger('show', {
                    title: 'Edit Item'
                });
                return false;
            });

            $itemqueue.on('click.itemqueue', '.item-delete', function () {
                if (!confirm('Are you sure you want to delete this item?'))
                    return false;

                $itemqueue.addLoader();
                $.post(refresh_url, {
                    item_id: $(this).data('id'),
                    do: 'delete'
                }, parse);

                return false;
            });

            $itemqueue.on('click.itemqueue', '#itemqueue-refresh', function () {
                $itemqueue.addLoader();
                $.get(refresh_url, parse);
                return false;
            });

            $itemqueue.on('click.itemqueue', '.item-add', function () {
                $('#itemqueueform').trigger('show');
                return false;
            });

        });
    </script>
{/literal}
{/if}