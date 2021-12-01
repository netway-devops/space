<link media="all" type="text/css" rel="stylesheet" href="includes/types/onappcdntype/clientarea/styles3.css" />
<link media="all" type="text/css" rel="stylesheet" href="includes/types/onappcdntype/clientarea/styles3.css" />
<script type="text/javascript" src="includes/types/onappcdntype/clientarea/scripts.js"></script>
<script type="text/javascript" src="includes/types/onappcdntype/js/scripts.js"></script>

{if $widget.appendtpl }
    {include file=$widget.appendtpl}
{/if}
<div id="nav-onapp">
    {if $resourceid}
    <h1 class="left os-logo cdnresources">{$vmhostnames.$resourceid}</h1>
    <a href="?cmd=clientarea&action=services&service={$service.id}" class="left apeded">&laquo; All resources</a>
     <ul class="level-1">
        <li class="{if $vmsection=='vmdetails' && $cdndo!='prefetch' && $cdndo!='purge'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=cdndetails&resourceid={$resourceid}"><span class="list-servers">{$lang.Overview}</span></a></li>
        {* OnApp api requies update in order for this to work:<li class="{if $vmsection=='access'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=access&resourceid={$resourceid}"><span class="resources">Access</span></a></li> *}
        <li class="{if $cdndo=='prefetch'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=prefetch&resourceid={$resourceid}"><span class="billing">Prefetch</span></a></li>
        <li class="{if $cdndo=='purge'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=purge&resourceid={$resourceid}"><span class="addserver">Purge</span></a></li>
     </ul>
    {else}
    <h1 class="left os-logo cdnresources">{$service.name}</h1>
    <ul class="level-1">
        <li class="{if !$cdndo}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}"><span class="list-servers">CDN Resources</span></a></li>
        <li class="{if $cdndo=='billing'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=billing"><span class="billing">{$lang.Billing}</span></a></li>
        <li class="{if $cdndo=='addresource'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=addresource"><span class="addserver">Add new resource</span></a></li>
    </ul>
    {/if}  <div class="clear"></div>
</div>
<div class="clear"></div>
<div id="content-cloud">
