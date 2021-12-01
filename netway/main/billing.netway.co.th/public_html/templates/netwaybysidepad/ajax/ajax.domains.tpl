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
    </select> <br />
    <input style="font-weight: bold" type="submit" name="do_renew" value="{$lang.orderrenewal}"  class="btn btn-success" />
    <input type="button" value="{$lang.cancel}" onclick="$(this).parent().parent().hide().removeClass('shown'); return false;" class="btn " />
    {securitytoken}</form>
{else}
<font style="color: #C00">{$lang.renewnotavailable}</font>
{/if}
{else}
{if $domains}
{foreach from=$domains item=domain name=foo}
<tr {if ($filter == 'active' && $domain.status == 'Expired')} style="display: none;" {/if} {*if $domain.status == 'Expired'}class="expired"{elseif $domain.status == 'Active' && $domain.daytoexpire < 60 && $domain.daytoexpire >= 0}class="nearexpire"{elseif $smarty.foreach.foo.index%2 == 0}class="even"{/if*}>

    <td>
        {if $domain.status == 'Expired' &&  $domain.isExpired}
        {elseif $domain.daytoexpire >= -30}<input type="checkbox" name="ids[]" value="{$domain.id}" onclick="c_unc(this);addToSelectedDomainItems(this);" class="idchecker" {if $domain.status!='Active' && $domain.status!='Expired'}disabled="disabled" {/if} />{/if}</td>
    <td>
        <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/">{$domain.name} <div id='domain-idn-{$domain.id}'></div>
            {literal}<script type="text/javascript">
                decodePuny('domain-idn-{$domain.id}', '{$domain.name}');
                function showrenewdomainmessage(id,mode){
                    if(mode == 'show')$("#showrenewmessage-"+id).attr({"class" : "btn-group open"});
                    else $("#showrenewmessage-"+id).attr({"class" : "btn-group"});
                }
            </script>{/literal}
        </a>
        {if $domain.status == 'Active' || $domain.status == 'Expired'}
        {if $domain.daytoexpire < 60 && $domain.daytoexpire > 0}
        <strong class="label label-warning">{$domain.daytoexpire} {if $domain.daytoexpire==1}{$lang.day}{else}{$lang.days}{/if} {$lang.toexpire}!</strong>
        {/if}{/if}</td>
    <td><center>{if !$domain.date_created || $domain.date_created == '0000-00-00'}-{else}{$domain.date_created|date_format:'%d %b %Y'}{/if}</center></td>
    <td align="center">{if !$domain.expires || $domain.expires == '0000-00-00' || ($domain.status!='Active' && $domain.status!='Expired') }<center>-</center>{else}{$domain.expires|date_format:'%d %b %Y'}{/if}</td>
    <td align="center"><span class="label label-{$domain.status}" {if $domain.daytoexpire < -30 && $domain.status == 'Expired'}onmouseover="showrenewdomainmessage('{$domain.id}','show');" onmouseleave="showrenewdomainmessage('{$domain.id}','hide')"{/if}>{$lang[$domain.status]}</span></td>
    {*<td align="center"> {if $domain.status == 'Active' || $domain.status == 'Expired'}{if $domain.autorenew=='0'}<span class="Pending">{$lang.Off}</span>{else}<span class="Active">{$lang.On}</span>{/if}{else}-{/if}</td>*}
    <td align="center">
        {if $domain.status == 'Expired' &&  $domain.isExpired}
        {elseif $domain.status=='Active' || $domain.status == 'Expired'}
          <div class="btn-group" id="showrenewmessage-{$domain.id}">
              <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/" class="btn dropdown-toggle" data-toggle="dropdown"><i class="icon-cog"></i> <span class="caret" style="padding:0"></span></a>
          <ul class="dropdown-menu" style="right:0; left:auto;">
          	<div class="dropdown-padding">
            
            {if $domain.daytoexpire >= -30}<li><a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/" style="color:#737373">{$lang.managedomain}</a></li>
            <li class="divider"></li>{else}<li><a><font color="green">**ต้องการต่ออายุโดเมนหลังจาก Expired แล้ว <br>
กรุณาติดต่อฝ่ายขาย 02-912-2558 หรือ Email : NwTeam@netway.co.th</font></a></li>{/if}

            {if $domain.daytoexpire >= -30}<li class="disabled widget_domainrenewal"><a href="{$ca_url}clientarea/domains/&id=renew&ids[]={$domain.id}" style="color:#737373">{$lang.renew_widget} </a></li>{/if}
            {if $domwidgets}
            {foreach from=$domwidgets item=widg}<li class="disabled widget_{$widg.widget}">
                    <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/&widget={$widg.widget}#{$widg.widget}" style="color:#737373" >
                       {assign var=widg_name value="`$widg.name`_widget"}
			{if $lang[$widg_name]}{$lang[$widg_name]}{elseif $lang[$widg.widget]}{$lang[$widg.widget]}{else}{$widg.name}{/if}
                    </a>
                </li>
            {/foreach} {/if}

           </div>
          </ul>
          </div>
        {else}
        <a href="{$ca_url}clientarea/domains/{$domain.id}/{$domain.name}/" class="btn"><i class="icon-cog"></i></a>
{/if}
       </td>
</tr>
{/foreach}
{/if}
{/if}