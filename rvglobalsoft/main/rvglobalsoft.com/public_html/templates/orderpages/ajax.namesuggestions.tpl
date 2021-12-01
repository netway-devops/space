{if $custom_overrides.ajax_namesuggestions}
{include file=$custom_overrides.ajax_namesuggestions}
{else}
<tr class="tr-separator"><td colspan="4"></td></tr>
<tr>
    <th colspan="2">{$lang.rnames}</th>
    <th colspan="2"></th>
</tr>
{foreach from=$check item=ccme}
{if $ccme.status =="suggested"}
    <tr>
        <td class="first t1 input">
            <input type="checkbox" name="tld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.tld}" />
            <input type="hidden" name="sld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.sld}" /></td>

        <td class="t2 name"><strong>{$ccme.sld}{$ccme.tld}</strong></td>
        <td class="t3 status available" align="center">{$lang.availorder}</td>
        <td class="t4 last period" align="center">
            <select name="period[{$ccme.sld}{$ccme.tld}]">
                {foreach from=$ccme.prices item=price}
                    {if $transfer && $price.transfer>=0}
                        <option value="{$price.period}">{$price.period} {$lang.years} @ {$price.transfer|price:$currency}</option>
                    {elseif !$transfer && $price.register>=0}
                        <option value="{$price.period}">{$price.period} {$lang.years} @ {$price.register|price:$currency}</option>
                    {/if}

                {/foreach}
            </select>
        </td>
    </tr>
{/if}
{/foreach}
{/if}