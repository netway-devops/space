{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'orders/ajax.add.tpl.php');
{/php}

{if $make=='getservice' || $make=='editservice'}
    {counter name=alter print=false start=1 assign=alter }
    {if $deleted.service || $deleted.domain}
        <tr style="display:none">
            <td colspan="12">
                {foreach from=$deleted.service item=key}
                    <input class="inp" type="hidden" name="service[{$key}][remove]" value="{$key}" />
                {/foreach}
                {foreach from=$deleted.domain item=key}
                    <input class="inp" type="hidden" name="domain[{$key}][remove]" value="{$key}" />
                {/foreach}
            </td>
        </tr>
    {/if}
    {if $draft.domains}
        <!-- DOMAINS -->
        {foreach from=$draft.domains item=domain key=did}
            <tr  class="havecontrols domain_{$did} {counter name=alter}{if $alter%2==0}even{/if}">
                <td>
                    <input class="inp" type="checkbox" name="domain[{$did}][product]" checked="checked" value="{$domain.product.id}" />
                    <input type="hidden" class="fold" name="domain[{$did}][fold]" value="{$fold.domain.$did}" />
                </td>
                <td >
                    <strong>Domain</strong>
                </td>
                <td>
                    <strong>{$lang[$domain.action]}: </strong>
                    {$domain.name}
                    <input class="inp" type="hidden" name="domain[{$did}][name]" value="{$domain.sld}" />
                    {if !$domain.org_price && $domain.action=='Transfer' ||  $domain.customizations}
                        <a href="#" class="right editbtn" {if !$fold.domain.$did}style="display:none"{/if} onclick="order.fold(this);$(this).hide().next().show(); return false;" rel="domain_{$did}" >{$lang.showdetails}</a>
                        <a href="#" class="right editbtn" {if $fold.domain.$did}style="display:none"{/if} onclick="order.fold(this);$(this).hide().prev().show(); return false;" rel="domain_{$did}" >{$lang.Hide}</a>
                    {/if}
                </td>
                <td>
                    {if $domain.product.periods}
                        <select class="inp" name="domain[{$did}][action]">
                            <option {if $domain.action=='Register'} selected="selected"{/if} value="Register">Register</option>
                            <option {if $domain.action=='Transfer'} selected="selected"{/if} value="Transfer">Transfer</option>
                        </select>
                        <select class="inp" name="domain[{$did}][period]">
                            {foreach from=$domain.product.periods item=tld}
                                <option {if $domain.action!='Register'}style="display:none"{/if}
                                        class="register_p" value="{$tld.period}"
                                        {if $tld.period == $domain.period && $domain.action=='Register'}selected="selected" {/if}>
                                    {$tld.period}{if $tld.period == 1} {$lang.Year}{else} {$lang.Years}{/if}
                                    {if $admindata.access.viewOrdersPrices}- {$tld.register|price:$draft.currency}{/if}
                                </option>
                                <option {if $domain.action!='Transfer'}style="display:none"{/if}
                                        class="transfer_p" value="{$tld.period}"
                                        {if $tld.period == $domain.period && $domain.action=='Transfer'}selected="selected" {/if}>
                                    {$tld.period}{if $tld.period == 1} {$lang.Year}{else} {$lang.Years}{/if}
                                    {if $admindata.access.viewOrdersPrices}- {$tld.transfer|price:$draft.currency}{/if}
                                </option>
                            {/foreach}
                        </select>

                    {/if}
                </td>
                <td>-</td>
                <td class="editbtn_flash">
                    <span {if !$domain.org_price && $fold.domain.$did}style="display:none"{/if} class="product_price foldable {if $domain.org_price}pricemod{/if}" {if $domain.org_price}title="This price was modified"{/if}>
                        {if $admindata.access.viewOrdersPrices}{$domain.price|price:$draft.currency}{else}-{/if}
                    </span>
                    {assign value=false var=pricemod}{assign value=false var=custompricemod}
                    {foreach from=$draft.dom_customizations[$did] item=cf key=cfk}
                        {foreach from=$cf item=ci key=cik}
                            {if "smarty:ci.customdata.billing.price"|checkcondition || $domain.customizations[$cfk].items[$cik].org_price}
                                {assign value=true var=custompricemod}
                            {/if}
                        {/foreach}
                    {/foreach}
                    {if $custompricemod || $domain.org_price }{assign value=true var=pricemod}{/if}
                    <span {if $domain.org_price || !$fold.domain.$did}style="display:none"{/if} class="total_price foldable {if $pricemod}pricemod{/if}" {if $pricemod}title="This price was modified"{/if}>
                        {if $admindata.access.viewOrdersPrices}{$domain.total.total|price:$draft.currency}{else}-{/if}
                    </span>
                    <input style="display:none; width: 98px"  class="custom_product_price" type="text"
                           name="domain[{$did}][billing][price]" value="{if $domain.org_price}{$domain.price}{/if}"
                           placeholder="{if $admindata.access.viewOrdersPrices}{if $domain.org_price}{$domain.org_price|price:$draft.currency}{else}{$domain.price|price:$draft.currency}{/if}{/if}" />
                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                </td>
                <td>-</td>
            </tr>
            {if $domain.action == 'Transfer'}
                <tr style="{if !$domain.org_price && $fold.domain.$did}display:none{/if}" class="foldable havecontrols domain_{$did} {if $alter%2==0}even{/if}">
                    <td></td>
                    <td>{$lang.Configuration}</td>
                    <td>{$lang.Eppcode}</td>
                    <td><input class="inp" type="text" value="{$domain.epp_code|escape}" name="domain[{$did}][eppcode]"/></td>
                    <td></td>
                    <td>-</td>
                </tr>
            {/if}
            {if $domain.customizations}
                {foreach from=$domain.customizations item=c key=kk}
                    {if $c.items}
                        <tr style="vertical-align: top; {if !$domain.org_price && $fold.domain.$did}display:none{/if}" class="foldable havecontrols domain_{$did} {if $alter%2==0}even{/if}">
                            <td></td>
                            <td>Custom field</td>
                            <td>{$c.name} </td>
                            <td class="domain_{$did}_custom_{$kk}">
                                {include file=$c.configtemplates.accounts currency=$draft.currency }
                                <script type="text/javascript">var did = '{$did}'; $('.domain_{$did}_custom_{$kk}').find('input, select').addClass('inp').filter('[name]').each({literal}function(){$(this).attr('name','domain['+did+']'+$(this).attr('name').replace(/^([a-z_]*)/,"[$1]"))}{/literal})</script>
                            </td>
                            <td class="editbtn_flash">
                                {foreach from=$draft.dom_customizations[$did][$c.id] item=ci key=cfk}
                                    <span {if $c.items[$cfk].org_price}class="pricemod" title="This price was modified"{/if}>{if $admindata.access.viewOrdersPrices}{$c.price|price:$draft.currency}{/if}</span>
                                    <input style="display:none; width: 98px"  class="custom_product_price" type="text"
                                           name="domain[{$did}][custom_cdata][{$c.id}][{$cfk}][billing][price]" value="{if $c.items[$cfk].org_price}{$c.items[$cfk].price}{/if}"
                                           placeholder="{if $admindata.access.viewOrdersPrices}{if $c.items[$cfk].org_price}{$c.items[$cfk].org_price|price:$draft.currency}{else}{$c.items[$cfk].price|price:$draft.currency}{/if}{/if}" />
                                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                                {/foreach}
                            </td>
                            <td></td>
                        </tr>
                    {/if}
                {/foreach}
            {/if}
        {/foreach}
    {/if}
    {if $draft.services}
        <!-- SERVICES -->
        {foreach from=$draft.services item=service key=sid}
            <tr class="havecontrols service_{$sid} {counter name=alter}{if $alter%2==0}even{/if}" >
                <td>
                    <input class="inp" type="checkbox" name="service[{$sid}][product]" checked="checked" value="{$service.product.id}" />
                    <input class="fold" type="hidden" name="service[{$sid}][fold]" value="{$fold.service.$sid}" />
                </td>
                <td><strong>{$service.category.name}</strong></td>
                <td>
                    {if $service.account_id}
                        <a href="?cmd=accounts&action=edit&id={$service.account_id}" target="_blank">
                            <strong>{$service.product.name}</strong> - Account #{$service.account_id}
                        </a>
                    {else}
                        <strong>{$service.product.name}</strong>
                        <span class="editbtn_flash">
                            {if $service.domain}: {$service.domain}
                                <a href="#" class="editbtn" {if !$fold.service.$sid}style="display:none"{/if} onclick="$(this).parent().hide().next().show();return false;">{$lang.Change}</a>
                            {else}
                                <a href="#" class="editbtn" {if !$fold.service.$sid}style="display:none"{/if} onclick="$(this).parent().hide().next().show();return false;">{$lang.Change} {$lang.Hostname}</a>
                            {/if}
                        </span>
                        {if $service.product.hostname || $service.product.owndomain || $service.product.domain_options}
                            <span style="display:none">:
                                {if $draft.domains}
                                    <select class="inp" name="service[{$sid}][domain]" onchange="if($(this).val() === '0') $(this).hide().next().show(); else if($(this).val().length) order.get_service($(this).parents('form')[0])" class="noevent">
                                        <option value="">------</option>
                                        {foreach from=$draft.domains item=domain}
                                            <option {if $domain.name == $service.domain}selected="selected"{assign value=true var=seleteddom}{/if}>{$domain.name}</option>
                                        {/foreach}
                                        {if $service.domain && !$seleteddom} <option selected="selected">{$service.domain}</option>
                                        {/if}
                                        <option value="0">Use other domain</option>
                                    </select>
                                {/if}
                                <input class="inp" {if $draft.domains}style="display:none"{/if} name="service[{$sid}][host]" value="{$service.domain|escape}"  />
                            </span>
                        {/if}
                    {/if}
                    {if ($service.addons ||  $service.customizations)}
                        <a href="#" id="showdetails{$sid}" style="{if !$fold.service.$sid}display:none{/if}" class="right editbtn" onclick="order.fold(this);$(this).hide().next().show(); return false;" rel="service_{$sid}" >{$lang.showdetails}</a>
                        <a href="#" class="right editbtn" style="{if $fold.service.$sid}display:none{/if}" onclick="order.fold(this);$(this).hide().prev().show(); return false;" rel="service_{$sid}" >{$lang.Hide}</a>
                    {/if}
                </td>
                <td>
                    {include file='_common/billing_select.tpl' product=$service.product format=$draft.currency cycle=$service.cycle name="service[`$sid`][cycle]" }
                </td>
                <td class="editbtn_flash">
                    <span {if $fold.service.$sid}style="display:none"{/if} class="product_price foldable {if $service.org_setup}pricemod{/if}">
                         {if $admindata.access.viewOrdersPrices}{$service.setup|price:$draft.currency}{else}-{/if}
                    </span>
                    <span {if !$fold.service.$sid}style="display:none"{/if} class="product_price foldable {if $service.org_setup}pricemod{/if}" {if $service.org_setup}title="This price was modified"{/if}>
                        {if $admindata.access.viewOrdersPrices}{$service.total.setup|price:$draft.currency}{else}-{/if}
                    </span>
                    <input style="display:none; width: 98px" class="custom_product_price" type="text"
                           name="service[{$sid}][billing][setup]" value="{if $service.setup}{$service.setup}{/if}"
                           placeholder="{if $admindata.access.viewOrdersPrices}{$service.setup|price:$draft.currency}{/if}" />
                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                </td>
                <td class="editbtn_flash">
                    {if $admindata.access.viewOrdersPrices}
                        <span {if !$service.org_price && $fold.service.$sid}style="display:none"{/if} class="product_price foldable {if $service.org_price}pricemod{/if}" {if $service.org_price}title="This price was modified"{/if}>
                            {$service.price|price:$draft.currency}
                        </span>
                    {/if}
                    {assign value=false var=pricemod}{assign value=false var=addonpricemod}{assign value=false var=custompricemod}
                    {foreach from=$draft.customizations[$sid] item=cf key=cfk}
                        {foreach from=$cf item=ci key=cik}
                            {if "smarty:ci.customdata.billing.price"|checkcondition || $service.customizations[$cfk].items[$cik].org_price}
                                {assign value=true var=custompricemod}
                            {/if}
                        {/foreach}
                    {/foreach}
                    {foreach from=$service.addons item=addon}
                        {if $addon.org_price}
                            {assign value=true var=addonpricemod}
                        {/if}
                    {/foreach}
                    {if $custompricemod || $addonpricemod || $service.org_price}{assign value=true var=pricemod}{/if}
                    <span {if $service.org_price || !$fold.service.$sid}style="display:none"{/if} class="total_price foldable {if $pricemod}pricemod{/if}" {if $pricemod}title="This price was modified"{/if}>
                        {if $admindata.access.viewOrdersPrices}{$service.total.total|price:$draft.currency}{else}-{/if}
                    </span>
                    <input style="display:none; width: 98px"  class="custom_product_price" type="text"
                           name="service[{$sid}][billing][price]" value="{if $service.org_price}{$service.price}{/if}"
                           placeholder="{if $admindata.access.viewOrdersPrices}{if $service.org_price}{$service.org_price|price:$draft.currency}{else}{$service.price|price:$draft.currency}{/if}{/if}" />
                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                </td>
                <td align="center">{if $service.qty}{$service.qty}{else}1{/if}<input type="hidden" name="service[{$sid}][qty]" value="{if $service.qty}{$service.qty}{else}1{/if}"/></td>
            </tr>
            {if $service.addons}
                {foreach from=$service.addons item=addon}
                    <tr {if !$service.org_price && $fold.service.$sid}style="display:none"{/if} class="foldable havecontrols service_{$sid} {if $alter%2==0}even{/if}">
                        <td></td>
                        <td>{$lang.accountaddon}</td>
                        <td>{$addon.name}</td>
                        <td>
                            <input class="inp" type="text" onkeypress="if(event.charCode != 0 && (event.charCode < 48 || event.charCode > 57)) return false;" size="2" value="{$addon.qty}" name="service[{$sid}][addons][{$addon.id}][qty]"/> x
                            {include file='_common/billing_select.tpl' product=$addon format=$draft.currency cycle=$addon.recurring name="service[`$sid`][addons][`$addon.id`][cycle]" }
                        </td>
                        <td class="editbtn_flash">
                            <span {if $addon.org_setup}class="pricemod" title="This price was modified"{/if}>{if $admindata.access.viewOrdersPrices && $addon.qty > 0}{$addon.setup|price:$draft.currency}{/if}</span>
                            <input style="display:none; width: 98px"  class="custom_product_price" type="text"
                                   name="service[{$sid}][addons][{$addon.id}][billing][setup]" value="{if $addon.org_setup}{$addon.setup}{/if}"
                                   placeholder="{if $admindata.access.viewOrdersPrices}{if $addon.org_setup}{$addon.org_setup|price:$draft.currency}{else}{$addon.setup|price:$draft.currency}{/if}{/if}" />
                            <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                        </td>
                        <td class="editbtn_flash">
                            <span {if $addon.org_price}class="pricemod" title="This price was modified"{/if}>{if $admindata.access.viewOrdersPrices && $addon.qty > 0}{$addon.price|price:$draft.currency}{/if}</span>
                            <input style="display:none; width: 98px"  class="custom_product_price" type="text"
                                   name="service[{$sid}][addons][{$addon.id}][billing][price]" value="{if $addon.org_price}{$addon.price}{/if}"
                                   placeholder="{if $admindata.access.viewOrdersPrices}{if $addon.org_price}{$addon.org_price|price:$draft.currency}{else}{$addon.price|price:$draft.currency}{/if}{/if}" />
                            <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                        </td>
                        <td></td>
                    </tr>
                {/foreach}
            {/if}
            {if $service.customizations}
                {foreach from=$service.customizations item=c key=kk}
                    {*{debug output='hb' var='c'}*}
                    {if $c.items}
                        <tr style="vertical-align: top; {if !$service.org_price && $fold.service.$sid}display:none{/if}" class="foldable havecontrols service_{$sid} {if $alter%2==0}even{/if}">
                            <td></td>
                            <td>Custom field</td>
                            <td>{$c.name} </td>
                            <td class="service_{$sid}_custom_{$kk}">
                                {include file=$c.configtemplates.accounts currency=$draft.currency  cf_opt_name="service[`$sid`][custom]"}
                                <script type="text/javascript">var sid = '{$sid}'; $('.service_{$sid}_custom_{$kk}').find('input, select, textarea').addClass('inp').filter('[name]').each({literal}function(){if ($(this).attr('name').indexOf('service') > -1){return false;}$(this).attr('name','service['+sid+']'+$(this).attr('name').replace(/custom/,'[custom]'))}{/literal})</script>
                            </td>
                            <td>
                                {foreach from=$draft.customizations[$sid][$c.id] item=ci key=cfk}
                                {assign value=$draft.customizations[$sid][$c.id][$cfk] var=draftcustomization}

                                <div class="editbtn_flash">
                                    <span {if $c.items[$cfk].org_setup}class="pricemod" title="This price was modified"{/if}>
                                    {if $admindata.access.viewOrdersPrices}{$c.items[$cfk].setup|price:$draft.currency}{/if}
                                </span>
                                    <input style="display:none; width: 98px"  class="custom_product_price" type="text"
                                           name="service[{$sid}][custom_cdata][{$c.id}][{$cfk}][billing][setup]" value="{if $draftcustomization.customdata.billing.setup}{$draftcustomization.customdata.billing.setup}{/if}"
                                           placeholder="{if $admindata.access.viewOrdersPrices}{if $c.items[$cfk].org_setup}{$c.items[$cfk].org_setup|price:$draft.currency}{else}{$c.items[$cfk].setup|price:$draft.currency}{/if}{/if}" />
                                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                                </div>
                                {/foreach}
                            </td>
                            <td>
                                {foreach from=$draft.customizations[$sid][$c.id] item=ci key=cfk}
                                {assign value=$draft.customizations[$sid][$c.id][$cfk] var=draftcustomization}

                                <div class="editbtn_flash">
                                    <span {if $c.items[$cfk].org_price}class="pricemod" title="This price was modified"{/if}>
                                    {if $admindata.access.viewOrdersPrices}{$c.items[$cfk].price|price:$draft.currency}{/if}
                                    </span>
                                    <input style="display:none; width: 98px"  class="custom_product_price" type="text"
                                           name="service[{$sid}][custom_cdata][{$c.id}][{$cfk}][billing][price]" value="{if $draftcustomization.customdata.billing.price}{$draftcustomization.customdata.billing.price}{/if}"
                                           placeholder="{if $admindata.access.viewOrdersPrices}{if $c.items[$cfk].org_price}{$c.items[$cfk].org_price|price:$draft.currency}{else}{$c.items[$cfk].price|price:$draft.currency}{/if}{/if}" />
                                    <a href="#" class="editbtn" onclick="return order.edit_back(this);" >{$lang.Edit}</a>
                                </div>
                                {/foreach}
                            </td>
                            <td></td>
                        </tr>
                    {/if}
                {/foreach}
            {/if}
        {/foreach}
    {/if}

    {if !$draft.services && !$draft.domains}
        <tr class="even">
            <td style="text-align: center" colspan="15">{$lang.no_items}</td>
        </tr>
    {else}
        <tr {if $alter%2==0}class="even"{/if}>
            <td style="text-align: right" colspan="4"><b>{$lang.total}</b>:</td>
            <td>
                {if $admindata.access.viewOrdersPrices}{$draft.price.setup|price:$draft.currency}{else}-{/if}
            </td>
            <td>
                {if $admindata.access.viewOrdersPrices}{$draft.price.total-$draft.price.setup|price:$draft.currency}{else}-{/if}
            </td>
            <td></td>
        </tr>
        {if $draft.price.discount > 0}
            <tr {if $alter%2==0}class="even"{/if}>
                <td colspan="4"></td>
                <td colspan="3">
                    <div class="order_price right">
                        {if $admindata.access.viewOrdersPrices}-{$draft.price.discount|price:$draft.currency}{else}-{/if}
                    </div>
                    <div class="order_price_label right">{$lang.Discount}:</div>
                </td>
            </tr>
        {/if}
    {/if}
    {if $unsaved}
        <tr style="display:none">
            <td colspan="15"><input type="hidden" id="unsaved" value="1" /></td>
        </tr>
    {/if}
{elseif $make == 'listitems'}
    {if $services}
        <tr>
            <td>
                <strong>{$lang.prodslashservice}</strong>
            </td>
            <td>
                <select class="inp" name="product" id="product_id" onchange="order.get_product(this);" style="width:450px">
                    <option selected="selected" >-</option>
                    {foreach from=$services item=category}
                        {if $category.products}
                            <optgroup label="{$category.name}">
                                {foreach from=$category.products item=prod}
                                    <option value="{$prod.id}" {if $submit.product == $prod.id}selected="selected" {/if}>{$prod.name}</option>
                                {/foreach}
                            </optgroup>
                        {/if}
                    {/foreach}
                    <option value="new" style="font-weight: bold">{$lang.newservice}</option>
                </select>
                <a class="external" href="#" style="display:none;" target="_blank">Inspect product configuration</a>
                {literal}<script>
                    $('#product_id').chosenedge();
                </script>{/literal}
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="product_config" ></div>
            </td>
        </tr>
    {elseif $domains}
        <tr>
            <td>
                <strong>{$lang.Action}</strong>
            </td>
            <td>
                <label><input class="inp" {if !$submit.domain_action || $submit.action == "Register"}checked="checked"{/if} type="radio" name="domain_action" value="Register" onclick="$('#eppcode').parent().parent().hide();" /> {$lang.Register}</label>
                <label><input class="inp" {if $submit.domain_action == "Transfer"}checked="checked"{/if} type="radio" name="domain_action" value="Transfer" onclick="$('#eppcode').parent().parent().show();" /> {$lang.Transfer}</label>
            </td>
        </tr>
        <tr>
            <td>
                <strong>{$lang.domainname}</strong>
            </td>
            <td>
                <input class="inp" id="domain_sld" name="domain_sld" value="{$submit.domain_sld}" size="20" onchange="order.search_domain();" />
                <select class="inp" name="domain_tld" id="domain_tld" onchange="order.get_domain(this);">
                    <option selected="selected" >-</option>
                    {foreach from=$domains item=tlds}
                        {if $tlds.products}
                            <optgroup label="{$tlds.name}">
                                {foreach from=$tlds.products item=tld}
                                    <option value="{$tld.id}" >{$tld.name}</option>
                                {/foreach}
                            </optgroup>
                        {/if}
                    {/foreach}
                </select>
                <a class="external" href="#" style="display:none;" target="_blank">Inspect TLD configuration</a>
            </td>
        </tr>
        <tr style="display:none">
            <td>
                <strong>{$lang.Eppcode}</strong>
            </td>
            <td>
                <input class="inp" id="eppcode" size="30" value="" name="domain_eppcode">
            </td>
        </tr>
        <tr>
            <td>
                <a href="javascript:void(0);" onclick="order.check_availability()" style="menuitm">{$lang.checkavailability}</a>
            </td>
            <td id="avail_field">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="domain_config" ></div>
            </td>
        </tr>
    {else}
        <tr>
            <td></td>
            <td colspan="2">
                {$lang.nothingwasfound}
            </td>
        </tr>
    {/if}
{elseif $make == 'getclientservice'}
    {if $product}
        <div class="like-table-row">
            <div style="width: 160px">{$lang.prodslashservice}</strong></div>
            <div>
                <select class="inp" name="product" id="product_id" onchange="order.get_product(this);">
                    {foreach from=$upgrades item=category}
                        {if $category.products}
                            <optgroup label="{$category.name}">
                                {foreach from=$category.products item=prod}
                                    <option value="{$prod.id}" {if $submit.product == $prod.id}selected="selected" {/if}>{$prod.name}</option>
                                {/foreach}
                            </optgroup>
                        {/if}
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="product_config" >
            {include file="orders/ajax.add.tpl" make="getproduct"}
        </div>
    {/if}
{elseif $make == 'getproduct'}
    {if $product}
        <div class="like-table-row">
            <div style="width: 160px">{$lang.billingcycle}</div>
            <div>
                {include file='_common/billing_select.tpl' product=$product format=$draft.currency cycle=$submit.cycle atributes='onchange="order.get_product(this);"'}
            </div>
        </div>

        {if $product.hostname || $product.owndomain || $product.domain_options}
            <div class="like-table-row">
                <div style="width: 160px">{$lang.Domain}</div>
                <div>
                    {if $draft.domains}
                        <select class="inp" name="domain" onchange="if($(this).val() == 0) $(this).hide().next().show(); ">
                            {if $submit.host}<option>{$submit.host}</option>
                            {/if}
                            {foreach from=$draft.domains item=domain}
                                <option>{$domain.name}</option>
                            {/foreach}
                            <option value="0">Use other domain</option>
                        </select>
                    {/if}
                    <input class="inp"  {if $draft.domains}style="display:none"{/if} name="host" value="{$submit.host|escape}"  />
                </div>
            </div>
        {/if}
        {if $product_addons}
            {foreach from=$product_addons item=addon key=addon_id}
                <div class="like-table-row">
                    <div style="width: 160px">{$addon.name}</div>
                    <div>
                        <input class="inp" type="text" onkeypress="if(event.charCode != 0 && (event.charCode < 48 || event.charCode > 57)) return false;" size="2" value="{$submit.addons[$addon_id].qty}" name="addons[{$addon_id}][qty]" /> x
                        {include file='_common/billing_select.tpl' product=$addon format=$draft.currency cycle=$submit.addons[$addon_id].cycle name="addons[`$addon.id`][cycle]" atributes='onchange="order.get_product(this);"' }
                        {if $addon.description}
                            <small>{$addon.description}</small>
                        {/if}
                    </div>
                </div>
            {/foreach}
        {/if}
        {if $product_forms}
            {*debug output=ajax like=product_forms*}
            {if $submit.service}
                {assign value=false var=enablefieldlogic}
            {else}

                {assign value=true var=enablefieldlogic}

                {foreach from=$product_forms item=c key=kk}
                    {if $c.config.conditionals}
                        <div class="like-table-row">
                            <div style="width: 160px"><span>Apply field logic</span></div>
                            <div >
                                <span class="label label-livemode label-default-invert field-logic-off" onclick="return order.lock_logic(true);">Off</span>
                                <span class="label label-livemode label-success field-logic-on"  onclick="return order.lock_logic(false);">On</span>

                            </div>
                        </div>
                        {break}{/if}
                {/foreach}
            {/if}
            {foreach from=$product_forms item=c key=kk}

                {if $c.items}
                    <div class="like-table-row product_form_row">
                        <div style="width: 160px"><span>{$c.name} </span></div>
                        <div class="product_cf_{$kk} " default="{if $submit.custom.$kk}{foreach from=$submit.custom.$kk item=ci}{$ci}{/foreach}{else}{$c.config.initialval}{/if}">
                            {include file=$c.configtemplates.accounts currency=$draft.currency fieldlogic=$enablefieldlogic}
                        </div>
                        <script type="text/javascript">var sid = '{$sid}'; $('.product_cf_{$kk}').find('input, select').each({literal}function(){$(this).addClass('inp')}{/literal})</script>
                    </div>
                {/if}
            {/foreach}
        {/if}
        <script type="text/javascript">order.initFormValues();</script>
        <div class="like-table-row">
            <div style="width:160px;padding-top: 12px;">
                {if !$submit.service}
                    QTY: <input type="text" size="3" value="1" placeholder="1" name="qty" />
                {/if}
            </div>
            <div style="padding-top: 8px;" class="pull-left">&nbsp;



                <a class="btn  btn-info " href="#" onclick="$(this).parents('form').submit(); return false;" style="margin:0px 0px 1px 0px">
                    {if $submit.service}
                        <span>Upgrade Service</span>
                    {else}
                        <span>Add Product</span>
                    {/if}

                </a>

                {if $submit.service}
                    <a class="btn  btn-info" href="#"  onclick="actionClone($(this).parents('form'));" style="margin:0px 0px 1px 0px">
                        <span>Clone Service</span>
                    </a>
                    <script>
                        {literal}
                        function actionClone(form){
                            form.append('<input id="clone" type="hidden" name="clone" value="1">');
                            form.submit();
                            $('#clone').remove();
                        }
                        {/literal}
                    </script>
                {/if}

            </div>
        </div>
    {/if}
{elseif $make == 'getdomain'}

    {if $period}
        <div class="like-table-row">
            <div style="min-width: 160px">{$lang.Period}</div>
            <select class="inp" name="domain_period">
                {foreach from=$period item=years}
                    <option value="{$years}" {if $years == $submit.domain_period}selected="selected" {/if}>{$years}{if $years == 1} {$lang.Year}{else} {$lang.Years}{/if}</option>
                {/foreach}
            </select>
        </div>
        {if $domain_forms}
            {foreach from=$domain_forms item=c key=kk}
                {if $c.items}
                    <div class="like-table-row">
                        <div style="width: 160px">{$c.name} </div>
                        <div class="product_cf_{$kk}" default="{$c.config.initialval}">
                            {include file=$c.configtemplates.accounts currency=$draft.currency}
                        </div>
                        <script type="text/javascript">var sid = '{$sid}'; $('.product_cf_{$kk}').find('input, select').each({literal}function(){$(this).addClass('inp')}{/literal})</script>
                    </div>
                {/if}
            {/foreach}
        {/if}
        <script type="text/javascript">order.initFormValues();</script>
        <div class="like-table-row">
            <div style="padding-top: 8px;">
                <input class="inp" type="hidden" name="prod_type" value="domain" />
                &nbsp;<a class="menuitm " href="#" onclick="$(this).parents('form').submit(); return false;"><span>Add Domain</span></a>
                <span id="domain-warning"></span>
            </div>
        </div>
    {else}
        {$lang.cantgetperiods}.
    {/if}
{else}
    <div id="client_nav">
        <!--navigation-->
        <a class="nav_el nav_sel left" href="#">{$lang.orderdetails}</a>
        <div class="clear"></div>
    </div>
    <div class="ticketmsg ticketmain" id="client_tab" style="margin-bottom:10px;">
        <div class="slide" style="display:block">
            <form action="" method="post">
                <input class="inp" type="hidden" value="{$draft_id}" class="draft_id" name="id" />
                <table  width="100%" cellspacing="2" cellpadding="3" border="0" style="table-layout: fixed;">
                    <tbody>
                    <tr>
                        <td width="15%" >{$lang.draftid}</td>
                        <td >{$draft.id}</td>
                        <td width="15%" >{$lang.paymethod}</td>
                        <td >
                                <span class="editbtn_flash">
                                    <a href="?cmd=managemodules&action=payment{if $draft.module}&expand=true&id={$draft.module}{/if}" target="_blank" >
                                        {if $draft.module}
                                            {if $modules}
                                                {foreach from=$modules item=module key=id}
                                                    {if $draft.module == $id}{$module}
                                                    {/if}
                                                {/foreach}
                                            {else}
                                                {$draft.module}
                                            {/if}
                                        {else}{$lang.none}
                                        {/if}
                                    </a>
                                    {if $modules}<a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Edit}</a>
                                    {/if}
                                </span>
                            <span style="display:none" class="editbtn_flash">
                                    <select class="inp" id="orderPaymentModule" name="module" onchange="order.new_gateway(this)">
                                        <option value="0">{$lang.none}</option>
                                        {foreach from=$modules item=module key=id}
                                            <option value="{$id}"  {if $draft.module==$id}selected="selected"{/if}>{$module}</option>
                                        {/foreach}
                                        <option value="new" style="font-weight: bold">{$lang.newgateway}</option>

                                    </select>
                                    <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
									{literal}
									<script language="JavaScript">
									var orderSaveDetailId = null;
									$(document).ready( function () {
										if ($('#orderPaymentModule option:selected').val() == '0') {
										    $('#client_tab').addLoader();
											orderSaveDetailId  = setInterval(orderSaveDetail, 3000);
										}
									});
									
									function orderSaveDetail() {
										if ($('#orderPaymentModule option:selected').val() != '0') {
											clearInterval(orderSaveDetailId);
											return true;
										}
										$('#orderPaymentModule option').eq(1).prop('selected',true);
										if ($('#draftClientId option').length > 1) {
											order.save_details();
										}
									}
									
									</script>
									{/literal}
                                </span>
                        </td>
                    </tr>
                    <tr>
                        <td>{$lang.Discount}</td>
                        <td>
                                <span class="editbtn_flash">
                                    {if !$draft.discount}
                                        {$lang.none}
                                        <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Add}</a>
                                    {else}
                                        {foreach from=$draft.discount item=discount key=couponid}
                                        {if $discount.group_id && $client.group_color}
                                            <a href="?cmd=clients&action=editgroup&id={$discount.group_id}" target="_blank" {if $client.group_color}style="color:{$client.group_color}"{/if} >{$discount.code} </a>
                                            {elseif $discount.code}
                                                <a href="?cmd=coupons&action=edit&id={$couponid}" target="_blank" {if $discount.group_id && $client.group_color}style="color:{$client.group_color}"{/if} >{$discount.code} </a>
                                        {/if}
                                        {if $discount.type == 'percent'}{$discount.value}%
                                        {else}{if $admindata.access.viewOrdersPrices}{$discount.value|price:$draft.currency}{/if}
                                        {/if}
                                    {/foreach}
                                        <a href="#" class="editbtn" onclick="$(this).parent().next().remove(); order.save_details(); return false;">{$lang.Remove}</a>
                                    {/if}
                                </span>
                            <span style="display:none">
                                    {if $coupons}
                                        <select class="inp" name="discount_coupon" onchange="if($(this).val() == 0) $(this).hide().next().show();">
                                            <option value="">------</option>
                                            <option value="0">Custom discount</option>
                                            {foreach from=$coupons item=coupon}
                                                <option {if $couponid == $coupon.id}selected="selected"{/if} value="{$coupon.id}">{$coupon.code} (-{if $coupon.type == 'percent'}{$coupon.value}%{else}{if $admindata.access.viewOrdersPrices}{$coupon.value|price:$draft.currency}{else}-{/if}{/if})</option>
                                            {/foreach}
                                        </select>
                                    {/if}
                                <span {if $coupons}style="display:none" {/if}>
                                        {if $discount.group_id}
                                            <input name="discount_group_id" type="hidden" value="{$discount.group_id}" />
                                        {/if}
                                    <input class="inp" name="discount_value" type="text" size="3" value="{$discount.value}" />
                                        <select class="inp" name="discount_type">
                                            <option {if $discount.type == 'fixed'}selected="selected"{/if} value="fixed">Fixed amount</option>
                                            <option {if $discount.type == 'percent'}selected="selected"{/if} value="percent">Percent</option>
                                        </select>
                                    </span>
                                    <button class="saved" onclick="order.save_details(); return false;">{$lang.Add}</button>
                                </span>
                        </td>
                        <td >{$lang.Client}</td>
                        <td >
                            {if $draft.client_id}
                                <span class="editbtn_flash">
                                    {$client|@profilelink}
                                    <a href="#" class="editbtn"
                                       onclick="$(this).parent().hide().next().show();return false;">{$lang.Change}</a>
                                </span>
                            {/if}
                            {if $clients}
                                <span {if $draft.client_id}style="display:none"{/if} class="editbtn_flash">
                                        <select class="inp" data-id="draftClientId" name="client_id" id="client_id" >
                                           {if $draft.client_id}
                                               <option selected value="{$draft.client_id}">
                                                   #{$draft.client_id} {$client|@client} {$client.email}
                                               </option>
                                            {else}
                                                {foreach from=$clients item=cl}
                                                    <option value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.firstname} {$cl.lastname}{/if}</option>
                                                {/foreach}
                                            {/if}
                                            <option value="0">{$lang.selectcustomer}</option>
                                        </select>
                                        <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                    </span>
                            {literal}
                                <script>
                                    $(function(){
                                        $('#client_id').chosensearch({width: '200px'});
                                    })
                                </script>
                            {/literal}
                            {else}
                                {$lang.thereisnoclients}. {$lang.Click} <a href="?cmd=newclient">{$lang.here}</a> {$lang.toregisternew}.
                            {/if}
                        </td>

                    </tr>
                    <tr>
                        <td >{$lang.Amount}</td>
                        <td class="order_price">
                            {if $admindata.access.viewOrdersPrices}{$draft.price.cost|price:$draft.currency}{else}-{/if}
                        </td>
                        <td >{$lang.staffownership}</td>
                        <td >
                                <span class="editbtn_flash">
                                    {if $draft.staff_member_id}
                                        {if $staff}
                                            {foreach from=$staff item=cl}
                                                {if $draft.staff_member_id == $cl.id}
                                                    <a href="?cmd=editadmins&action=administrator&id={$draft.staff_member_id}">{$cl.firstname} {$cl.lastname}</a>
                                                {/if}
                                            {/foreach}
                                        {else}
                                            <a href="?cmd=editadmins&action=administrator&id={$draft.staff_member_id}">#{$draft.staff_member_id}</a>
                                        {/if}
                                    {else}
                                        <a href="#"><em>{$lang.none}</em></a>
                                    {/if}
                                    <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Change}</a>
                                </span>
                            {if $staff}
                                <span style="display:none" class="editbtn_flash">
                                        <select class="inp" name="staff_member_id" default="{$draft.staff_member_id}" style="width: 180px">
                                            <option value="0">{$lang.none}</option>
                                            {foreach from=$staff item=cl}
                                                <option {if $draft.staff_member_id == $cl.id}selected="selected"{/if} value="{$cl.id}">{$cl.firstname} {$cl.lastname}</option>
                                            {/foreach}
                                        </select>
                                        <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                    </span>
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top">{$lang.Recurring}</td>
                        <td class="order_price_r" style="vertical-align: top">
                            {foreach from=$draft.price.recurring_cost item=price key=cycle}
                                {$lang.$cycle}: {if $admindata.access.viewOrdersPrices}{$price|price:$draft.currency}{else}-{/if}<br />
                            {/foreach}
                        </td>
                        <td style="vertical-align: top">{$lang.orderdate}</td>
                        <td style="vertical-align: top">
                                <span class="editbtn_flash">
                                    {$draft.date|dateformat:$date_format|regex_replace:'! [^\s]*$!':''} {$draft.date|regex_replace:'!^[^\s]* !':''}
                                    <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show().children().eq(0).datePicker({literal}{startDate:startDate}{/literal}); return false;">{$lang.Change}</a>
                                </span>
                            <span style="display:none" class="editbtn_flash">
                                    <input class="inp" size="12" value="{$draft.date|dateformat:$date_format|regex_replace:'! [^\s]*$!':''}" name="orderdate"/>
                                    <input class="inp" size="6" value="{$draft.date|regex_replace:'!^[^\s]* !':''}" name="ordertime" />
                                    <a href="#" class="editbtn" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                </span>
                        </td>
                    </tr>
                    <tr>
                        <td >Referral </td>
                        <td >
                                <span class="editbtn_flash">
                                    {if $draft.affiliate_id}
                                        {if $affiliates}
                                            {foreach from=$affiliates item=cl}
                                                {if $draft.affiliate_id == $cl.id}
                                                    <a href="?cmd=affiliates&action=affiliate&id={$draft.affiliate_id}">{$cl.firstname} {$cl.lastname}</a>
                                                {/if}
                                            {/foreach}
                                        {else}
                                            <a href="?cmd=affiliates&action=affiliate&id={$draft.affiliate_id}">#{$draft.affiliate_id}</a>
                                        {/if}
                                    {else}
                                        <a href="#"><em>{$lang.none}</em></a>
                                    {/if}
                                    <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Change}</a>
                                </span>
                            {if $affiliates}
                                <span style="display:none" class="editbtn_flash">
                                        <select class="inp" name="affiliate_id" default="{$draft.affiliate_id}" style="width: 180px">
                                            <option value="0">{$lang.none}</option>
                                            {foreach from=$affiliates item=cl}
                                                <option {if $draft.affiliate_id == $cl.id}selected="selected"{/if} value="{$cl.id}">#{$cl.id} {$cl.firstname} {$cl.lastname}</option>
                                            {/foreach}
                                        </select>
                                        <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                    </span>
                            {/if}
                        </td>
                    </tr>

                    <tr>
                        {if $scenarios}
                            <td style="vertical-align: top">Order Scenario</td>
                            <td style="vertical-align: top">
                                <span class="editbtn_flash">
                                    {if $draft.scenario_id}
                                        <a href="?cmd=configuration&action=orderscenarios&do=edit&id={$draft.scenario_id}" target="_blank" >
                                          {foreach from=$scenarios item=scenario name=scloop}{if $draft.scenario_id==$scenario.id}{$scenario.name}{break}{/if}
                                          {/foreach}
                                    </a>
                                    {else}
                                        <a href="#"><em>None, use category/client default</em></a>
                                    {/if}
                                    <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">{$lang.Edit}</a>
                                   
                                </span>
                                <span style="display:none" class="editbtn_flash">
                                    <select class="inp" name="scenario_id" >
                                            <option value="0" {if !$draft.scenario_id}selected="selected"{/if}>None, use category/client default</option>
                                        {foreach from=$scenarios item=scenario name=scloop}
                                            <option value="{$scenario.id}"  {if $draft.scenario_id==$scenario.id}selected="selected"{/if}>{$scenario.name}</option>
                                        {/foreach}

                                    </select>
                                    <a href="#" class="editbtn saved" style="visibility: visible" onclick="order.save_details(); return false;">{$lang.Save}</a>
                                </span>
                            </td>
                        {/if}
                        <td style="vertical-align: top" rowspan="2">{if $draft.client_id}{$lang.Notifications}{/if}</td>
                        <td style="vertical-align: top" rowspan="2">
                            <div>
                                <input type="checkbox" value="1" name="confirm" {if $draft.options.confirm_email}data-checked="checked"{/if} onclick="$('#order_options').css('visibility','visible')" />
                                {$lang.sendconfirmemail}
                            </div>
                            <div>
                                <input type="checkbox" value="1" name="invoice_info" {if !$draft.options.generate_invoice}disabled="disabled"{/if} {if $draft.options.send_invoice && $draft.options.generate_invoice}checked="checked"{/if} id="invsend" onchange="$('#order_options').css('visibility','visible')"/>
                                {$lang.sendinvoiceinfo}
                            </div>
                            {if $draft.client_id}
                                <div>
                                    <input type="checkbox" class="override" value="1" name="override_recipients" {if $draft.options.override_recipients}checked="checked"{/if} onchange="$('#order_options').css('visibility','visible');"/>
                                    <a href="#" class="override">{$lang.override_recipients}</a>
                                </div>
                                {if $draft.options.override_recipients}
                                    <div id="recipients-list" style="margin: 5px">
                                        {foreach from=$draft.metadata.recipients item=recipient}
                                            <div>
                                                <a href="?cmd=clients&action=show&id={$draft.client_id}">
                                                    {$recipient|client:'#%id - %name'}
                                                </a>
                                            </div>
                                        {/foreach}
                                    </div>
                                {/if}
                            {/if}
                            <input type="hidden" name="invoice_generate" value="{if $draft.options.generate_invoice}1{else}0{/if}">
                            <input type="hidden" name="confirm" value="{if $draft.options.confirm_email}1{else}0{/if}">
                            <input type="hidden" name="invoice_info" value="{if $draft.options.send_invoice}1{else}0{/if}">
                            <a href="#" id="order_options" class="editbtn saved" style="visibility: hidden" onclick="order.save_details(); return false;">{$lang.savechanges}</a>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div id="overriderecipients" class="modal-content" hidden bootbox data-title="{$lang.override_recipients}" data-btntitle="{$lang.Confirm}">
                    <form action="?cmd=clientcredit" method="post">
                        <div class="form-group">
                            <label class="control-label">{$lang.recipients}</label>
                            <select name="recipients[]" class="form-control" id="client-search" multiple>
                                {foreach from=$draft.metadata.recipients item=recipient}
                                    <option value="{$recipient}" selected>
                                        {$recipient|client:'#%id %firstname %lastname %companyname %email'}
                                    </option>
                                {/foreach}
                                {foreach from=$available_recipients item=recipient}
                                    <option value="{$recipient.id}">
                                        {$recipient|@client:'#%id %firstname %lastname %companyname %email'}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                    </form>
                </div>
                {literal}
                    <script>
                        var overriderecipients = $('#overriderecipients');
                        $('.override').on('click', function () {
                            var checkbox = $('input[name="override_recipients"]');
                            if ($(this).is('a')) {
                                checkbox.prop('checked', true);
                                overriderecipients.trigger('show');
                            } else if (checkbox.prop('checked')){
                                overriderecipients.trigger('show');
                            }
                        });
                        overriderecipients.bootboxform({
                            callback: function (e) {
                                var recipients = $('#client-search',this).children(':selected').detach();
                                $('#client-search').empty().append(recipients);
                                order.save_details();
                            }
                        }).on('bootbox-form.shown', function (e, dialog) {
                            dialog.find('input, select, textarea').on('input',function () {
                                $(this).closest('.form-group').toggleClass('has-error', this.value.length === 0)
                            });
                            dialog.find('select').chosenedge({width: '100%'});
                            $('#client-search',dialog).chosensearch();
                        });
                    </script>
                {/literal}
            </form>
        </div>
    </div>
{/if}
