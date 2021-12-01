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
            </select> <br />
            <input style="font-weight: bold" type="submit" name="do_renew" value="{$lang.orderrenewal}"  class="btn btn-success" />
            <input type="button" value="{$lang.cancel}" onclick="$(this).parent().parent().hide().removeClass('shown');
                    return false;" class="btn " />
            {securitytoken}</form>
        {else}
        <font style="color: #C00">{$lang.renewnotavailable}</font>
    {/if}
{else}
    {if $domains}
        {foreach from=$domains item=domain name=foo}
            <tr class="styled-row{if $domain.status == 'Expired'} expired{elseif $domain.status == 'Active' && $domain.daytoexpire < 60 && $domain.daytoexpire >= 0} nearexpire{/if}" >
                <td>
                    <div class="td-rel">
                        <div class="left-row-side {$domain.status}-row"></div>
                    </div>
                    <input type="checkbox" name="ids[]" value="{$domain.id}" onclick="c_unc(this)" class="idchecker" {if $domain.status!='Active' && $domain.status!='Expired'}disabled="disabled" {/if} />
                </td>
                <td class="bold overflow-elipsis">
                    <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/">{$domain.name}</a>
                    {if $domain.status == 'Active' || $domain.status == 'Expired'}
                        {if $domain.daytoexpire < 60 && $domain.daytoexpire >= 0}
                            <strong class="label label-warning">
                                {$domain.daytoexpire} 
                                {if $domain.daytoexpire==1}{$lang.day}
                                {else}{$lang.days}
                                {/if} {$lang.toexpire}!
                            </strong>
                        {/if}
                    {/if}
                </td>
                <td style="vertical-align:central">{if !$domain.date_created || $domain.date_created == '0000-00-00'}-{else}{$domain.date_created|dateformat:$date_format}{/if}</td>
                <td>
                    {if !$domain.expires || $domain.expires == '0000-00-00' || ($domain.status!='Active' && $domain.status!='Expired') }-
                    {else}{$domain.expires|dateformat:$date_format}
                    {/if}
                </td>
                <td class="{$domain.status}-label bold overflow-elipsis">{$lang[$domain.status]}</td>
                <td> 
                    {if $domain.status == 'Active' || $domain.status == 'Expired'}
                        {if $domain.autorenew=='0'}
                            <span class="Pending">{$lang.Off}</span>
                        {else}<span class="Active">{$lang.On}</span>
                        {/if}
                    {else}-
                    {/if}
                </td>
                <td class="btn-col" style="width: 50px">
                    <div class="td-rel">
                        <div class="right-row-side"></div>
                    </div>
                    {if $domain.status=='Active' || $domain.status == 'Expired'}
                        <div class="btn-group">
                            <a data-toggle="dropdown" class="btn dropdown-toggle">
                                <i class="icon-cog"></i> <span style="padding:0" class="caret"></span>
                            </a>
                            <ul class="dropdown-menu align-l dropdown-left">
                                <div class="dropdown-padding">
                                    <li>
                                        <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/" style="color:#737373">{$lang.managedomain}</a>
                                    </li>

                                    <li class="disabled widget_domainrenewal">
                                        <a href="{$ca_url}clientarea/domains/&id=renew&ids[]={$domain.id}" style="color:#737373">{$lang.renew_widget} </a>
                                    </li>
                                    {if $domwidgets}
                                        {foreach from=$domwidgets item=widg}
                                            <li class="disabled widget_{$widg.widget}">
                                                <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/&widget={$widg.widget}#{$widg.widget}" style="color:#737373"" >
                                                    {assign var=widg_name value="`$widg.name`_widget"}
                                                    {if $lang[$widg_name]}{$lang[$widg_name]}
                                                    {elseif $lang[$widg.widget]}{$lang[$widg.widget]}
                                                    {else}{$widg.name}
                                                    {/if}
                                                </a>
                                            </li>
                                        {/foreach} 
                                    {/if}
                                </div>
                            </ul>
                        </div>
                    {else}
                        <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/" class="btn">
                            <i class="icon-cog"></i>
                        </a>
                    {/if}
                </td>
            </tr>
            <tr class="empty-row">
            </tr>
        {foreachelse}
            <tr><td colspan="3">{$lang.nothing}</td></tr>
        {/foreach}
    {/if}
{/if}