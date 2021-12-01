<!-- Left Column -->
<aside>
    <div class="topbar">
        <button class="collapse-btn">
            <i class="icon-collapse"></i>
        </button>
    </div>
    <!-- Navigation -->
    <nav class="nav nav-list main-nav">
<li class="nav-header no-border"><span>{$lang.mainmenu}</span></li>
<!--<li><a href="{$ca_url}"><div class="vert-center">
        <i class="icon-cloud"></i>
        <p>{$lang.homepage}</p>
</div></a>
</li>
-->
<li><a href="{$ca_url}cart/"><div class="vert-center">
        <i class="icon-order"></i>
        <p>{$lang.order}</p>
</div></a>
{include file='menus/menu.dropdown.cart.tpl'}
</li>

<li><a href="{$ca_url}{if $enableFeatures.kb!='off'}knowledgebase/{else}tickets/new/{/if}"><div class="vert-center">
        <i class="icon-support"></i>
        <p>{$lang.support}</p>
</div></a>
{include file='menus/menu.dropdown.support.tpl'}
</li>
{if $enableFeatures.affiliates!='off'}
<li><a href="{$ca_url}affiliates/"><div class="vert-center">
        <i class="icon-affilates"></i>
        <p>{$lang.affiliates}</p>
</div></a>
</li>
{/if}

{foreach from=$HBaddons.client_mainmenu item=ad}
<li><a href="{$ca_url}{$ad.link}/"><div class="vert-center">
        <i class="icon-cloud"></i>
        <p>{$ad.name}</p>
</div></a>
</li>
{/foreach}
    </nav>
</aside>
<!-- End of Left Column -->
<!-- Right Column (Main Container) -->
        
    <article class="main-container {if $logged=='1'}not-logged-pag{/if}{if $hb} pbh{/if}">

    <div class="main-container-header-bg">
    <div class="main-container-header">
        <div class="top-right-buttons">
            <div class="btn-group">
                <a class="top-btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-add"></i>
                </a>
                <ul class="dropdown-menu">
                    <div class="dropdown-padding">
                        <li><a href="{$ca_url}cart/">{$lang.order}</a><span></span></li>
                    </div>
                </ul>
            </div>
        </div>
        {if $logged == '1'}
            {if $cmd == 'knowledgebase' || ($cmd == 'tickets' && $action == 'default') || ($cmd == 'support' && $action == 'default')}
                {include file='submenu/support.submenu.tpl'}
            {elseif $action == 'domains' || $action == 'services'}
                {include file='submenu/domain.submenu.tpl'}
            {elseif $cmd == 'affiliates'}
                {include file='submenu/affiliates.submenu.tpl'}
            {else}
                <h2>{$lang.clientarea}</h2>
            {/if}
        {else}
            {if ($cmd=='root' || $cmd=='page') && $infopages}
                {include file='menus/menu.infopages.tpl'}
            {/if}
        {/if}
    </div>
</div>




