
<ul class="nav-account">
    <li {if $action=='details'} class="active-menu" {/if}>
        <span class="account-border-top"></span>
        <a href="{$ca_url}clientarea/details/"><i class="icon-account-edit"></i>{$lang.mydetails}</a>
        <span class="account-border-down"></span>
    </li>
    <li {if $action=='password'} class="active-menu" {/if}>
        <span class="account-border-top"></span>
        <a href="{$ca_url}clientarea/password/"><i class="icon-account-password"></i>
        {if $clientdata.contact_id}
        	{$lang.changemainpass}
        {else}
        	{$lang.changepass}
        {/if}</a>
        <span class="account-border-down"></span>
    </li>
    {if $enableFeatures.deposit!='off' }
    <li {if $action=='addfunds'} class="active-menu" {/if}>
        <span class="account-border-top"></span>
        <a href="{$ca_url}clientarea/addfunds/"><i class="icon-account-funds"></i>{$lang.addfunds}</a>
        <span class="account-border-down"></span>
    </li>
    {/if}
    {if $enableCCards}
    <li {if $action=='ccard'} class="active-menu" {/if}>
        <span class="account-border-top"></span>
        <a href="{$ca_url}clientarea/ccard/"><i class="icon-account-cc"></i>{$lang.ccard}</a>
        <span class="account-border-down"></span>
    </li>
    {/if}
    <li {if $cmd=='profiles'} class="active-menu" {/if}>
        <span class="account-border-top"></span>
        <a href="{$ca_url}profiles/"><i class="icon-account-contacts"></i>{$lang.profiles}</a>
        <span class="account-border-down"></span>
    </li>
    <li class="{if $cmd=='profiles' && (!isset($act) || !$act)} active-menu {/if}">
        <span class="account-border-top"></span>
        <a href="{$ca_url}profiles/" class=" pull-right">Address contact &nbsp; </a>
    </li>
    <li class="{if $cmd=='profiles' && (isset($act) && $act == 'emailcontact')} active-menu {/if}">
        <a href="{$ca_url}profiles/&act=emailcontact" class=" pull-right">Email contact &nbsp; </a>
        <span class="account-border-down"></span>
    </li>
    {if $enableFeatures.security=='on'}
    <li {if $action=='ipaccess'} class="active-menu" {/if}>
        <span class="account-border-top"></span>
        <a href="{$ca_url}clientarea/ipaccess/"><i class="icon-account-ip"></i>{$lang.ipaccess}</a>
        <span class="account-border-down"></span>
    </li>
    <li {if $action=='googleauth'} class="active-menu" {/if}>
        <span class="account-border-top"></span>
        <a href="index.php?cmd=google_authenticator_for_client&action=setting"><i class="icon-lock"></i> &nbsp; 2Factor</a>
        <span class="account-border-down"></span>
    </li>
    {/if}
</ul>
