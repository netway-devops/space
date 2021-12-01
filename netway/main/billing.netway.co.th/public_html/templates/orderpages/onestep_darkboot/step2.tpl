<div class="left-side">
    <h3>{$lang.serviceconfiguration}</h3>
    <div class="underline-title">
        <div class="underline-bolder"></div>
    </div>
    <div class="billing-cycle">
        {if $product.paytype=='Free'}
            <p>{$lang.billingcycle}:</p>
            {$lang.Free}<input type="hidden" name="{$allprices}" value="Free">
        {elseif $product.paytype=='Once'}
            <p>{$lang.billingcycle}:</p>
            {$product.m|price:$currency:$cr_display:false:$cr_showcode:$cr_decimal:$cr_frontsign}
            <input type="hidden" name="{$allprices}" value="Once">
        {else}
            <p>{$lang.changebillingcycle}:</p>
            <div class="select-list-fix">
                <select id="select_cycle" name="cycle">
                    {price product=$product}
                        <option value="@@cycle" @@selected>@@line</option>
                    {/price}
                </select>
            </div>
        {/if}
    </div>

    <h3>{$lang.serverconfiguration}</h3>
    <div class="underline-title">
        <div class="underline-bolder"></div>
    </div>
    <input type="hidden" name="addon[0]" value="0" />
    <input type="hidden" name="subproducts[0]" value="0" />
    <table class="server-table">
        {if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
            <tr>
                <td class="config-column">  {$lang.hostname}* </td>
                <td class="config-field">
                    <input name="domain" style="width: 96%;" value="{$item.domain}" class="styled" size="50" onchange="if(typeof simulateCart == 'function') simulateCart();"/>
                </td>
            </tr>
            {if $product.extra.enableos=='1' && !empty($product.extra.os)}
                <tr>
                    <td class="config-column">  {$lang.ostemplate} *</td>
                    <td class="config-field">
                        <select name="ostemplate" class="styled"   onchange="simulateCart('#cart3');">
                            {foreach from=$product.extra.os item=os}
                                <option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
                            {/foreach}
                        </select>      
                    </td>
                </tr>
            {/if}
        {/if}
        {counter name=hsliders start=0 print=false assign=hsliders}
        {if $custom}
            {foreach from=$custom item=cf}
                {if $hsliders<3 && $cf.type=='slider'}
                    {counter name=hsliders}
                    {continue}
                {/if}
                {if $cf.items}
                    <tr>
                        <td class="config-column"> 
                            {$cf.name} {if $cf.options &1}*
                            {/if}
                        </td>
                        <td class="config-field">
                            {include file=$cf.configtemplates.cart}
                        </td>
                    </tr>
                {/if}
            {/foreach}
        {/if}

        {foreach from=$addons item=a key=k}
            <tr>
                <td class="config-column"> 
                    <span>{$a.name}</span>
                </td>
                <td class="config-addon">
                    <span class="checkbox">
                        <input name="addon[{$k}]" type="checkbox" value="1" {if $contents[3].$k}checked="checked"{/if}/> 
                    </span>
                    {if $a.paytype=='Free'}
                        <span class="product-cycle cycle-free">{$lang.free}</span>
                        <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                    {elseif $a.paytype=='Once'}
                        <span class="product-price cycle-once">{$a.m|price:$currency}</span>
                        <span class="product-cycle cycle-once">{$lang.once}</span>
                        {if $a.m_setup!=0}<span class="product-setup cycle-once">{$a.m_setup|price:$currency} {$lang.setupfee}</span>
                        {/if}
                        <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                    {else}
                        <div class="select-list-fix">
                            <select name="addon_cycles[{$k}]" >
                                {foreach from=$a item=p_price key=p_cycle}
                                    {if $p_price > 0 && ($p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5') }
                                        <option value="{$p_cycle}" {if (!$contents[3][$k] && $cycle==$p_cycle) || $contents[3][$k].recurring==$p_cycle} selected="selected"{/if}>{$a.$p_cycle|price:$currency} {assign var=p_scycle value="`$p_cycle`_setup"}{$lang.$p_cycle}{if $a.$p_scycle!=0} + {$a.$p_scycle|price:$currency} {$lang.setupfee}{/if}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                    {/if}
                </td>
            </tr>
        {/foreach}

        {foreach from=$subproducts item=a key=k}
            <tr>
                <td class="config-column"> 

                    <span>{$a.category_name} - {$a.name}</span>
                </td>
                <td class="config-addon">
                    <span class="checkbox">
                        <input name="subproducts[{$k}]" type="checkbox" value="1" {if $contents[4].$k}checked="checked"{/if}/> 
                    </span>
                    {if $a.paytype=='Free'}
                        <span class="product-cycle cycle-free">{$lang.free}</span>
                        <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                    {elseif $a.paytype=='Once'}
                        <span class="product-price cycle-once">{$a.m|price:$currency}</span>
                        <span class="product-cycle cycle-once">{$lang.once}</span>
                        {if $a.m_setup!=0}<span class="product-setup cycle-once">{$a.m_setup|price:$currency} {$lang.setupfee}</span>
                        {/if}
                        <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                    {else}
                        <div class="select-list-fix">
                            <select name="subproducts_cycles[{$k}]" >
                                {foreach from=$a item=p_price key=p_cycle}
                                    {if $p_price > 0 && ($p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5') }
                                        <option value="{$p_cycle}" {if (!$contents[4][$k] && $cycle==$p_cycle) || $contents[3][$k].recurring==$p_cycle} selected="selected"{/if}>{$a.$p_cycle|price:$currency} {assign var=p_scycle value="`$p_cycle`_setup"}{$lang.$p_cycle}{if $a.$p_scycle!=0} + {$a.$p_scycle|price:$currency} {$lang.setupfee}{/if}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </div>
                    {/if}
                </td>
            </tr>
        {/foreach}

    </table>
    <script type="text/javascript">wrapCustomForms()</script>
</div>
