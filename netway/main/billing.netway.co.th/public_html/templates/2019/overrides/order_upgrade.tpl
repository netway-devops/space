<div class="card">
    <div class="card-header d-flex flex-row justify-content-between align-items-center">
        <strong>{$lang.serviceupgrade}: {$contents.product.product_name}</strong>
    </div>
    <div class="card-body">
        <table class="checker table table-borderless w-100">
            <thead class="thead-transparent">
                <tr>
                    <th class="static" width="55%" align="left">{$lang.Description}</th>
                    <th class="static" width="25%">{$lang.price}</th>
                </tr>
            </thead>
            <tbody>
            {if $contents.product && $contents.product.product_id != $contents.product.new_product_id}
                <tr>
                    <td valign="top">{$contents.product.upgrade_name}</td>
                    <td class="font-weight-bold">{$contents.product.charge|price:$currency}</td>
                </tr>
            {/if}

            {if $contents.config}
                {foreach from=$contents.config  item=cstom}
                    {if $cstom.hidden}{continue}{/if}
                    <tr>
                        <td>
                            <b>{$cstom.config_cat_name}</b>
                            {if $cstom.description}:{/if}
                            {$cstom.description}
                            <br/>
                        </td>
                        <td><strong>{$cstom.charge|price:$currency}</strong></td>
                    </tr>
                {/foreach}
            {/if}
            {if !$tax && $subtotal.coupon}
                <tr>
                    <td class="text-lg-right">
                        {$lang.discount}
                    </td>
                    <td >
                        <strong>
                            {if $subtotal.discount > 0}
                                - {$subtotal.discount|price:$currency}
                            {else}
                                + {$subtotal.discount|abs|price:$currency}
                            {/if}
                        </strong>
                    </td>
                </tr>
            {/if}
            {if $tax}
                <tr>
                    <td class="text-lg-right">{$lang.subtotal}</td>
                    <td >{$tax.subtotal|price:$currency}</td>
                </tr>
                {if $subtotal.coupon}
                    <tr>
                        <td class="text-lg-right">
                            {$lang.discount}
                        </td>
                        <td >
                            <strong>
                                {if $subtotal.discount > 0}
                                    - {$subtotal.discount|price:$currency}
                                {else}
                                    + {$subtotal.discount|abs|price:$currency}
                                {/if}
                            </strong>
                        </td>
                    </tr>
                {/if}
                {if $tax.tax1 && $tax.taxed1!=0}
                    <tr>
                        <td class="text-lg-right">{$lang.vateu} @ {$tax.tax1}%  </td>
                        <td >{$tax.taxed1|price:$currency}</td>
                    </tr>
                {/if}

                {if $tax.tax2  && $tax.taxed2!=0}
                    <tr>
                        <td class="text-lg-right">{$lang.vateu} @ {$tax.tax2}%  </td>
                        <td >{$tax.taxed2|price:$currency}</td>
                    </tr>
                {/if}

                {if $tax.credit!=0}
                    <tr>
                        <td class="text-lg-right"><strong>{$lang.credit}</strong> </td>
                        <td ><strong>{$tax.credit|price:$currency}</strong></td>
                    </tr>
                {/if}

            {elseif $credit}
                {if  $credit.credit!=0}
                    <tr>
                        <td class="text-lg-right"><strong>{$lang.credit}</strong> </td>
                        <td ><strong>{$credit.credit|price:$currency}</strong></td>
                    </tr>
                {/if}
                <tr>
                    <td class="text-lg-right">{$lang.subtotal}</td>
                    <td >{$subtotal.total|price:$currency}</td>
                </tr>
            {else}
                <tr>
                    <td class="text-lg-right">{$lang.subtotal}</td>
                    <td >{$subtotal.total|price:$currency}</td>
                </tr>
            {/if}
            {if !empty($tax.recurring)}
                <tr>
                    <td class="text-lg-right">
                        {$lang.total_recurring}
                    </td>
                    <td>
                        {foreach from=$tax.recurring item=rec key=k}
                            {$rec|price:$currency} {$lang.$k}
                            <br/>
                        {/foreach}
                    </td>
                </tr>
            {elseif !empty($subtotal.recurring)}
                <tr>
                    <td class="text-lg-right">{$lang.total_recurring}</td>
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
                <td class="text-lg-right">
                    <strong>
                        {if $contents.product.billingtype == 'PostPay'}
                            {$lang.total_postpay}
                        {else}
                            {$lang.total_today}
                        {/if}
                    </strong>
                </td>
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

{if $grantscredit}
    <div class="greenbox">
        {$lang.amountreturned}
        <b>
            {if $tax}{$tax.total|abs|price:$currency}
            {elseif $credit}{$credit.total|abs|price:$currency}
            {else}{$subtotal.total|abs|price:$currency}
            {/if}
        </b>
    </div>
{/if}

<form action="" method="post" onsubmit='$("#checkout").addLoader();'>
    <input type="hidden" name="make" value="upgrade"/>
    {if $gateways}
        <div class="card">
            <div class="card-header">
                <strong>{$lang.choose_payment}</strong>
            </div>
            <div class="card-body" id="cart-gateway-list">
                {if $gateways}
                    <div class="d-flex flex-row justify-content-center flex-wrap cart-gateway-list">
                        {foreach from=$gateways item=module key=mid name=payloop}
                            <input type="radio" name="gateway" value="{$mid}"
                                   {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"
                                   {elseif $smarty.foreach.payloop.first}checked="checked"{/if}/>
                            {$module}
                        {/foreach}
                    </div>
                {/if}
            </div>
        </div>
    {/if}
    <div class="d-flex flex-row align-items-center justify-content-center my-5">
        <a href="{$contents.cancel_url}" class="btn-link btn-lg mx-2">{$lang.cancel}</a>
        <input type="submit" value="{$lang.submit}" class="btn btn-primary btn-lg w-25 mx-2"/>
    </div>
</form>