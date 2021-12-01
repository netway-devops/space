{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'menus/menu.main.logged.tpl.php');
{/php}

{literal}
<style>
@media (min-width: 1200px) {
.container,
.navbar-static-top .container,
.navbar-fixed-top .container,
.navbar-fixed-bottom .container {
	/*width: 1200px;*/
} 
}

</style>
{/literal}
<br clear="all" />
<div class="row-c " >
        <section class="container-bg{if $cmd=='cart'} overlay-nav cart_ {$cart_template}{/if}{if $logged=='1'} not-logged-page{/if}">
<!-- Left Column -->

<aside>
    {if $cmd == 'root' || $cmd == 'clientarea'}
    <div class="topbar">
        <button class="collapse-btn">
            <i class="icon-collapse"></i>
        </button>
    </div>
    <!-- Navigation -->
    <nav class="nav nav-list main-nav">
    <li class="nav-header no-border"><span>{$lang.mainmenu}</span></li>
    <li {if $cmd == 'clientarea' && $action == 'default'}class="active-menu"{/if}><a {if $cmd == 'clientarea' && $action == 'default'} class="active-menu"{/if} href="{$ca_url}clientarea/" rel="nofollow"><div class="vert-center">
            <i class="icon-cloud"></i>
            <p>{$lang.dashboard}</p>
    </div></a>
    </li>

    <li 
    {if $cmd == 'clientarea' && ($action=='services' || $action=='accounts' || $action=='reseller' || $action=='vps' || $action=='servers' || $action == 'domains')}
    	class="active-menu"
    {/if}
    ><a 
    {if $cmd == 'clientarea' && ($action=='services' || $action=='accounts' || $action=='reseller' || $action=='vps' || $action=='servers'
    || $action == 'domains')}
    	class="active-menu"
    {/if}
    href="{$ca_url}clientarea/" rel="nofollow"><div class="vert-center">
            <i class="icon-services"></i>
            <p>{$lang.services}</p>
            {if $offer_total>0}
            <div class="link-info">{$offer_total}</div>
            {else}
            {/if}
    </div></a>
    {include file='menus/menu.dropdown.services.tpl'}
    </li>
    <li 
    {if $cmd == 'clientarea' && ($action == 'addfunds' || $action == 'details' || $action == 'profilepassword' || $action == 'password'
    || $action == 'ccard' || $action=='invoices' || $action=='cancel' || $action=='ccprocessing' || $action=='emails' || $action=='history'
    || $action=='ipaccess')}
    	class="active-menu"
    {/if}
    ><a 
    {if $cmd == 'clientarea' && ($action == 'addfunds' || $action == 'details' || $action == 'profilepassword' || $action == 'password'
    || $action == 'ccard' || $action=='invoices' || $action=='cancel' || $action=='ccprocessing' || $action=='emails' || $action=='history'
    || $action=='ipaccess')}
    	class="active-menu"
    {/if}  
    href="{$ca_url}clientarea/" rel="nofollow"><div class="vert-center">
            <i class="icon-account"></i>
            <p>{$lang.account}</p>
    </div></a>
    {include file='menus/menu.dropdown.account.tpl'}
    </li>
    <li {if $cmd == 'knowledgebase' || $cmd == 'tickets'}class="active-menu"{/if}><a {if $cmd == 'knowledgebase' || $cmd == 'tickets'}class="active-menu"{/if} href="{$zendeskSSOUrl}" ><div class="vert-center">
            <i class="icon-support"></i>
            <p>{$lang.support}</p>
    </div></a>
    {include file='menus/menu.dropdown.support.tpl'}
    </li>
    {if $enableFeatures.affiliates!='off'}
    <li {if $cmd == 'affiliates'}class="active-menu"{/if}><a {if $cmd == 'affiliates'}class="active-menu"{/if} href="{$ca_url}affiliates/"><div class="vert-center">
            <i class="icon-affilates"></i>
            <p>{$lang.affiliates}</p>
    </div></a>
    {include file='menus/menu.dropdown.affiliates.tpl'}
    </li>
    {/if}
    
    {foreach from=$HBaddons.client_mainmenu item=ad}
    <li><a href="{$ca_url}{$ad.link}/"><div class="vert-center">
            <i class="icon-cloud"></i>
            <p>{$ad.name}</p>
    </div></a>
    </li>
    {/foreach}

    {if $acc_credit>0}
        <li class="credit-node">
            <div class="credit"><i class="icon-funds"></i><p>{$lang.credit}: <strong>{$acc_credit|price:$currency}</strong></p></div>
            <div class="submenu">
                <div class="submenu-header">
                    <h4>{$lang.credit}</h4>
                    <p>{$lang.addfunds_d}</p>
                </div>
                    
                    <!-- Second box with links-->
                <div class="nav nav-list">
                    <div class="nav-submenu">
                        <p>{$acc_credit|price:$currency}</p>
                    </div>
                </div>
                {if $enableFeatures.deposit!='off' }<div class="center-btn">
                    <a href="{$ca_url}clientarea/addfunds/" class="btn support-btn l-btn">
                        <i class="icon-funds"></i>
                        {$lang.addfunds}
                    </a>
                </div>{/if}
            </div>
        </li>
    {/if}
    
	    </nav>
	    {/if}
</aside>

<!-- End of Left Column -->
<!-- Right Column (Main Container) -->
        
    <article class="main-container {if $logged=='1'}not-logged-pag{/if}{if $hb} pbh{/if}"  style="min-height: 0px;">
    {if $cmd == 'root' || $cmd == 'clientarea'}
    <div class="main-container-header-bg">
    <div class="main-container-header">
        <div class="top-right-buttons">
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
{/if}
