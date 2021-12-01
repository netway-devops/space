<li>
    <a {if $cmd == 'clientarea' && $action == 'default'}class="active"{/if} href="{$ca_url}clientarea/">
        <i class="icon-dashboard"></i>
        {$lang.dashboard}
    </a>
    <span class="menu-separator"></span>
</li>

<li class="dropdown drop-submenu">
    <a class="dropdown-toggle {if $cmd == 'cart'}active{/if}" href="{$ca_url}cart/" data-toggle="dropdown">
        <i class="icon-order"></i>
        {$lang.order}
    </a>
    <span class="menu-separator"></span>
    {include file='menus/menu.dropdown.cart.tpl'}
</li>

<li class="dropdown drop-submenu">
    <a class="dropdown-toggle {if $cmd == 'clientarea' && ( $action == 'service' || $action == 'services' || $action == 'domains')}active{/if}" href="{$ca_url}clientarea/" data-toggle="dropdown">
        <i class="icon-services"></i>
        {$lang.clientarea}
    </a>
    <span class="menu-separator"></span>
    {include file='menus/menu.dropdown.services.tpl'}
</li>

<li class="dropdown drop-submenu">
    <a class="dropdown-toggle {if $cmd == 'clientarea' && !( $action == 'service' || $action == 'services' || $action == 'domains') && $action != 'default'}active{/if}" href="{$ca_url}clientarea/" data-toggle="dropdown">
        <i class="icon-account"></i>
        {$lang.account}
    </a>
    <span class="menu-separator"></span>
    {include file='menus/menu.dropdown.account.tpl'}
</li>

<li class="dropdown drop-submenu">
    <a class="dropdown-toggle {if $cmd == 'support' || $cmd == 'tickets' || $cmd == 'downloads' || $cmd == 'knowledgebase'}active{/if}" href="{$ca_url}support/" data-toggle="dropdown">
        <i class="icon-support"></i>
        {$lang.support}
    </a><span class="menu-separator"></span>
    {include file='menus/menu.dropdown.support.tpl'}
</li>

{if $enableFeatures.affiliates!='off'}
    <li class="dropdown drop-submenu">
        <a class="dropdown-toggle {if $cmd == 'affiliates'}active{/if}" href="{$ca_url}affiliates/" data-toggle="dropdown">
            <i class="icon-affiliates"></i>
            {$lang.affiliates}
        </a>
        <span class="menu-separator"></span>
         {include file='menus/menu.dropdown.affiliates.tpl'}
    </li>
{/if}

