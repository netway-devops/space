{if $justparse}
    <td class="input">
        <img src="{$template_dir}img/ajax-loading2.gif" alt="" />
        <input type="hidden" name="tlx" value="{$ccme.tld}" />
        <input type="hidden" name="slx" value="{$ccme.sld}" />
    </td>
    <td class="name"><strong>{$ccme.sld}{$ccme.tld}</strong></td>
    <td class="status checking">{$lang.checkingstatus}</td>
    <td class="period"></td>
{elseif $check.status == 'ok'}
    <td class="input">
        <input type="checkbox" name="tld[{$check.sld}{$check.tld}]" value="{$check.tld}" checked="checked" />
        <input type="hidden" name="sld[{$check.sld}{$check.tld}]" value="{$check.sld}" />
    </td>
    <td class="name">
        <strong>{$check.sld}{$check.tld}</strong>
    </td>
    <td class="status available">
        <span >{$lang.availorder}</span>
    </td>
    <td class="period">
        {price tld=$check transfer=$transfer}
            <select name="period[{$check.sld}{$check.tld}]" content="form-control">
                <option value="@@cycle" @@selected>@@line</option>
            </select>
        {/price}
    </td>
{else}
    <td class="input"><input type="checkbox" disabled="disabled" /></td>
    <td class="name">
        <strong>{$check.sld}{$check.tld}</strong>
    </td>
    <td class="status unavailable" >
        {if !$transfer || $check.status == 'insystem'}
            <span>{$lang.unavail}</span>
        {elseif $transfer}
            <span>{$lang.trans_unavail}</span>
        {/if}
    </td>
    <td>
        {if $transfer && $check.status == ''}
            <a href="{$ca_url}cart&step=1&domain=illregister&sld={$check.sld}&tld={$check.tld}&period=1&ref=1&cat_id=register">{$lang.trans_reg}</a>
        {/if}
        {if !$transfer}
            <a href="http://www.{$check.sld}{$check.tld}" target="_blank">WWW</a>
            <a href="{$ca_url}checkdomain&action=whois&sld={$check.sld}&tld={$check.tld}&security_token={$security_token}"
               onclick="window.open(this.href, '{$ccme.sld}{$ccme.tld}', 'width=500, height=500, scrollbars=1');
                       return false">WHOIS</a>
        {/if}
    </td>
{/if}