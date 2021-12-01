{php}
    $templatePath   = $this->get_template_vars('template_path');
    include($templatePath . 'ajax/ajax.domains.tpl.php');
{/php}

{if $getRenewPeriods}
    {if $renew_prices}
        <br />
        <form action="" method="post">
            <input type="hidden" name="submit" value="1" />
            <input type="hidden" name="renew" value="1" />
            {$lang.chooseperiod}:
            <select name="period">
                {if $renew_prices}
                    {foreach from=$renew_prices item=rprice}
                        <option value="{$rprice.period}">{$rprice.period} {$lang.years} @ {$rprice.renew|price:$currency}</option>
                    {/foreach}
                {/if}
            </select>
            <br />
            <input type="submit" name="do_renew" value="{$lang.orderrenewal}" class="btn btn-primary font-weight-bold" />
            <input type="button" value="{$lang.cancel}" onclick="$(this).parent().parent().hide().removeClass('shown'); return false;" class="btn" />
            {securitytoken}
        </form>
    {else}
        <span class="text-secondary">{$lang.renewnotavailable}</span>
    {/if}
{else}
    {foreach from=$domains item=domain name=foo}
        <tr class="{if $domain.status == 'Expired'}expired{elseif $domain.status == 'Active' && $domain.daytoexpire < 60 && $domain.daytoexpire >= 0} nearexpire{/if}" >
            <td class="noncrucial">
                <input type="checkbox" name="ids[]" value="{$domain.id}" data-name="{$domain.name|escape}" class="idchecker" {if $domain.status!='Active' && $domain.status!='Expired'}disabled="disabled" {/if} />
            </td>
            <td class="font-weight-bold overflow-elipsis w-25 inline-row">
                <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/">
                    <span data-title="{$domain.name}">{$domain.name}</span>
                </a>
                {if $domain.status == 'Active' || $domain.status == 'Expired'}
                    {if $domain.daytoexpire < 60 && $domain.daytoexpire >= 0}
                        <strong class="badge badge-warning">
                            {$domain.daytoexpire}
                            {if $domain.daytoexpire==1}{$lang.day}
                            {else}{$lang.days}
                            {/if} {$lang.toexpire}!
                        </strong>
                    {/if}
                {/if}
            </td>

            <td class="font-weight-bold overflow-elipsis inline-row-right">
                <span class="badge badge-{$domain.status}">{$lang[$domain.status]}</span>
            </td>
            <td data-label="{$lang.registrationdate}:">{if !$domain.date_created || $domain.date_created == '0000-00-00'}-{else}{$domain.date_created|dateformat:$date_format}{/if}</td>
            <td data-label="{$lang.expirydate}:">
                {if !$domain.expires || $domain.expires == '0000-00-00' || ($domain.status!='Active' && $domain.status!='Expired') }-
                {else}{$domain.expires|dateformat:$date_format}
                {/if}
            </td>
            <td width="10%"  data-label="{$lang.autorenew}:">
                {if $domain.status == 'Active' || $domain.status == 'Expired'}
                    {if $domain.autorenew=='0'}
                        <span class="Pending">{$lang.Off}</span>
                    {else}
                        <span class="Active">{$lang.On}</span>
                    {/if}
                {else}-
                {/if}
            </td>
            <td style="width: 50px" class="text-right noncrucial">
                <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/">
                    <i class="material-icons icon-info-color">settings</i>
                </a>
            </td>
        </tr>
    {foreachelse}
        <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
    {/foreach}
{/if}