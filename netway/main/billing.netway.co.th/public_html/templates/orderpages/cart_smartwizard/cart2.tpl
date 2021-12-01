
{include file="cart_smartwizard/header.tpl"}
{include file="cart_smartwizard/cart.summary.tpl"}

<!-- Left Column -->
<div class="left-column left">
    <div class="cart-container-sw">
        <form action="" method="post" id="cart3">
            <input type="hidden" name="make" value="domainconfig" />
            <div id="t-settings">
                <div class="option-row center">
                    <div class="option-box left">
                        <h4 class="openSansBold left">{$lang.mydomains}</h4>
                    </div>

                    <div class="domain-box clear" style="display:block">
                        <div class="domain-option">
                            <p class="openSansBold">{$lang.productconfig2}:</p>
                            <table style="width:96%;margin-left:9px;" class="form-horizontal">
                                {foreach from=$domain item=doms key=kk name=domainsloop}
                                    <tr class="domain-row domain-row-{$kk}">
                                        <td class="openSansSemiBold">
                                            {$doms.name}
                                            <input type="hidden" value="{$kk}" name="domkey[]" />
                                            <a href="#" class="openSansSemiBold" onclick="return remove_domain('{$kk}', '{$lang.itemremoveconfirm}')" >[{$lang.delete}]</a>
                                        </td>
                                        <td class="openSansSemiBold" style="text-align: right">
                                            <select name="period[{$kk}]" id="domain-period-{$kk}" class="dom-period" onchange="if(typeof (simulateCart)=='function') simulateCart('#cart3')" >
                                                {foreach from=$doms.product.periods item=period key=p}
                                                    <option value="{$p}" {if $p==$doms.period}selected="selected"{/if}>{$p} {$lang.years}</option>
                                                {/foreach}
                                            </select>
                                        </td>

                                    </tr>
                                    {if !$renewalorder && $doms.custom}
                                        {foreach from=$doms.custom item=cf}
                                            {if $cf.items}
                                                <tr  class="domain-row-{$kk}  domain-row  {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                                                    <td colspan="3" class="configtd" >
                                                        <div class="cf-domain"><strong>{$cf.name} {if $cf.options & 1}*{/if}</strong></div>
                                                        {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>
                                                        {/if}
                                                        {include file=$cf.configtemplates.cart}
                                                    </td>
                                                </tr>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                    {if $doms.action=='transfer'}
                                        {if $doms.product.epp=='1'}
                                            <tr  class="domain-row-{$kk}  domain-row  {if $smarty.foreach.domainsloop.index%2==0}even{/if}" >
                                                <td colspan="3"  style="border:none" class="configtd">
                                                    <label for="epp{$kk}" class="styled"> {$lang.eppcode}*</label>
                                                    <input name="epp[{$kk}]"  id="epp{$kk}" value="{$doms.epp}" class="styled" />
                                                </td>
                                            </tr>
                                        {else}
                                            <tr style="display:none;" >
                                                <td>
                                                    <input name="epp[{$kk}]" type="hidden" value="not-required" />
                                                </td>
                                            </tr>
                                        {/if}
                                    {/if}
                                {/foreach}
                            </table>
                        </div>
                        {if !$renewalorder}
                            <input type="hidden" name="usens" value="{if $usens=='1'}1{else}0{/if}" id="usens" />

                            <div class="domain-option" {if $usens && $product && !$periods}style="display:none"{/if}>
                                <p class="openSansBold" >{$lang.edit_config}</p>
                                <p>
                                    <span class="question-mark vtip_description" title="{$lang.cart2_desc3} " ></span>
                                    <span class="edit-domain openSansSemiBold">{$lang.cart2_desc4}</span>
                                    <a href="#" class="edit-nameservers openSansBold right" {if $usens=='1'}style="display:none"{/if} onclick="$(this).hide().next().show();$('#usens').val(1);$('#nameservers').slideDown();return false">{$lang.iwantminens}</a>
                                    <a href="#" class="edit-nameservers openSansBold right" {if !$usens}style="display:none"{/if} onclick="$(this).hide().prev().show();$('#nameservers').slideUp();$('#setnservers').show();$('#usens').val(0);return false">{$lang.useourdefaultns}</a>
                                </p>
                                {if $periods}
                                    <p>
                                        <span class="question-mark vtip_description" title="{$lang.cart2_desc2} " ></span>
                                        <span class="edit-domain openSansSemiBold">{$lang.cart2_desc5}</span>
                                        <select onchange="bulk_periods(this)" class="right">
                                            {foreach from=$periods item=period key=p}
                                                <option value="{$p}">{$p} {$lang.years}</option>
                                            {/foreach}
                                        </select>

                                    </p>
                                {/if}
                                {if !$product}
                                    <p>
                                        <span class="question-mark vtip_description" title="{$lang.cart2_desc1}" ></span>
                                        <span class="edit-domain openSansSemiBold">{$lang.nohosting}</span>
                                        <a class="edit-nameservers openSansBold right" href="{$ca_url}cart&step=0&addhosting=1">{$lang.clickhere1}</a>
                                    </p>
                                {/if}
                            </div>
                            <div id="nameservers" class="domain-option" {if !$usens}style="display:none"{/if}>
                                <p class="openSansBold" >{$lang.nameservers}</p>
                                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="styled" style="margin-left:8px;">
                                    <colgroup class="firstcol"></colgroup>
                                    <colgroup class="alternatecol"></colgroup>
                                    <tr><td width="20%" class="openSansSemiBold">{$lang.nameserver} 1</td><td><input name="ns1" style="width:60%" value="{$domain[0].ns1}" class="styled"/></td></tr>
                                    {if $domain[0].nsips}<tr><td width="20%" class="openSansSemiBold">{$lang.nameserver} IP 1</td><td><input name="nsip1" style="width:60%" value="{$domain[0].nsip1}" class="styled"/></td></tr>
                                            {/if}
                                    <tr><td class="openSansSemiBold">{$lang.nameserver} 2</td><td> <input name="ns2" style="width:60%" value="{$domain[0].ns2}"  class="styled"/></td></tr>
                                    {if $domain[0].nsips}<tr><td width="20%" class="openSansSemiBold">{$lang.nameserver} IP 2</td><td><input name="nsip2" style="width:60%" value="{$domain[0].nsip2}" class="styled"/></td></tr>
                                            {/if}
                                    <tr><td class="openSansSemiBold">{$lang.nameserver} 3</td><td><input name="ns3" style="width:60%" value="{$domain[0].ns3}"  class="styled"/></td></tr>
                                    {if $domain[0].nsips}<tr><td width="20%" class="openSansSemiBold">{$lang.nameserver} IP 3</td><td><input name="nsip3" style="width:60%" value="{$domain[0].nsip3}" class="styled"/></td></tr>
                                            {/if}
                                    <tr><td class="openSansSemiBold">{$lang.nameserver} 4</td><td><input name="ns4" style="width:60%" value="{$domain[0].ns4}" class="styled" /></td></tr>
                                    {if $domain[0].nsips}<tr><td width="20%" class="openSansSemiBold">{$lang.nameserver} IP 4</td><td><input name="nsip4" style="width:60%" value="{$domain[0].nsip4}" class="styled"/></td></tr>
                                            {/if}
                                </table>
                            </div>
                            <div class="domain-option">
                                <p class="openSansBold">{$lang.domcontacts}</p>
                                <div class="contacts">
                                    {include file="common/contacts.tpl"}
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </form>
        <!-- end -->
    </div>

    <div class="pagination-box">
        {include file='cart_smartwizard/pagination.tpl'}

        <div class="pagination-right-button right" onclick="$('#cart3').submit(); return false;">
            <span class="pag-arrow"></span>
            <span class="openSansBold" >{$lang.next}</span>
        </div>
    </div>

</div>

<div class="clear"></div>