<li>
    <a class="active" href="{$ca_url}">
        <i class="icon-dashboard"></i>{$lang.homepage}
    </a>
    <span class="menu-separator"></span>
</li>

<li class="dropdown drop-submenu">
    <a class="dropdown-toggle " href="{$ca_url}cart/" data-toggle="dropdown">
        <i class="icon-order"></i>
        {$lang.order}
    </a>
    <span class="menu-separator"></span>
    {include file='menus/menu.dropdown.cart.tpl'}
</li>

<li class="dropdown drop-submenu">
    <a  href="{$ca_url}clientarea/">
        <i class="icon-account"></i>
        {$lang.clientarea}
    </a>
    <span class="menu-separator"></span>
</li>

<li class="dropdown drop-submenu">
    <a class="dropdown-toggle " href="{$ca_url}{if $enableFeatures.kb!='off'}knowledgebase/{else}tickets/new/{/if}" data-toggle="dropdown">
        <i class="icon-support"></i>
        {$lang.support}
    </a><span class="menu-separator"></span>
    {include file='menus/menu.dropdown.support.tpl'}
</li>

{if $enableFeatures.affiliates!='off'}
    <li class="dropdown drop-submenu">
        <a class="dropdown-toggle " href="{$ca_url}affiliates/" data-toggle="dropdown">
            <i class="icon-affiliates"></i>
            {$lang.affiliates}
        </a><span class="menu-separator"></span>
    </li>
{/if}

{*foreach from=$HBaddons.client_mainmenu item=ad}
<li><a href="{$ca_url}{$ad.link}/"><div class="vert-center">
<i class="icon-cloud"></i>
<p>{$ad.name}</p>
</div></a>
</li>
{/foreach*}




