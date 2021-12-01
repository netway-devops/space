{include file="`$cloudstackdir`header.cloud.tpl"}
<div class="header-bar">
<h3 class="{$vpsdo} hasicon">{if $vpsdo=='backups'}{$lang.snapshots}{elseif $vpsdo=='templates'}{$lang.templates}{elseif $vpsdo=='backupschedule'}{$lang.backupschedule}{else}{$lang.disks}{/if}</h3>

<ul class="sub-ul">
    <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=templates&vpsid={$vpsid}" class="{if $vpsdo=='templates'}active{/if}" ><span>{$lang.templates}</span></a></li>
    <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups&vpsid={$vpsid}" class="{if $vpsdo=='backups'}active{/if}" ><span>{$lang.snapshots}</span></a></li>
    <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}" class="{if $vpsdo=='disks' || $vpsdo=='backupschedule'}active{/if}" ><span>{$lang.disks}</span></a></li>
</ul>
<div class="clear"></div>
</div>
<div class="content-bar">
    {include file="`$cloudstackdir``$vpsdo`.tpl"}
</div>
{include file="`$cloudstackdir`footer.cloud.tpl"}