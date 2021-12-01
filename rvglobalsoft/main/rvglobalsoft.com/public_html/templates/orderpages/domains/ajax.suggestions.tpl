<tr class="status-head">
    <td class="name" colspan="2">{$lang.rnames}</td>
    <td class="status">{$lang.status}</td>
    <td class="period">{$lang.period}</td>
</tr>


{foreach from=$check item=ccme name=foo}
    {if $ccme.status =="suggested"}
        <tr class="status-row {if $smarty.foreach.foo.index%2 == 1}status-row-white{/if}">
            <td align="" class="input"><input type="checkbox" name="tld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.tld}" />
                <input type="hidden" name="sld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.sld}" /></td>
            <td align="" class="name"><strong>{$ccme.sld}{$ccme.tld}</strong></td>
            <td align="" class="status available"><span>{$lang.availorder}</span></td>
            <td align="">
                <div class="select-status"><div>
                        <select name="period[{$ccme.sld}{$ccme.tld}]">
                            {foreach from=$ccme.prices item=price}
                                {if $transfer && $price.transfer>=0}
                                    <option value="{$price.period}">{$price.period} {$lang.years} @ {$price.transfer|price:$currency}</option>
                                {elseif !$transfer && $price.register>=0}
                                    <option value="{$price.period}">{$price.period} {$lang.years} @ {$price.register|price:$currency}</option>
                                {/if}

                            {/foreach}
                        </select>
                    </div></div>
            </td>
        </tr>
    {/if}
{/foreach}
