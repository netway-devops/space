{include file="`$reselldir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{if $vpsdo=='cpuusage'}{$lang.cpuusage}{else}{$lang.networkusage}{/if}</h3>

    <ul class="sub-ul">
        <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=cpuusage&vpsid={$vpsid}" class="{if $vpsdo=='cpuusage'}active{/if}" ><span>{$lang.cpucharts}</span></a></li>
        <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=networkusage&vpsid={$vpsid}" class="{if $vpsdo=='networkusage'}active{/if}" ><span>{$lang.networkcharts}</span></a></li>
    </ul>
    <div class="clear"></div>
</div>
<div class="content-bar">
    {include file="`$reselldir``$vpsdo`.tpl"}
</div>
{include file="`$reselldir`footer.cloud.tpl"}