{include file='domain_2019/progress.tpl'}

<div class="cart">
    <div class="cards-cart">
        <div class="card shadow p-4">
            <h3 class="mb-4 text-primary pb-3 border-bottom d-flex flex-row justify-content-between align-items-center">
                {$lang.ordersummary}
                <div class="d-flex flex-row align-items-center">
                    <a href="?cmd=cart&clear=true&step=4" class="btn btn-outline-danger border-danger border mr-2 d-flex flex-row align-items-center">
                        <i class="material-icons size-sm mr-2">delete</i>
                        {$lang.clear_cart}
                    </a>
                    {if count($currencies) >1 }
                        <form action="" method="post" id="currform" class="d-flex flex-row align-items-center">
                            <input name="action" type="hidden" value="changecurr">
                            <select name="currency" onchange="$('#currform').submit()" class="form-control orm-control-sm">
                                <option value="">{$lang.Currency}</option>
                                {foreach from=$currencies item=crx}
                                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                                {/foreach}
                            </select>
                        </form>
                    {/if}
                </div>
            </h3>
            <div class="card-body p-0">
                <table class="checker table stackable table-borderless w-100">
                    <thead class="thead-transparent">
                    <tr>
                        <th class="static" width="50%" align="left">{$lang.Description}</th>
                        <th class="static" width="20%">{$lang.setupfee}</th>
                        <th class="static" width="30%">{$lang.price}</th>
                    </tr>
                    </thead>
                    {if $contents}
                        {foreach from=$contents item=order key=k}
                            <tbody>
                            {if $order.product}
                                <tr>
                                    <td data-label="{$lang.Description}">
                                        {$order.product.category_name} - <span class="font-weight-bold">{$order.product.name}</span>
                                        {if $order.product.domain}({$order.product.domain})
                                        {/if}
                                    </td>
                                    <td data-label="{$lang.setupfee}">
                                        {if $order.product.setup!=0}{$order.product.setup|price:$currency}
                                        {else}-
                                        {/if}
                                    </td>
                                    <td data-label="{$lang.price}" class="font-weight-bold">
                                        {if $order.product.price==0}{$lang.Free}
                                        {elseif $order.product.prorata_amount} {$order.product.prorata_amount|price:$currency} ({$lang.prorata} {$order.product.prorata_date|dateformat:$date_format})
                                        {else}{$order.product.price|price:$currency}
                                        {/if}
                                    </td>
                                </tr>
                            {/if}
                            {if $order.product_configuration}
                                {foreach from=$order.product_configuration item=cstom2}
                                    {foreach from=$cstom2 item=cstom}
                                        {if $cstom.total>0}
                                            <tr >
                                                <td data-label="{$lang.Description}">
                                                    {$cstom.fullname}
                                                    {if $cstom.qty>=1}x {$cstom.qty}
                                                    {/if}
                                                </td>
                                                <td data-label="{$lang.setupfee}">
                                                    {if $cstom.setup!=0}{$cstom.setup|price:$currency}
                                                    {else}-
                                                    {/if}
                                                </td>
                                                <td data-label="{$lang.price}">
                                                    {if $cstom.price==0}{$lang.Free}
                                                    {elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency} ({$lang.prorata}, {$cstom.price|price:$currency} {$lang[$cstom.recurring]})
                                                    {else}{$cstom.price|price:$currency}
                                                    {/if}
                                                </td>
                                            </tr>
                                        {/if}
                                    {/foreach}
                                {/foreach}
                            {/if}
                            {if $order.addons}
                                {foreach from=$order.addons item=addon}
                                    <tr >
                                        <td data-label="{$lang.Description}">{$lang.addon} {$addon.name}</td>
                                        <td data-label="{$lang.setupfee}">
                                            {if $addon.setup!=0}{$addon.setup|price:$currency}
                                            {else}-
                                            {/if}
                                        </td>
                                        <td data-label="{$lang.price}">
                                            {if $addon.price==0}{$lang.Free}
                                            {elseif $addon.prorata_amount} {$addon.prorata_amount|price:$currency} ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
                                            {else} {$addon.price|price:$currency}
                                            {/if}
                                        </td>
                                    </tr>
                                {/foreach}
                            {/if}
                            {if $order.domains }
                                {foreach from=$order.domains item=domenka key=kk}{if $domenka.action!='own' && $domenka.action!='hostname'}
                                    <tr >
                                        <td data-label="{$lang.Description}">
                                            {if $domenka.action=='register'}{$lang.domainregister}
                                            {elseif $domenka.action=='transfer'}{$lang.domaintransfer}
                                            {elseif $domenka.action=='renew'}{$lang.domainrenewal}
                                            {/if}
                                            - {$domenka.name} - {$domenka.period} {$lang.years}
                                        </td>
                                        <td data-label="{$lang.setupfee}">-</td>
                                        <td data-label="{$lang.price}">{$domenka.price|price:$currency}</td>
                                    </tr>
                                    {if $domenka.forms}
                                        {foreach from=$domenka.forms item=cstom2}
                                            {foreach from=$cstom2 item=cstom}
                                                {if $cstom.total>0}
                                                    <tr >
                                                        <td data-label="{$lang.Description}" valign="top">
                                                            {$cstom.fullname}
                                                            {if $cstom.qty>=1}x {$cstom.qty}
                                                            {/if}
                                                        </td>
                                                        <td data-label="{$lang.setupfee}">
                                                            {if $cstom.setup!=0}{$cstom.setup|price:$currency}
                                                            {else}-
                                                            {/if}
                                                        </td>
                                                        <td data-label="{$lang.price}">
                                                            {if $cstom.price==0}{$lang.Free}
                                                            {elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}
                                                            {else}{$cstom.price|price:$currency}
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                {/if}
                                            {/foreach}
                                        {/foreach}
                                    {/if}
                                {/if}
                                {/foreach}
                            {/if}
                            {if $order.subproducts}
                                {foreach from=$order.subproducts item=subprod}
                                    <tr class="srow">
                                        <td data-label="{$lang.Description}" valign="top">{$subprod.category_name} - <strong>{$subprod.name}</strong></td>
                                        <td data-label="{$lang.setupfee}">{if $subprod.setup!=0}{$subprod.setup|price:$currency}{else}-{/if}</td>
                                        <td data-label="{$lang.price}">
                                            {if $subprod.price==0}<strong>{$lang.Free}</strong>
                                            {elseif $subprod.prorata_amount}<strong> {$subprod.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
                                            {else}<strong>{$subprod.price|price:$currency}</strong>{/if}
                                        </td>
                                    </tr>
                                {/foreach}
                            {/if}
                            {if $order.total.discount}
                                <tr >
                                    <td data-label="{$lang.Description}" valign="top">{$lang.discount}</td>
                                    <td data-label="{$lang.setupfee}"></td>
                                    <td data-label="{$lang.price}"><strong>- {$order.total.discount|price:$currency}</strong></td>
                                </tr>
                            {/if}
                            <tbody>
                            <tr>
                                <td colspan="3">
                                    <a href="{$ca_url}cart&cart=edit&order={$k}" class="text-primary text-small mr-3">
                                        {$lang.edit_config}
                                    </a>

                                    {if !$contents[2] && $order.product.domainoptions}
                                        <a href="{$ca_url}cart&cart=edit&order={$k}&step=1"  class="text-success">{$lang.add_domain}</a>
                                    {/if}
                                    <a href="{$ca_url}cart&cart=clear&order={$k}"  class="text-danger text-small">
                                        {$lang.remove}
                                    </a>
                                </td>
                            </tr>
                            </tbody>
                        {/foreach}
                    {/if}
                    {if $tax}
                        <tr >
                            <td class="text-md-right" colspan="2">{$lang.subtotal}</td>
                            <td >{$tax.subtotal|price:$currency}</td>
                        </tr>

                        {if $subtotal.coupon}
                            <tr >
                                <td class="text-md-right" colspan="2">{$lang.discount}</td>
                                <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                            </tr>
                        {/if}

                        {if $tax.tax1 && $tax.taxed1!=0}
                            <tr >
                                <td class="text-md-right" colspan="2">{$tax.tax1name} @ {$tax.tax1}%  </td>
                                <td>{$tax.taxed1|price:$currency}</td>
                            </tr>
                        {/if}

                        {if $tax.tax2  && $tax.taxed2!=0}
                            <tr >
                                <td class="text-md-right" colspan="2">{$tax.tax2name} @ {$tax.tax2}%  </td>
                                <td>{$tax.taxed2|price:$currency}</td>
                            </tr>
                        {/if}

                        {if $tax.credit!=0}
                            <tr>
                                <td class="text-md-right" colspan="2"><strong>{$lang.credit}</strong> </td>
                                <td><strong>{$tax.credit|price:$currency}</strong></td>
                            </tr>
                        {/if}
                    {elseif $credit}
                        {if  $credit.credit!=0}
                            <tr>
                                <td class="text-md-right" colspan="2"><strong>{$lang.credit}</strong> </td>
                                <td><strong>{$credit.credit|price:$currency}</strong></td>
                            </tr>
                        {/if}
                        {if $subtotal.coupon}
                            <tr >
                                <td class="text-md-right" colspan="2">{$lang.discount}</td>
                                <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                            </tr>
                        {/if}

                        <tr>
                            <td class="text-md-right" colspan="2">{$lang.subtotal}</td>
                            <td>{$subtotal.total|price:$currency}</td>
                        </tr>
                    {else}

                        {if $subtotal.coupon}
                            <tr >
                                <td class="text-md-right" colspan="2">{$lang.discount}</td>
                                <td><strong>- {$subtotal.discount|price:$currency}</strong></td>
                            </tr>
                        {/if}

                        <tr>
                            <td class="text-md-right" align="right" colspan="2">{$lang.subtotal}</td>
                            <td>{$subtotal.total|price:$currency}</td>
                        </tr>

                    {/if}

                    {if !empty($tax.recurring)}
                        <tr >
                            <td class="text-md-right" colspan="2">{$lang.total_recurring}</td>
                            <td>
                                {foreach from=$tax.recurring item=rec key=k}
                                    {$rec|price:$currency} {$lang.$k}<br/>
                                {/foreach}
                            </td>
                        </tr>

                    {elseif !empty($subtotal.recurring)}
                        <tr >
                            <td colspan="2">{$lang.total_recurring}</td>
                            <td class="text-md-right">
                                {foreach from=$subtotal.recurring item=rec key=k}
                                    {$rec|price:$currency} {$lang.$k}<br/>
                                {/foreach}
                            </td>
                        </tr>
                    {/if}
                    <tbody>
                    <tr>
                        <td align="left">
                        </td>
                        <td class="text-md-right"><strong>{$lang.total_today}</strong> </td>
                        <td >
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

    {clientwidget module="cart" section="summary" wrapper="widget.tpl"}

    {if $suggestions}

    <div class="card shadow p-4">
        <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.youalsointerestedin}</h3>
        <div class="card-body p-0 suggested">
                <div id="slides" class="row card-deck root-boxes">
                    {foreach from=$suggestions item=item}
                        <a class="col-12 col-xs-6 col-md-4 col-lg-2 card mb-2 d-flex flex-column align-items-center justify-content-center root-box" href="{$ca_url}cart/{$item.slug}/&action=add&id={$item.id}">
                            <i class="text-primary material-icons mb-4">add_shopping_cart</i>
                            <h4 class="">{$item.name}</h4>
                        </a>
                    {/foreach}
                </div>
            </div>
        </div>
        <script type="text/javascript" src="{$template_dir}dist/js/slides.min.jquery.js"></script>
        <script type="text/javascript" src="{$template_dir}dist/js/suggest.js"></script>
    {/if}
    <form action="{$ca_url}cart" method="post">
        <input type="hidden" name="make" value="checkout" />


        <div class="card shadow p-4" {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
            <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.choose_payment}</h3>
            <div class="card-body p-0" id="cart-gateway-list">
                {if $gateways}
                    <div class="d-flex flex-row justify-content-center flex-wrap cart-gateway-list">
                        {foreach from=$gateways item=module key=mid name=payloop}
                            <span class="mx-2">
                                <input onclick="$('#gatewayform').show();
                                ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id=' + $(this).val(), '', '#gatewayform', true)" type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module}
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
            <div class="card-body p-0">
                    <div id="updater" >
                        {if $submit.cust_method=='login'}
                            {include file="`$template_path`ajax.loginform.tpl"}
                        {else}
                            {include file="`$template_path`ajax.signup.tpl"}
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
            <a href="?cmd=products" class="btn btn-outline-light border border-primary text-primary btn-lg w-100 w-md-50 py-4 mb-2 mb-md-0 mr-0 mr-md-1">
                <i class="material-icons size-md mr-2">add_shopping_cart</i>
                {$lang.continue_shopping|default:"Continue shopping"}
            </a>
            <button type="submit" value="{$lang.checkout}" name="submit" class="btn btn-primary btn-lg w-100 w-md-50 py-4 ml-0 ml-md-1">
                <i class="material-icons size-md mr-2">done</i>
                {$lang.checkout}
            </button>
        </div>
    </form>
</div>