<div class="dropdown-menu submenu" style="width:500px">
    <div class="wrapper">
        <ul class="nav nav-pills nav-stacked submenu-account-nav">
            <li class="nav-header">{$lang.mainaccount}</li>
            <li><a href="{$ca_url}clientarea/details/" >{$lang.details} <span></span></a></li>
            <li><a href="{$ca_url}clientarea/password/" >{$lang.changepass} <span></span></a></li>
            <li><a href="{$ca_url}profiles/" >{$lang.managecontacts} <span></span></a></li>
                {if $enableFeatures.security=='on'}
                <li><a href="{$ca_url}clientarea/ipaccess/" >{$lang.security} <span></span></a></li>
                {/if}
                {if $enableFeatures.deposit!='off' }<li><a href="{$ca_url}clientarea/addfunds/">{$lang.addfunds} <span></span></a></li>
                {/if}
        </ul>
        <ul class="nav nav-pills nav-stacked submenu-account-nav">
            <li class="nav-header">{$lang.billing}</li>
            <li ><a href="{$ca_url}clientarea/invoices/">{$lang.invoices} <span></span></a></li>
            <li ><a href="{$ca_url}clientarea/ccard/">{$lang.ccard} <span></span></a></li>
        </ul>
        <ul class="nav nav-pills nav-stacked submenu-account-nav">
            <li class="nav-header">{$lang.userhistory}</li>
            <li ><a href="{$ca_url}clientarea/emails/">{$lang.emails} <span></span></a></li>
            <li ><a href="{$ca_url}clientarea/history/">{$lang.logs} <span></span></a></li>
        </ul>
        <div class="submenu-account-bg"></div>
    </div>
</div>