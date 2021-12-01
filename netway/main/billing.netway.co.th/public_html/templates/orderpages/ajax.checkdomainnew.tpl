{if $whois}
    {$whois}
{/if}

{if $check}
    {if $bulk}
        <input type='hidden' name='domain' value='illregister'/>
        <table width="100%" cellpadding="0" cellspacing="0" class="table-status">
            <colgroup>
                <col width="5%" /> 
                <col width="31%" /> 
                <col width="31%" /> 
                <col width="33%" /> 
            </colgroup>
            <tr class="status-head">
                <td align="center">&nbsp;</td>
                <td align="center">{$lang.domain}</td>
                <td align="center">{$lang.status}</td>
                <td align="center">{foreach from=$check item=ccme}{if $ccme.status == "ok"}{$lang.period}{break}{/if}{/foreach}</td>
            </tr>


            {foreach from=$check item=ccme name=foo}
                {if $ccme.status == "ok"}

                    <tr class="status-row {if $smarty.foreach.foo.index%2 == 1}status-row-white{/if}">
                        <td align="center"><input type="checkbox" name="tld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.tld}" checked="checked"/>
                            <input type="hidden" name="sld[{$ccme.sld}{$ccme.tld}]" value="{$ccme.sld}" /></td>
                        <td align="center"><strong>{$ccme.sld}{$ccme.tld}</strong></td>
                        <td align="center">{$lang.availorder}</td>
                        <td align="right">
                            <div class="select-status">
                                <div>
                                    {price tld=$ccme transfer=$transfer}
                                        <select name="period[{$ccme.sld}{$ccme.tld}]" content="form-control">
                                            <option value="@@cycle" @@selected>@@line</option>
                                        </select>
                                    {/price}
                                </div>
                            </div>
                        </td>
                    </tr>
                {elseif  $ccme.status == ""}

                    <tr class="status-row {if $smarty.foreach.foo.index%2 == 1}status-row-white{/if}">
                        <td align="center"><input type="checkbox" disabled="disabled" /></td>
                        <td align="center"><strong>{$ccme.sld}{$ccme.tld}</strong></td>
                        <td align="center">
                            {if $transfer}
                                {$lang.trans_unavail}  <br />
                                <a href="{$ca_url}cart&amp;step=1&amp;domain=illregister&amp;sld={$ccme.sld}&amp;tld={$ccme.tld}&amp;period=1&amp;ref=1&amp;cat_id=register">{$lang.trans_reg}</a>
                            {else}
                                {$lang.unavail}
                            {/if}</td>
                        <td align="right">
                            <div class="select-status" style="line-height: 35px;"><div><a href="https://{$ccme.sld}{$ccme.tld}" target="_blank" rel="noreferrer nofollow noopener">WWW</a>&nbsp;<a href="{$ca_url}checkdomain&action=whois&amp;sld={$ccme.sld}&amp;tld={$ccme.tld}&amp;security_token={$security_token}" onclick="window.open(this.href, '{$ccme.sld}{$ccme.tld}', 'width=500, height=500, scrollbars=1');
                                    return false">WHOIS</a>
                                </div></div>
                        </td>
                    </tr>

                {/if}
            {/foreach}
        </table>
        <div class="button06" style="float:none; margin: 20px  0px 20px 270px; width: 130px;"><div><input type="submit" value="{$lang.ordernow}" /></div></div>

    {else}
        {if $transfer}
            <input type='hidden' name='domain' value='illtransfer'/>
        {else}
            <input type='hidden' name='domain' value='illregister'/>
        {/if}
        {if $check.status == 'ok'}

            <input type="hidden" name="tld[{$check.sld}{$check.tld}]" value="{$check.tld}"/>
            <input type="hidden" name="sld[{$check.sld}{$check.tld}]" value="{$check.sld}" />
            <div class="domain">
                {$lang.domain} 
                <span class="name">{$check.sld}{$check.tld}</span> 
                <span class="status available">{$lang.Available}!</span> 
                <div class="period">
                    {$lang.chooseperiod}:
                    {price tld=$check transfer=$transfer}
                        <select name="period[{$check.sld}{$check.tld}]" content="form-control">
                            <option value="@@cycle" @@selected>@@line</option>
                        </select>
                    {/price}
                </div>
            </div>
            <div class="button06" >
                <input type="submit" value="{$lang.ordernow}">
            </div>
        {else}
            <div class="domain">
                {$lang.domain} 
                <span class="name">{$check.sld}{$check.tld}</span> 
                <span class="status unavailable">{$lang.Unavailable}</span>
            </div>
        {/if}
    {/if}
{/if}