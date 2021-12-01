
    {if $whois}
        {$whois}
    {/if}

    {if $check}
        {if $transfer}
            <input type='hidden' name='domain' value='illtransfer'/>
        {else}
            <input type='hidden' name='domain' value='illregister'/>
        {/if}
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled" style="margin-bottom:20px;">
            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>

            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <tr>
                <th colspan="2" class="th1 input-name first">{$lang.domain}</th>
                <th class="th3 status">{$lang.status}</th>
                <th class="th4 period last">{foreach from=$check item=ccme}{if $ccme.status == "ok"}{$lang.period}{break}{/if}{/foreach}</th>
            </tr>
            <tbody>
            {counter start=0 print=false assign=suggested}
            {foreach from=$check item=ccme}
                {if $ccme.status == "ok"}

                    <tr>
                        <td class="first td1 input">
                            <input type="checkbox" name="tld[{$ccme.sld}{$ccme.tld}]" 
                                   value="{$ccme.tld}" checked="checked"
                                   title="{$doms.name}" />
                            <input type="hidden" name="sld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.sld}" />
                        </td>
                        <td class="td2 name">
                            <strong title="{$ccme.sld}{$ccme.tld}">{$ccme.sld}{$ccme.tld}</strong>
                        </td>
                        <td align="center" class="td3 status available">{$lang.availorder}</td>
                        <td align="center" class="td4 period last">
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
                {elseif $ccme.status != "suggested"}

                    <tr>
                        <td class="first td1 input"><input type="checkbox" class="disabled" disabled="disabled" /></td>
                        <td class="td2 name"><strong>{$ccme.sld}{$ccme.tld}</strong></td>
                        <td align="center" class="td3 status unavailable">
                            {if $check.status == 'insystem' || !$transfer}
                                {$lang.unavail}
                            {else}
                                {$lang.trans_unavail}  <br />
                                <a href="{$ca_url}cart&amp;step=1&amp;domain=illregister&amp;sld={$ccme.sld}&amp;tld={$ccme.tld}&amp;period=1&amp;ref=1&amp;cat_id=register">{$lang.trans_reg}</a>
                            {/if}
                        </td>
                        <td align="center" class="td4 period whois last">
                            <a href="https://{$ccme.sld}{$ccme.tld}" target="_blank" rel="noreferrer nofollow noopener">WWW</a>{*}
                            {*}&nbsp;{*}
                            {*}<a href="{$ca_url}checkdomain&action=whois&amp;sld={$ccme.sld}&amp;tld={$ccme.tld}&amp;security_token={$security_token}"
                               onclick="window.open(this.href, '{$ccme.sld}{$ccme.tld}', 'width=500, height=500, scrollbars=1');
                                       return false">WHOIS</a>
                        </td>
                    </tr>
                {elseif $ccme.status =="suggested"}
                    {counter}
                {/if}
            {/foreach}
            </tbody>

            {if $tosuggest}
                <tbody id="suggestionscontainer">
                <tr><td colspan="4">
                        {$lang.loadingrecomended}

                       {literal}<script>

                           $(function () {
                                   ajax_update('?cmd=checkdomain&action=suggest', {
                                       {/literal}
                                       sld:'{$tosuggest.sld}',tld:'{$tosuggest.tld}',domain_cat:'{$tosuggest.category}',product_id:'{$product_id}'
                                       {literal}
                                   }, '#suggestionscontainer');
                           });
                        </script>
                       {/literal}
                    </td></tr>

                </tbody>
            {/if}

            {if $suggested > 0}
                <tbody>
                {include file='ajax.namesuggestions.tpl' check=$check }
                </tbody>

            {/if}
            {foreach from=$check item=ccme}
                {if $ccme.status == "ok" || $ccme.status =="suggested" || $tosuggest}
                    <tr>
                        <td class="submit" colspan="4" align="center">
                            <input type="submit" value="{$lang.ordernow}" class="padded btn" style="font-weight:bold;"/>
                        </td>
                    </tr>
                    {break}
                {/if}
            {/foreach}
        </table>

{/if}