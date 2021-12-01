{include file="affiliates/top_nav.tpl"}

<h4 class="mb-4">{$lang.selectcommplan}</h4>

<section class="section-affiliates-newvoucher">
    {if !$plan}
        <form action="" method="POST" onsubmit="window.location.href = '{$ca_url}{$cmd}/{$action}/&plan=' + $(this).find('input[name=\'plan\']:checked').val();return false;">
            {foreach from=$commisionplans item=plan name=ul}
                <div class="card">
                    <div class="card-body">
                        <div class="form-check">
                            <input  type="radio" name="plan" value="{$plan.id}" onclick="toggle_items({$smarty.foreach.ul.iteration});">
                            <label class="form-check-label">
                                {$plan.name}
                                {if $plan.type=='Percent'}{$plan.rate}%
                                {else}{$plan.rate|price:$affiliate.currency_id}
                                {/if}
                                {$lang.commission}
                            </label>
                        </div>
                        <div class="mt-3 items_list items_{$smarty.foreach.ul.iteration}" style="display:none" >
                            {$lang.appliesto}:
                            {if $plan.applicable_list.1}
                                <div class="appliesto_full">
                                    {foreach from=$plan.applicable_list item=item name=commisionit}
                                        <span class="badge badge-success">{$item.cat}: {$item.name}</span>
                                    {/foreach}
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>
            {/foreach}
            <div class="form-actions">
                <span class="text-center"><input type="submit" value="{$lang.continue}" class="btn btn-primary"></span>
            </div>
        </form>
        {literal}
        <script>
            function toggle_items(it) {
                $('.items_list').hide();
                $('.items_' + it).fadeIn();
            }
        </script>
        {/literal}
    {else}
        <p>{$lang.newpromocode}</p>
        <form action="" method="POST">
            <table width="100%" border=0 class="table table-striped p-td" cellspacing="0">
                <tr>
                    <td width="160" align="right">{$lang.vouchercode}</td>
                    <td>
                        <div class="d-flex flex-row align-items-center">
                            <input type="text" pattern="[A-Z0-9]+" oninput="this.value = this.value.toUpperCase()" class="form-control w-auto vouchercode mr-2" readonly="readonly" name="code" value="{$plan.code}"/>
                            <a href="#" onclick="$('.vouchercode').prop('readonly', false);$(this).remove();return false;">{$lang.edit}</a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="160" align="right">{$lang.disctype}</td>
                    <td>
                        <select name="cycle">
                            <option value="once">{$lang.applyonce}</option>
                            <option {if !$plan.recurring}disabled="disabled"{else}value="recurring"{/if} >{$lang.Recurring}</option>
                        </select>
                    </td>
                </tr>
                {if 'config:AffVAudience:1'|checkcondition}
                    <tr>
                        <td width="160" align="right">{$lang.appliesto}</td>
                        <td>
                            <select name="audience">
                                <option value="new" >{$lang.newcustommers}</option>
                                <option value="all" >{$lang.allcustommers}</option>
                                <option value="existing" >{$lang.existingcustommers}</option>
                            </select>
                        </td>
                    </tr>
                {/if}
                <tr>
                    <td width="160" align="right">{$lang.maxusage}</td>
                    <td>
                        <input type="checkbox" name="max_usage_limit" onclick="check_i(this)" style="vertical-align: middle; margin:9px 8px 0 0; float:left" />
                        <input type="text" size="4" name="max_usage" class="styled config_val" disabled="disabled"/>
                    </td>
                </tr>
                <tr>
                    <td width="160" align="right">{$lang.expdate}</td>
                    <td>
                        <input type="checkbox" onclick="check_i(this)" style="vertical-align: middle; margin:9px 8px 0 0; float:left" />
                        <input id="dpick" data-date="" data-date-format="{$js_date}" name="expires" class="styled config_val" type="text" value="" disabled="disabled" autocomplete="off">
                    </td>
                </tr>
                <tr>
                    <td align="right">{$lang.Commission}<a class="vtip_description" title="{$lang.commissionpart}"></a></td>
                    <td>
                        <input name="discount"  value="0" type="text" style="display:none" id="sfield"  variable="a" />
                        <div id="slider_margin_indicator" class="left" style="font-weight:bold; padding-left: 5px; min-width: 30px">
                            {if $plan.type!='Percent'}{$affiliate.currency.sign}
                            {/if}
                            {$plan.max_margin}
                            {if $plan.type=='Percent'}%
                            {/if}
                        </div>
                        <div id="slider" class="slides my-4" style="clear:none; width:370px;">
                            <div class="sl"></div>
                            <div class="sr"></div>
                        </div>
                        <div class="clearfix"></div>
                        <span id="slider_value_indicator">
                            {if $plan.type!='Percent'}{$affiliate.currency.sign}
                            {/if}
                            1
                            {if $plan.type=='Percent'}%
                            {/if}
                        </span>
                        <span title="{$lang.discountpart}">{$lang.discount}</span>
                    </td>
                </tr>
            </table>
            <div class="form-actions">
                <span class="text-center">
                    <input type="submit" value="{$lang.addvoucher}" name="save" class="btn btn-primary">
                </span>
            </div>
            {securitytoken}
        </form>
        <script type="text/javascript" src="{$template_dir}dist/js/bootstrap-datepicker.js"></script>
        <script type="text/javascript">
            var fx = {literal}{{/literal}{if $plan.type == 'Percent'}s:'%', p:''{else}s:'', p:'{$affiliate.currency.sign}'{/if}{literal}}{/literal}
            var maxval = parseInt('{$plan.rate}') - 2;
            var minval = 0;
            var stepval = 1;
            var initialval = 0;
            var _date_format = '{$js_date}';
            $('#dpick').datepicker();
        </script>
    {/if}
</section>