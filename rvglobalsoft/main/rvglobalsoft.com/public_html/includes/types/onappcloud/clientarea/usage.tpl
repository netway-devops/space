{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{if $vpsdo=='cpuusage'}{$lang.cpuusage}{elseif $vpsdo=='diskusage'}{$lang.diskcharts}{else}{$lang.networkusage}{/if}</h3>

    <ul class="sub-ul">
        <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=diskusage&vpsid={$vpsid}" class="{if $vpsdo=='diskusage'}active{/if}" ><span>{$lang.diskcharts}</span></a></li>
        <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=cpuusage&vpsid={$vpsid}" class="{if $vpsdo=='cpuusage'}active{/if}" ><span>{$lang.cpucharts}</span></a></li>
        <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=networkusage&vpsid={$vpsid}" class="{if $vpsdo=='networkusage'}active{/if}" ><span>{$lang.networkcharts}</span></a></li>
    </ul>
    <div class="clear"></div>
</div>
<div class="content-bar">
    {include file="`$onappdir``$vpsdo`.tpl"}
</div>
{include file="`$onappdir`footer.cloud.tpl"}