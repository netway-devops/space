<link media="all" type="text/css" rel="stylesheet" href="includes/types/onappcloud/clientarea/styles3.css" />
<script type="text/javascript" src="includes/types/onappcloud/clientarea/scripts.js"></script>
<script type="text/javascript" src="includes/types/onappcloud/js/scripts.js"></script>

{if $widget.appendtpl }
    {include file=$widget.appendtpl}
{/if}
<div id="nav-onapp">
    <h1 class="left os-logo {if $VMDetails}{$VMDetails.guest.os_version.distro}{elseif $vmdistro}{$vmdistro}{/if}">{if $VMDetails}{$VMDetails.name_label}{else}{$vmhostname}{/if}</h1>
     <ul class="level-1">
        <li class="{if $vmsection=='vmdetails'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><span class="list-servers">{$lang.Overview}</span></a></li>
      {*  
	    <li class="{if $vmsection=='network'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips&vpsid={$vpsid}"><span class="resources">{$lang.networkzone}</span></a></li>
        <li class="{if $vmsection=='storage'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}"><span class="billing">{$lang.storage}</span></a></li>
        <li class="{if $vmsection=='usage'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=cpuusage&vpsid={$vpsid}"><span class="addserver">{$lang.Usage}</span></a></li>
      *}
		<li class="{if $vmsection=='billing'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=billing&vpsid={$vpsid}"><span class="addserver">{$lang.Billing}</span></a></li>
    </ul> <div class="clear"></div>
</div>
<div class="clear"></div>
<div id="content-cloud">
