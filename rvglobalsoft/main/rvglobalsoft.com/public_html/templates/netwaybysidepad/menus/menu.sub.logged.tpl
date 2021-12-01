<div class="row-c">
        <section class="span12 container-bg{if $cmd=='cart'} overlay-nav cart_ {$cart_template}{/if}{if $logged=='1'} not-logged-page{/if}">
<!-- Left Column -->
<aside>
    <div class="topbar">
        <button class="collapse-btn">
            <i class="icon-collapse"></i>
        </button>
    </div>
    <!-- Navigation -->
    <nav class="nav nav-list main-nav">
{if ($cmd=='root' || $cmd=='page') && $infopages}
    {foreach from=$HBaddons.client_submenu item=ad}
        <li><a href="{$ca_url}{$ad.link}/"><div class="vert-center">
                    <i class="icon-cloud"></i>
                    <p>{$ad.name}</p>
                </div></a>
        </li>
    {/foreach}
    
{elseif $cmd=='cart' || $cmd=='checkdomain'}
    <li class="nav-header no-border"><span>{$lang.quicklinks}</span></li>
    <li {if $cmd=='cart'}class='active'{/if}>
        <a href="{$ca_url}order/">
            <div class="vert-center">
                <i class="icon-order"></i>
                <p>{$lang.placeorder}</p>
            </div>
        </a>
    </li>
    {if $enableFeatures.domains!='off' && $domaincategories}
        {foreach from=$domaincategories item=cat}
            <li {if $cmd=='checkdomain' && $domain_cat==$cat.id}class='active'{/if}>
                <a href="{$ca_url}checkdomain/{$cat.slug}/">
                    <div class="vert-center">
                        <i class="icon-main-server"></i>
                        <p>{$cat.name}</p>
                    </div>
                </a>
            </li>
        {/foreach}
    {/if}

{elseif $cmd=='cart' || $cmd=='checkdomain'}
    <li class="nav-header no-border"><span>{$lang.quicklinks}</span></li>
    <li {if $cmd=='cart'}class='active'{/if}>
        <a href="{$ca_url}order/">
            <div class="vert-center">
                <i class="icon-order"></i>
                <p>{$lang.placeorder}</p>
            </div>
        </a>
    </li>
    {if $enableFeatures.domains!='off' && $domaincategories}
        {foreach from=$domaincategories item=cat}
            <li {if $cmd=='checkdomain' && $domain_cat==$cat.id}class='active'{/if}>
                <a href="{$ca_url}checkdomain/{$cat.slug}/">
                    <div class="vert-center">
                        <i class="icon-main-server"></i>
                        <p>{$cat.name}</p>
                    </div>
                </a>
            </li>
        {/foreach}
    {/if}
{/if}
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
                        <li><a href="{$ca_url}tickets/new/">{$lang.openticket}</a><span></span></li>
                        <li><a href="{$ca_url}order/">{$lang.order}</a><span></span></li>
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
