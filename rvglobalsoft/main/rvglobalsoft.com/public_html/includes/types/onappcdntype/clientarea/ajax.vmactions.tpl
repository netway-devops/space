<ul id="vm-menu" class="right">
    <li>
        <a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=cdnedit&resourceid={$resourceid}"><img alt="{$lang.edit}" src="includes/types/onappcdntype/images/pencil.png"><br>{$lang.edit}</a>
    </li>
{* OnApp api requies update in order for this to work:
    <li>
        <a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=password&resourceid={$resourceid}"><img alt="Password protect" src="includes/types/onappcdntype/images/lock.png"><br>Password protect</a>
    </li>
    <li>
        <a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=hotlink&resourceid={$resourceid}" ><img alt="Hotlink policy" src="includes/types/onappcdntype/images/sitemap.png"><br>Hotlink policy</a>
    </li>
    <li>
        <a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=urlsign&resourceid={$resourceid}" ><img alt="URL Signing" src="includes/types/onappcdntype/images/stamp.png"><br>URL Signing</a>
    </li>
    *}
    {* 
    <li>
        <a href="?cmd=clientarea&action=services&service={$service.id}&resourceid={$resourceid}&cdndo=upgrade"><img alt="Scale" src="includes/types/onappcdntype/images/icons/24_equalizer.png"><br>{if $provisioning_type!='single'}{$lang.scale}{else}{$lang.upgrade1}{/if}</a>
    </li>
    show upgrade *}
    <li>
        <a href="?cmd=clientarea&action=services&service={$service.id}&cdndo=destroy&resourceid={$resourceid}&security_token={$security_token}" onclick="return  confirm('Are you sure you wish to remove this resource?')" ><img alt="Delete" src="includes/types/onappcdntype/images/icons/24_cross.png"><br>Delete</a>
    </li>
    {foreach from=$widgets item=widg}{if $widg.widget!='onappcdngooglemaps'}
    <li><a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&resourceid={$resourceid}&cdndo=cdndetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}"><img src="{$system_url}{$widg.config.bigimg}" alt=""><br/>{if $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}</a></li>
    {/if}{/foreach}
</ul>
<div class="clear"></div>
