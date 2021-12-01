{include file='domain_2019/progress.tpl'}

<div class="cart">
    <div class="cards-cart">
        <div class="card shadow p-4">
            <h3 class="mb-4 text-primary pb-3 border-bottom d-flex flex-row justify-content-between align-items-center">
                {$lang.ordersummary}
                {if count($currencies) >1 }
                    <form action="" method="post" id="currform" class="d-flex flex-row align-items-center">
                        <input name="action" type="hidden" value="changecurr">
                        <span class="mr-4">{$lang.Currency}</span>
                        <select name="currency" onchange="$('#currform').submit()" class="form-control orm-control-sm">
                            {foreach from=$currencies item=crx}
                                <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                            {/foreach}
                        </select>
                    </form>
                {/if}
            </h3>
            <div class="card-body">
                <table class="checker table table-borderless w-100">
                    <thead class="thead-transparent">
                        <tr>
                            <th class="static" width="55%" align="left">{$lang.Description}</th>
                            <th class="static" width="20%"> {$lang.setupfee}</th>
                            <th class="static" width="25%">{$lang.price}</th>
                        </tr>
                    </thead>
                    <tbody>
                    {if $product}
                        <tr>
                            <td valign="top">{$contents[0].category_name} -
                                <strong>{$contents[0].name}</strong> {if $contents[2].domain}({$contents[2].domain}){/if}
                                <br/>
                            </td>
                            <td>{if $contents[0].setup!=0}{$contents[0].setup|price:$currency}{else}-{/if}</td>
                            <td class="font-weight-bold">
                                {if $contents[0].price==0}
                                    <strong>{$lang.Free}</strong>
                                {elseif $contents[0].prorata_amount}
                                    <strong> {$contents[0].prorata_amount|price:$currency}</strong>({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
                                {else}
                                    <strong>{$contents[0].price|price:$currency}</strong>
                                {/if}
                            </td>
                        </tr>
                    {/if}
                    {if $cart_contents[1]}
                        {foreach from=$cart_contents[1] item=cstom2}
                            {foreach from=$cstom2 item=cstom}
                                {if $cstom.total>0}
                                    <tr>
                                        <td>{$cstom.fullname}  {if $cstom.qty>=1}x {$cstom.qty}{/if}
                                            <br/>
                                        </td>
                                        <td>{if $cstom.setup!=0}{$cstom.setup|price:$currency}{else}-{/if}</td>
                                        <td>
                                            <strong>{if $cstom.price==0}{$lang.Free}{elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}{else}{$cstom.price|price:$currency}{/if}</strong>
                                        </td>
                                    </tr>
                                {/if}
                            {/foreach}
                        {/foreach}
                    {/if}

                    {if $contents[3]}
                        {foreach from=$contents[3] item=addon}
                            <tr>
                                <td>{$lang.addon} <strong>{$addon.name}</strong></td>
                                <td>{if $addon.setup!=0}{$addon.setup|price:$currency}{else}-{/if}</td>
                                <td>
                                    {if $addon.price==0}
                                        <strong>{$lang.Free}</strong>
                                    {elseif $addon.prorata_amount}
                                        <strong>{$addon.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                                    {else}
                                        <strong>{$addon.price|price:$currency}</strong>
                                    {/if}
                                </td>
                            </tr>
                        {/foreach}
                    {/if}
                    {if $product}
                        <tr>
                            <td colspan="3">
                                <a href="{$ca_url}cart&amp;step=3" class="text-primary text-small mr-3">
                                    {$lang.edit_config}
                                </a>
                                {if !$contents[2] && $contents[0].domainoptions}
                                    <a href="{$ca_url}cart&amp;step=1" class="text-success">{$lang.add_domain}</a>
                                {/if}
                            </td>
                        </tr>
                    {/if}
                    {if $contents[2] }
                        {foreach from=$contents[2] item=domenka key=kk}{if $domenka.action!='own' && $domenka.action!='hostname'}
                            <tr>
                                <td>
                                    <strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{elseif $domenka.action=='renew'}{$lang.domainrenewal}{/if}</strong>
                                    - {$domenka.name} - {$domenka.period} {$lang.years}
                                    <br/>

                                </td>
                                <td>-</td>
                                <td><strong>{$domenka.price|price:$currency}</strong></td>
                            </tr>
                            {if $domenka.forms}
                                {foreach from=$domenka.forms item=cstom2}
                                    {foreach from=$cstom2 item=cstom}
                                        {if $cstom.total>0}
                                            <tr>
                                                <td valign="top" class="blighter fs11" style="padding-left:15px">{$cstom.fullname}  {if $cstom.qty>=1}x {$cstom.qty}{/if}
                                                    <br/>
                                                </td>
                                                <tdclass="blighter fs11">{if $cstom.setup!=0}{$cstom.setup|price:$currency}{else}-{/if}</td>
                                                <tdclass="blighter fs11">
                                                    <strong>{if $cstom.price==0}{$lang.Free}{elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}{else}{$cstom.price|price:$currency}{/if}</strong>
                                                </td>
                                            </tr>
                                        {/if}
                                    {/foreach}
                                {/foreach}
                            {/if}
                            <tr>
                                <td class="blighter fs11" style="padding-left:15px">
                                    <a href="{$ca_url}cart&amp;step=2" class="text-primary text-small mr-3">{$lang.config_extras}</a>
                                    <a href="{$ca_url}cart&amp;step=4&amp;removedomain=true&key={$kk}" class="text-danger">{$lang.remove}</a>
                                <td colspan="2"></td>
                            </tr>
                        {/if}
                        {/foreach}
                    {/if}
                    {if $contents[4]}{foreach from=$contents[4] item=subprod}
                        <tr>
                            <td>{$subprod.category_name} - <strong>{$subprod.name}</strong>
                            </td>
                            <td>{if $subprod.setup!=0}{$subprod.setup|price:$currency}{else}-{/if}</td>
                            <td>
                                {if $subprod.price==0}
                                    <strong>{$lang.Free}</strong>
                                {elseif $subprod.prorata_amount}
                                    <strong> {$subprod.prorata_amount|price:$currency}</strong>
                                    ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                                {else}
                                    <strong>{$subprod.price|price:$currency}</strong>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    {/if}
                    {if $tax}
                        <tr>
                            <td align="right" colspan="2">{$lang.subtotal}</td>
                            <td>{$tax.subtotal|price:$currency}</td>
                        </tr>
                        {if $subtotal.coupon}
                            <tr>
                                <td align="right" colspan="2">{$lang.discount}</td>
                                <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                            </tr>
                        {/if}

                        {if $tax.tax1 && $tax.taxed1!=0}
                            <tr>
                                <td align="right" colspan="2">{$tax.tax1name} @ {$tax.tax1}%  </td>
                                <td>{$tax.taxed1|price:$currency}</td>
                            </tr>
                        {/if}

                        {if $tax.tax2  && $tax.taxed2!=0}
                            <tr>
                                <td align="right" colspan="2">{$tax.tax2name} @ {$tax.tax2}%  </td>
                                <td>{$tax.taxed2|price:$currency}</td>
                            </tr>
                        {/if}

                        {if $tax.credit!=0}
                            <tr>
                                <td align="right" colspan="2"><strong>{$lang.credit}</strong> </td>
                                <td><strong>{$tax.credit|price:$currency}</strong></td>
                            </tr>
                        {/if}

                    {elseif $credit}
                        {if  $credit.credit!=0}
                            <tr>
                                <td align="right" colspan="2"><strong>{$lang.credit}</strong> </td>
                                <td><strong>{$credit.credit|price:$currency}</strong></td>
                            </tr>
                        {/if}

                        {if $subtotal.coupon}
                            <tr>
                                <td align="right" colspan="2">{$lang.discount}</td>
                                <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                            </tr>
                        {/if}
                        <tr>
                            <td align="right" colspan="2">{$lang.subtotal}</td>
                            <td>{$subtotal.total|price:$currency}</td>
                        </tr>
                    {else}

                        {if $subtotal.coupon}
                            <tr>
                                <td align="right" colspan="2">{$lang.discount}</td>
                                <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                            </tr>
                        {/if}
                        <tr>
                            <td align="right" colspan="2">{$lang.subtotal}</td>
                            <td>{$subtotal.total|price:$currency}</td>
                        </tr>
                    {/if}

                    {if !empty($tax.recurring)}
                        <tr>
                            <td align="right" colspan="2">{$lang.total_recurring}</td>
                            <td>
                                {foreach from=$tax.recurring item=rec key=k}
                                    {$rec|price:$currency} {$lang.$k}
                                    <br/>
                                {/foreach}
                            </td>
                        </tr>
                    {elseif !empty($subtotal.recurring)}
                        <tr>
                            <td align="right" colspan="2">{$lang.total_recurring}</td>
                            <td>
                                {foreach from=$subtotal.recurring item=rec key=k}
                                    {$rec|price:$currency} {$lang.$k}
                                    <br/>
                                {/foreach}
                            </td>
                        </tr>
                    {/if}
                    </tbody>
                    <tbody>
                        <tr>
                            <td align="left" style="border:none">
                                {if $subtotal.coupon}
                                {else}
                                    <div class="d-flex flex-row justify-content-start">
                                        <a class="text-small" href="#" onclick="$(this).hide(); $('#promocode').show(); return false;">{$lang.usecoupon}</a>
                                    </div>
                                    <div id="promocode" style="display:none;">
                                        <form action="" method="post" id="promoform">
                                            <input type="hidden" name="addcoupon" value="true"/>
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="promocode" placeholder="{$lang.code}" aria-label="{$lang.code}">
                                                <div class="input-group-append">
                                                    <button type="submit" class="btn btn-success">{$lang.submit}</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                {/if}
                            </td>
                            <td align="right"><strong>{$lang.total_today}</strong> </td>
                            <td>
                                <span class="font-weight-bold h1">{$currency.sign}</span>
                                {if $tax}
                                    <span class="font-weight-bold h1">{$tax.total|price:$currency:false}</span>
                                {elseif $credit}
                                    <span class="font-weight-bold h1">{$credit.total|price:$currency:false}</span>
                                {else}
                                    <span class="font-weight-bold h1">{$subtotal.total|price:$currency:false}</span>
                                {/if}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <form action="" method="post">
        <input type="hidden" name="make" value="step4"/>
        <div class="card shadow p-4" {if $tax && $tax.total==0}style="display:none" {elseif $credit && $credit.total==0}style="display:none" {elseif $subtotal.total==0}style="display:none"{/if}>
            <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.choose_payment}</h3>
            <div class="card-body p-0 suggested" id="cart-gateway-list">
                {if $gateways}
                    <div class="d-flex flex-row justify-content-center flex-wrap cart-gateway-list">
                        {foreach from=$gateways item=module key=mid name=payloop}
                            <span class="mx-2">
                                <input onclick="$('#gatewayform').show();
                                ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id=' + $(this).val(), '', '#gatewayform', true)" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked" {elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module}
                            </span>
                        {/foreach}
                    </div>
                {/if}
            </div>
        </div>
        {if $gateways}
            <div id="gatewayform">
                {$gatewayhtml}
            </div>
        {/if}
        {if $logged=="1"}

        <div class="card shadow p-4">
            <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.ContactInfo}</h3>
            <div class="card-body p-0">
                    {include file="drawclientinfo.tpl"}
                </div>
            </div>
        {else}
            <div class="card shadow p-4">
                <div class="mb-4 pb-3 border-bottom d-flex flex-column flex-md-row justify-content-between">
                    <h3 class="text-primary ">{$lang.ContactInfo}</h3>
                    <ul class="card-menu d-flex flex-row flex-wrap p-0 m-0 list-unstyled">
                        <li class="mr-2 {if !isset($submit) || $submit.cust_method=='newone'}bgon2{else}bgoff2{/if}">
                            <input type="radio" name="cust_method" value="newone" {if !isset($submit) || $submit.cust_method=='newone'}checked='checked'{/if}  onclick="{literal}ajax_update('index.php?cmd=signup', {layer: 'ajax'}, '#updater', true);
                                $(this).parent().parent().find('li.bgon2').removeClass('bgon2').addClass('bgoff2');
                                $(this).parent().removeClass('bgoff2').addClass('bgon2');{/literal}" />
                            {$lang.newclient}</li>
                        <li class="mr-2 {if $submit.cust_method=='login'}bgon2{else}bgoff2{/if}">
                            <input type="radio" name="cust_method" value="login" {if $submit.cust_method=='login'}checked='checked'{/if} onClick="{literal}ajax_update('index.php?cmd=login', {layer: 'ajax'}, '#updater', true);
                                $(this).parent().parent().find('li.bgon2').removeClass('bgon2').addClass('bgoff2');
                                $(this).parent().removeClass('bgoff2').addClass('bgon2');{/literal}" />
                            {$lang.alreadyclient}
                        </li>
                    </ul>
                </div>
                <div class="card-body">
                    <div id="updater">
                        {if $submit.cust_method=='login'}
                            {include file="ajax.loginform.tpl"}
                        {else}
                            {include file="ajax.signup.tpl"}
                        {/if}
                    </div>
                </div>
            </div>
        {/if}

        <div class="card shadow p-4">
            <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.cart_add}</h3>
            <div class="card-body p-0">
                <div class="w-100">
                    <textarea id="c_notes" class="w-100 form-control form-control-noborders textarea-autoresize" placeholder="{$lang.c_tarea}" rows="5" name="notes">{if $submit.notes}{$submit.notes}{/if}</textarea>
                </div>
            </div>
        </div>
        {if $tos}
            <div class="mb-5 mt-4">
                <input class="tos-checkbox" type="checkbox" name="tos" value="1" style="display:none!important;">
                {foreach from=$terms item=tt name=termsloop}
                    <div class="">
                        <input class="term-checkbox" type="checkbox" id="term{$smarty.foreach.termsloop.iteration}" onchange="$('.tos-checkbox').prop('checked', $('.term-checkbox:checked').length == $('.term-checkbox').length)">
                        <label for="term{$smarty.foreach.termsloop.iteration}" class="text-small">
                            {if $tt.url} <span class="mr-1">{$lang.tos1}</span><a href="{$tt.url}" target="_blank" >{$tt.name}</a>
                            {else} {$tt.name}
                            {/if}
                        </label>
                    </div>
                {/foreach}
            </div>
        {/if}
        <div class="d-flex flex-column flex-md-row align-items-center justify-content-center my-5">
            <a href="?cmd=cart&clear=true&step=4" class="btn btn-default btn-lg w-100 w-md-50 py-4 mb-2 mb-md-0 mr-0 mr-md-1">{$lang.clear_cart}</a>
            <input type="submit" value="{$lang.checkout}" name="submit" class="btn btn-primary btn-lg w-100 w-md-50 py-4 ml-0 ml-md-1"/>
        </div>
    </form>
</div>