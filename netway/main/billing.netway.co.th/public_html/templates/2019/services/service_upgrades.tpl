{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/service_upgrades.tpl.php');
{/php}

{if $showupgrades}
    <div class="card upgrade-service">
        <div class="card-header">{$lang.UpgradeDowngrade}</div>
        <div id="cartSummary" class="wbox_content" style="padding:15px">
            {if $fieldupgrades}
                <form action="" method="post" id="form-upgr">
                    <input type="hidden" value="upgradeconfig" name="make"/>
                    <input type="hidden" value="upgradeconfig" name="do"/>

                    <input type="hidden" name="service_id" value="{$service.id}"/>
                    <input type="hidden" name="product_id" value="{$service.product_id}"/>
                    <input type="hidden" name="forcycle" value="{$service.billingcycle}"/>

                    <div class="table-responsive upgrade-grid">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" class="table">
                            <tr class="field-upgrade-row field-header">
                                <td class="upgrade-name" width="10%"></td>
                                <td class="upgrade-from" width="30%" >{$lang.oldsetting}</td>
                                <td class="upgrade-to" colspan="2" width="60%">{$lang.newsetting}</td>
                                <td class="upgrade-price" align="right">
                                    <span class="text-right w-100">{$lang.price}</span>
                                </td>
                            </tr>
                            {foreach from=$fieldupgrades item=cf key=k}

                                {include file="overrides/upgrade_forms/`$cf.type`.tpl"}

                            {/foreach}

                            {if $subproducts}
                                <tr class="field-upgrade-row">
                                    <td colspan="5"><strong>{$lang.ordersubproduct}</strong></td>
                                </tr>
                                {foreach from=$subproducts item=subp key=k}
                                    <tr class="field-upgrade-row">
                                        <td class="upgrade-name" colspan="2">{$subp.category_name} - {$subp.name}</td>
                                        <td class="upgrade-to" colspan="3"><a href="?cmd=cart&action=add&id={$subp.id}&parent_account={$service.id}">{$lang.clickheretoorder}</a></td>
                                    </tr>
                                {/foreach}
                            {/if}

                            <tr class="field-upgrade-row">
                                <td class="upgrade-to text-right" colspan="4">
                                    <strong>{$lang.total_recurring}</strong>
                                </td>
                                <td class="upgrade-price">
                                    <span class="total-recurring text-right w-100">{$price.new.total|price:$currency:1:1}</span>
                                </td>
                            </tr>
                            <tr class="field-upgrade-row">
                                <td class="upgrade-to text-right" colspan="4">
                                    <strong>
                                        {if $service.billingtype == 'PostPay'}
                                            {$lang.total_postpay}
                                        {else}
                                            {$lang.total_today}
                                        {/if}
                                    </strong>
                                </td>
                                <td class="upgrade-price">
                                    <span class="total-charge text-right w-100">{$price.charge|price:$currency:1:1}</span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="right" style="border-bottom:none;">
                                    <input type="submit" value="{$lang.continue}" style="font-weight:bold;" class="btn btn-info"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    {foreach from=$fieldupgrades item=cf key=k}
                        <input type="hidden" name="fupgrade[{$k}][old_qty]" value="{$cf.qty}"/>
                        {foreach from=$cf.data item=it key=kk}
                            <input type="hidden" name="fupgrade[{$k}][old_config_id]" value="{$kk}"/>
                        {/foreach}
                    {/foreach}
                    {securitytoken}
                </form>
            {literal}
                <script type="text/javascript">
                    $(function () {
                        var currency = {/literal}{$currency|@json_encode}{literal};
                        var form = $('#form-upgr');

                        function formatMoney(amount) {
                            var output = '';
                            if (currency.sign)
                                output += currency.sign;
                            //amount *= currency.rate;
                            output += number_format(amount, currency.decimal, currency.format.substr(-3, 1), currency.format.substr(1, 1));
                            if (currency.code)
                                output += ' ' + currency.code;
                            return output;
                        }

                        function number_format(num, decimals, dec_point, thousands_sep) {
                            if (dec_point === void 0) {
                                dec_point = '.';
                            }
                            if (thousands_sep === void 0) {
                                thousands_sep = ',';
                            }
                            num = (num + '').replace(/[^0-9+\-Ee.]/g, '');
                            var n = !isFinite(+num) ? 0 : +num, prec = !isFinite(+decimals) ? 0 : Math.abs(decimals), s = [],
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

                        function fetch_form(params){
                            var data = $('form').serializeArray();
                            params = params || {};

                            $.each(data, function (key, param) {
                                if(params.hasOwnProperty(param.name)){
                                    param.value = params[param.name];
                                    delete params[param.name];
                                }
                            })
                            $.each(params, function (key, value) {
                                data.push({name: key, value: value});
                            })

                            return data;
                        }


                        form.on('change', 'input, select, textarea', function () {
                            form.css({
                                opacity: 0.8
                            });

                            $.post(window.location.href, fetch_form({make: 'estimate'}), function (data) {
                                form.css({
                                    opacity: 1
                                });
                                var price_list = {};l
                                for (var i = 0, l = data.config.length; i < l; i++) {
                                    var conf = data.config[i],
                                        total =  parseFloat(conf.total) || 0;
                                    if(price_list.hasOwnProperty(conf.category_id)){
                                        price_list[conf.category_id] += total;
                                    } else{
                                        price_list[conf.category_id] = total;
                                    }
                                    $('.custom_field_' + conf.category_id + '_price')
                                        .text(formatMoney(price_list[conf.category_id]))
                                }

                                $('.total-recurring', form).text(formatMoney(data.new.total))
                                $('.total-charge', form).text(formatMoney(data.charge))
                            })
                        });

                        $('input, select, textarea', form).eq(0).trigger('change');
                    })
                </script>
            {/literal}
            {elseif $upgrades && $upgrades!=-1}
                <form action="" method="post">
                    <input type="hidden" value="upgrade" name="make"/>
                    <input type="hidden" value="upgrade" name="do"/>
                    <div class="d-flex flex-lg-row flex-column align-items-lg-end flex-wrap">
                        <div class="m-2">
                            {$lang.updownto}
                            <select name="upgrades" onchange="sss(this)">
                                {foreach from=$upgrades item=up}
                                    <option value="{$up.id}">{$up.catname}: {$up.name}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div id="billing_options" class="m-2">
                            {foreach from=$upgrades item=i key=k}
                                <div {if $k!=0}style="display:none"{/if} class="up_desc">
                                    {if $i.paytype=='Free'}
                                        <input type="hidden" name="cycle[{$i.id}]" value="Free"/>
                                        {$lang.price}:
                                        <strong> {$lang.Free}</strong>
                                    {elseif $i.paytype=='Once'}
                                        <input type="hidden" name="cycle[{$i.id}]" value="Once"/>
                                        {$lang.price}: {$i.m|price:$currency:true:true} {$lang.once}
                                    {else}
                                        {$lang.pickcycle}
                                        <select name="cycle[{$i.id}]">
                                            {if $i.h!=0}
                                                <option value="h" {if $i.cycle=='h'}selected="selected"{/if}>{$i.h|price:$currency:true:true} {$lang.h}</option>{/if}
                                            {if $i.d!=0}
                                                <option value="d" {if $i.cycle=='d'}selected="selected"{/if}>{$i.d|price:$currency:true:true} {$lang.d}</option>{/if}
                                            {if $i.w!=0}
                                                <option value="w" {if $i.cycle=='w'}selected="selected"{/if}>{$i.w|price:$currency:true:true} {$lang.w}</option>{/if}
                                            {if $i.m!=0}
                                                <option value="m" {if $i.cycle=='m'}selected="selected"{/if}>{$i.m|price:$currency:true:true} {$lang.m}</option>{/if}
                                            {if $i.q!=0}
                                                <option value="q" {if $i.cycle=='q'}selected="selected"{/if}>{$i.q|price:$currency:true:true} {$lang.q}</option>{/if}
                                            {if $i.s!=0}
                                                <option value="s" {if $i.cycle=='s'}selected="selected"{/if}>{$i.s|price:$currency:true:true} {$lang.s}</option>{/if}
                                            {if $i.a!=0}
                                                <option value="a" {if $i.cycle=='a'}selected="selected"{/if}>{$i.a|price:$currency:true:true} {$lang.a}</option>{/if}
                                            {if $i.b!=0}
                                                <option value="b" {if $i.cycle=='b'}selected="selected"{/if}>{$i.b|price:$currency:true:true} {$lang.b}</option>{/if}
                                            {if $i.t!=0}
                                                <option value="t" {if $i.cycle=='t'}selected="selected"{/if}>{$i.t|price:$currency:true:true} {$lang.t}</option>{/if}
                                        </select>
                                    {/if}
                                </div>
                            {/foreach}
                        </div>
                        <div class="m-2">
                            <input type="submit" value="{$lang.continue}" style="font-weight:bold;" class="btn btn-info"/>
                        </div>
                    </div>
                    <hr>
                    <div class="fs11" id="up_descriptions" style="margin-top:10px">
                        {foreach from=$upgrades item=up key=k}
                            <span {if $k!=0}style="display:none"{/if} class="up_desc">{$up.description}</span>
                        {/foreach}
                    </div>
                    <script type="text/javascript">
                        {literal}
                        function sss(el) {
                            $('.up_desc').hide();
                            var index = $(el).eq(0).prop('selectedIndex');
                            $('#up_descriptions .up_desc').eq(index).show();
                            $('#billing_options .up_desc').eq(index).show();
                        }
                        {/literal}
                    </script>
                    {securitytoken}
                </form>
            {/if}
        </div>
    </div>
    {if $subproducts}
        <div class="card">
            <div class="card-header">{$lang.ordersubproduct}</div>
            <div class="card-body">
                <table class="table">
                    {foreach from=$subproducts item=subp}
                        <tr>
                            <td>{$subp.category_name} - {$subp.name}</td>
                            <td>
                                <a href="?cmd=cart&action=add&id={$subp.id}&parent_account={$service.id}">{$lang.clickheretoorder}</a>
                            </td>
                        </tr>
                    {/foreach}
                </table>
            </div>
        </div>
    {/if}
{/if}
