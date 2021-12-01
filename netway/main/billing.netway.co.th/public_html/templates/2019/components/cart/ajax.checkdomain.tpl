{if $whois}
    {$whois}
{/if}

{if $check}
    {if $transfer}
        <input type='hidden' name='domain' value='illtransfer'/>
    {else}
        <input type='hidden' name='domain' value='illregister'/>
    {/if}
    <div class="table-responsive table-borders table-radius mb-4">
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table stackable" content="mb-4">
            <thead>
                <tr>
                    <th class="w-50">{$lang.domain}</th>
                    <th>{$lang.status}</th>
                    <th>{foreach from=$check item=ccme}{if $ccme.status == "ok"}{$lang.period}{break}{/if}{/foreach}</th>
                </tr>
            </thead>
            {counter start=0 print=false assign=suggested}
            <tbody>
                {foreach from=$check item=ccme}
                    {if $ccme.status == "ok"}
                        <tr>
                            <td class="inline-row">
                                <input type="checkbox" name="tld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.tld}" checked="checked" title="{$doms.name}"/>
                                <input type="hidden" name="sld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.sld}"/>
                                <strong class="ml-3" title="{$ccme.sld}{$ccme.tld}">{$ccme.sld}{$ccme.tld}</strong>
                            </td>
                            <td class="inline-row-right">
                                <span class="badge badge-success badge-styled">{$lang.availorder}</span>
                            </td>
                            <td>
                                {price tld=$ccme transfer=$transfer}
                                <select name="period[{$ccme.sld}{$ccme.tld}]" content="form-control">
                                    <option value="@@cycle" @@selected>@@line</option>
                                </select>
                                {/price}
                            </td>
                        </tr>
                    {elseif $ccme.status != "suggested"}
                        <tr>
                            <td class="inline-row">
                                <input type="checkbox" class="disabled" disabled="disabled"/>
                                <strong class="ml-3">{$ccme.sld}{$ccme.tld}</strong>
                            </td>
                            <td class="inline-row-right">
                                {if $check.status == 'insystem' || !$transfer}
                                    <span class="badge badge-danger badge-styled">{$lang.unavail}</span>
                                {else}
                                    <span class="badge badge-danger badge-styled">{$lang.trans_unavail}</span>
                                    <br/>
                                    <a href="{$ca_url}cart&amp;step=1&amp;domain=illregister&amp;sld={$ccme.sld}&amp;tld={$ccme.tld}&amp;period=1&amp;ref=1&amp;cat_id=register">{$lang.trans_reg}</a>
                                {/if}
                            </td>
                            <td>
                                <a href="https://{$ccme.sld}{$ccme.tld}" target="_blank" rel="noreferrer nofollow noopener">WWW</a>
                                <a href="{$ca_url}checkdomain&action=whois&amp;sld={$ccme.sld}&amp;tld={$ccme.tld}&security_token={$security_token}" onclick="window.open(this.href, '{$ccme.sld}{$ccme.tld}', 'width=500, height=500, scrollbars=1');return false">WHOIS</a>
                            </td>
                        </tr>
                    {elseif $ccme.status =="suggested"}
                        {counter}
                    {/if}
                {/foreach}
            </tbody>
        </table>
    </div>

{if $tosuggest}
    <div id="suggestionscontainer">
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
    </div>
{/if}

    {if $suggested > 0}
        {include file='ajax.namesuggestions.tpl' check=$check }
    {/if}
    {foreach from=$check item=ccme}
        {if $ccme.status == "ok" || $ccme.status =="suggested" || $tosuggest}
            <div class="d-flex flex-row justify-content-center my-5">
                <button class="btn btn-success w-25" type="submit">{$lang.ordernow}</button>
            </div>
            {break}
        {/if}
    {/foreach}
{/if}