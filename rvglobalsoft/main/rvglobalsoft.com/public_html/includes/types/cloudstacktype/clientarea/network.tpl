{include file="`$cloudstackdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">
        {if $vpsdo=='ips'}
            {$lang.ips} 
            {if $subdo=='assignip'}&raquo; {$lang.assign_new_ip}
            {/if}
        {elseif $vpsdo=='interfaces'}{$lang.networkinterfaces} 
            {if $subdo=='addinterface'}&raquo; {$lang.addnewnetwork}
            {elseif $subdo=='edit'}&raquo; {$interface.label}
            {/if}
        {elseif $vpsdo=='fowarding'}
            {$lang.portfowarding}
        {else}
            {$lang.Firewall}
        {/if}
    </h3>
    <ul class="sub-ul">
        {*  <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=interfaces{if $vpsid}&vpsid={$vpsid}{/if}" class="{if $vpsdo=='interfaces'}active{/if}" ><span>{$lang.interfaces}</span></a></li> *}
        <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips{if $vpsid}&vpsid={$vpsid}{/if}" class="{if $vpsdo=='ips'}active{/if}" ><span>{$lang.ips}</span></a></li>
        <li ><a  href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall{if $vpsid}&vpsid={$vpsid}{/if}" class="{if $vpsdo=='firewall'}active{/if}"><span>{$lang.Firewall}</span></a></li>
        {if $advanced_network && $egress_enabled}<li ><a  href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=egressfirewall{if $vpsid}&vpsid={$vpsid}{/if}" class="{if $vpsdo=='firewall'}active{/if}"><span>Egress {$lang.Firewall}</span></a></li>{/if}
        {if $advanced_network}<li ><a  href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=fowarding{if $vpsid}&vpsid={$vpsid}{/if}" class="{if $vpsdo=='fowarding'}active{/if}"><span>{$lang.portfowarding}</span></a></li>{/if}
    </ul>
    <div class="clear"></div>
</div>
<div class="content-bar {if $subdo=='addinterface' || $subdo=='edit' || $subdo=='assignip'}nopadding{/if}">
    {include file="`$cloudstackdir``$vpsdo`.tpl"}
</div>
{include file="`$cloudstackdir`footer.cloud.tpl"}