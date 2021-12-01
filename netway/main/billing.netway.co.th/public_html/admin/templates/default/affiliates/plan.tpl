<form action="" method="post">
    {include file="affiliates/configuration_header.tpl"}
    <div class="lighterblue2">
        <table border="0" cellpadding="6" cellspacing="0" width="100%">
            <tr>
                <td width="220" align="right"><strong>{$lang.Name}</strong></td>
                <td><input class="inp" name="name" value="{$commision.name}"/></td>
            </tr>
            <tr>
                <td align="right" style="vertical-align: top; line-height: 25px">
                    <strong>{$lang.commission} {$lang.rate}</strong></td>
                <td>
                    <input class="inp" size="3" name="rate" value="{$commision.rate}"/>
                    <select class="inp" name="type">
                        <option value="Percent"
                                {if $commision.type=='Percent'}selected="selected"{/if}>{$lang.Percent}</option>
                        <option value="Fixed"
                                {if $commision.type=='Fixed'}selected="selected"{/if}>{$lang.Fixed}</option>
                    </select>


                    <div class="checkbox">
                        <label>
                            <input type="checkbox" {if $commision.recurring > 0}checked="checked"{/if} value="1"
                                   name="recurring">
                            {$lang.recurringaff}
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" {if $commision.otrates}checked{/if} value="1" id="ot-rates-toggle">
                            Change rates for recurring comission over time
                        </label>
                    </div>
                    <div id="ot-rates">
                        {foreach from=$commision.otrates|default:$otrate item=rate key=k name=otrates}
                            <div class="ot-rate" data-key="{$k}">
                                <input class="inp" size="3" name="ot[{$k}][rate]" value="{$rate.rate}"/>
                                <select class="inp" name="ot[{$k}][type]">
                                    <option value="Percent" {if $rate.type==='Percent'}selected="selected"{/if}>{$lang.Percent}</option>
                                    <option value="Fixed" {if $rate.type==='Fixed'}selected="selected"{/if}>{$lang.Fixed}</option>
                                </select>
                                after
                                <input class="inp" size="3" name="ot[{$k}][after]" value="{$rate.after}"/>
                                <select class="inp" name="ot[{$k}][time]">
                                    <option value="" {if $rate.time==''}selected="selected"{/if}>Period(s)</option>
                                    <option value="m" {if $rate.time=='m'}selected="selected"{/if}>Month(s)</option>
                                    <option value="y" {if $rate.time=='y'}selected="selected"{/if}>Year(s)</option>
                                </select>
                                <a class="btn btn-success btn-sm add-otrate" title="Add another"><i class="fa fa-plus"></i></a>
                                <a class="btn btn-danger btn-sm rem-otrate" title="Add another"><i class="fa fa-minus"></i></a>
                            </div>
                        {/foreach}
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>Affiliates Group</strong><br/>
                    <small>Limit this commission plan to affiliates in selected client groups</small>
                </td>
                <td>
                    <div class="row">
                        <div class="col-md-6">
                            <select multiple="multiple" name="applicable_client_groups[]" class="form-control chosen"
                                    id="applicable_client_groups">
                                <option value="all"
                                        {if $commision.applicable_client_groups.all == 'all'}selected="selected"{/if}>
                                    Apply to all client groups
                                </option>
                                {foreach from=$clientgroups item=group}
                                    <option value="{$group.id}"
                                            {if $commision.applicable_client_groups[$group.id]}selected="selected"{/if}>{$group.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right"><strong>Plan Assigment:</strong></td>
                <td>
                    <input type="checkbox" {if $commision.autoassign}checked{/if} value="1" id="auto-assign-toggle">
                    Automatically assign this plan to affiliate that has
                    <input type="text" size="3" value="{$commision.autoassign|default:1}" name="autoassign" class="inp"
                           id="auto-assign"/>
                    approved orders.
                </td>
            </tr>
            <tr>
                <td align="right"><strong>Overprovison:</strong></td>
                <td>
                    <input type="checkbox" {if $commision.enable_overcommission > 0}checked="checked"{/if} value="1"
                           name="enable_overcommission"/>
                    {$lang.enableovercommission}
                </td>
            </tr>
            <tr>
                <td align="right"><strong>{$lang.enablevouchers}:</strong></td>
                <td>
                    <input type="checkbox" {if $commision.enable_voucher > 0}checked="checked"{/if} value="1"
                           name="enable_voucher"/>
                    Allow affiliates to create vouchers based on this plan
                </td>
            </tr>

            <tr>
                <td align="right"><strong>{$lang.appliesto}:</strong></td>
                <td>
                    <div class="row">
                        <div class="col-md-6">
                            <label>{$lang.appliproduc} </label>
                            <select multiple="multiple" name="applicable_products[]" class="form-control"
                                    id="applicable_products" style="height: 300px;">
                                {foreach from=$products item=c}
                                    <option value="p{$c.category_id}" data-id="{$c.category_id}" data-category="true"
                                            {if $commision.applicable_products.products[$c.category_id]}selected="selected"{/if}>{$lang.Category}
                                        : {$c.category_name}</option>
                                    {foreach from=$c.products item=i}
                                        <option value="p{$i.id}" data-category="false" data-parent="{$c.category_id}"
                                                {if $commision.applicable_products.products[$i.id]}selected="selected"{/if}
                                                style="padding-left: 20px;">{$i.catname}: {$i.name}</option>
                                    {/foreach}
                                {/foreach}
                                {foreach from=$addons item=i }
                                    <option value="a{$i.id}"
                                            {if $commision.applicable_products.addons[$i.id]}selected="selected"{/if}>{$lang.Addon}
                                        : {$i.name}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label>{$lang.appcycles} </label>
                            <select multiple="multiple" name="applicable_cycles[]" id="cycles" class="form-control"
                                    style="height: 300px;">
                                <option value="all"
                                        {if $commision.applicable_cycles.all == 'all'}selected="selected"{/if}>{$lang.appallcyc}</option>
                                <option value="Hourly" {if $commision.applicable_cycles.Hourly} selected="selected"{/if}>{$lang.Hourly}</option>
                                <option value="Daily" {if $commision.applicable_cycles.Daily} selected="selected"{/if}>{$lang.Daily}</option>
                                <option value="Weekly" {if $commision.applicable_cycles.Weekly} selected="selected"{/if}>{$lang.Weekly}</option>
                                <option value="Monthly" {if $commision.applicable_cycles.Monthly} selected="selected"{/if}>{$lang.Monthly}</option>
                                <option value="Quarterly" {if $commision.applicable_cycles.Quarterly} selected="selected"{/if}>{$lang.Quarterly}</option>
                                {assign var='semi' value='Semi-Annually'}
                                <option value="Semi-Annually" {if $commision.applicable_cycles[$semi]} selected="selected"{/if}>{$lang.SemiAnnually}</option>
                                <option value="Annually" {if $commision.applicable_cycles.Annually} selected="selected"{/if}>{$lang.Annually}</option>
                                <option value="Biennially" {if $commision.applicable_cycles.Biennially} selected="selected"{/if}>{$lang.Biennially}</option>
                                <option value="Triennially" {if $commision.applicable_cycles.Triennially} selected="selected"{/if}>{$lang.Triennially}</option>
                                {foreach from=$periods item=p}
                                    {assign var='tld' value="tld$p"}
                                    <option value="tld{$p}" {if $commision.applicable_cycles.$tld} selected="selected"{/if}>{$lang.Domains} {$p} {if $p < 2}{$lang.Year}{else}{$lang.years}{/if}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td width="160" align="right"><strong>{$lang.notesadmin}</strong></a></td>
                <td>
                    <textarea name="notes" class="form-control">{if $commision.notes}{$commision.notes}{/if}</textarea>
                </td>
            </tr>
        </table>
    </div>
    <div class="blu">
        <table border="0" cellpadding="2" cellspacing="0">
            <tr>
                <td>
                    <a href="?cmd={$cmd}&action=configuration&tab=commisions"><strong>&laquo; {$lang.backto} {$lang.commission_plans}</strong></a>&nbsp;
                </td>
                <td><input type="submit" name="save"
                           value="{if $make=='add'}{$lang.addcommision}{else}{$lang.savechanges}{/if}"
                           style="font-weight:bold;"/></td>
            </tr>
        </table>
    </div>
    {securitytoken}
</form>
{literal}
    <style>
        #ot-rates .ot-rate {
            margin: 4px 0;
        }

        #ot-rates .add-otrate,
        #ot-rates .ot-rate:last-child .rem-otrate {
            display: none;
        }

        #ot-rates .ot-rate:last-child .add-otrate {
            display: inline-block
        }
    </style>
    <script>
        $(function () {
            $('#applicable_products').change(function () {
                var select = $(this);
                select.find(":selected").each(function () {
                    var opt = $(this);
                    if (opt.attr('data-category') == 'true') {
                        var id = opt.attr('data-id');
                        select.find('[data-category="false"][data-parent="' + id + '"]').prop('selected', true);
                    }
                });
            });
            $('#auto-assign-toggle').on('change init', function () {
                var disabled = !$(this).is(':checked'),
                    things = $('#auto-assign');
                things.toggleClass('disabled', disabled)
                    .prop('disabled', disabled)
            }).trigger('init');

            $('#ot-rates-toggle').on('change init', function () {
                var disabled = !$(this).is(':checked'),
                    things = $('input, select, .btn', '#ot-rates');
                things.toggleClass('disabled', disabled)
                    .prop('disabled', disabled)
            }).trigger('init');

            $('#ot-rates').on('click', '.rem-otrate', function () {
                $(this).closest('.ot-rate').remove();
            })
            $('#ot-rates').on('click', '.add-otrate', function () {
                var self = $(this).closest('.ot-rate'),
                    index = self.data('key') + 1,
                    clone = self.clone();

                clone.data('key', index).find('input, select').each(function () {
                    var i = $(this),
                        name = i.attr('name'),
                        newname = name.replace('[' + (index - 1) + ']', '[' + index + ']');

                    i.attr('name', newname);
                    if (newname.indexOf('after') > 0)
                        i.val(1 * i.val() + 1);
                    else
                        i.val(self.find('[name="' + name + '"]').val())
                });
                clone.insertAfter(self);
            })

            $('.chosen').chosenedge({
                width: '100%',
                enable_split_word_search: true,
                search_contains: true
            })
        })
    </script>
{/literal}
