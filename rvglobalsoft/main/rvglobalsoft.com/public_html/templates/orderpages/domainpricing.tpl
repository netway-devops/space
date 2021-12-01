{if $prices}
    <div class="cleart clear"></div>
    {if count($currencies)>1}
        <div class="left" style="padding-top: 1em">
            <form action="" method="post" id="currform">
                <input type="hidden" name="showpricing" value="true" />
                <input type="hidden" name="action" value="{$action}" />
                {$lang.Currency} 
                <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                    {foreach from=$currencies item=crx}
                        <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                    {/foreach}
                </select>
            </form>
        </div> 
    {/if}

    <div class="clear fs11" >
        <a href="#domainprices"  onclick="$('.regprices').show();
                $(this).hide();
                return false;"  
           {if $showpricing}style="display:none"{/if} >
            {$lang.domainpricing} &raquo;
        </a>
    </div>
{/if}

<a name="domainprices"></a>
<div class="regprices"  {if !$showpricing}style="display:none"{/if} >
    {if $prices}
        <div class="clear" style="margin-bottom:10px;"></div>
        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="styled">

            <tr  class="head-table status-head">
                <td class="tld">{$lang.tld}</td>
                <td class="period">{if $transfer}{$lang.transfer}{else}{$lang.register}{/if} {$lang.minperiod}</td>
                <td class="renew">{$lang.renew}</td>
            </tr>
            {foreach from=$prices item=price name=foo}
                <tr class="row-table {if $smarty.foreach.foo.index == 0}row-table-row1{elseif $smarty.foreach.foo.index%2 == 1}row-table-white{/if}">
                    <td class="tld">{$price.tld}</td>
                    <td class="setup" title="{$price.period} {$lang.years}">
                        {if $transfer}
                            {if $price.transfer>0}{$price.transfer|price:$currency}
                            {elseif $price.transfer==0}{$lang.free}
                            {else}-
                            {/if}
                        {else}
                            {if $price.register>0}{$price.register|price:$currency}
                            {elseif $price.register==0}{$lang.free}
                            {else}-
                            {/if}
                        {/if}
                        <span class="price-period" >{$price.period} {$lang.years}</span>
                    </td>
                    <td class="renew" title="{$price.period} {$lang.years}">
                        {if $price.renew>0}{$price.renew|price:$currency}
                        {elseif $price.renew==0}{$lang.free}
                        {else}-
                        {/if}
                        <span class="price-period" >{$price.period} {$lang.years}</span>
                    </td>
                </tr>
            {/foreach}
        </table>
    {/if}
</div>