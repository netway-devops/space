



<div class="submenu">
    <div class="submenu-header">
        <h4>{$lang.mainaccount}</h4>
        <p>{$lang.managedetailsinfo}</p>
    </div>
        <!-- First box with links-->
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li class="nav-header">{$lang.mainaccount}</li>
                    <li><a href="{$ca_url}clientarea/details/" >{$lang.details} <span></span></a></li>
                    <li><a href="{$ca_url}clientarea/password/" >{$lang.changepass} <span></span></a></li>
                    <li><a href="{$ca_url}profiles/" >{$lang.managecontacts} <span></span></a></li>
                    {if $enableFeatures.security=='on'}<li ><a href="{$ca_url}clientarea/ipaccess/" >{$lang.security} <span></span></a></li>{/if}
                    {if $enableFeatures.deposit!='off' }<li><a href="{$ca_url}clientarea/addfunds/">{$lang.addfunds} <span></span></a></li>{/if}
                </ul>
            </div>
        </div>
        
        <!-- Second box with links-->
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li class="nav-header">{$lang.billing}</li>
                    <li ><a href="{$ca_url}clientarea/invoices/">{$lang.invoices} <span></span></a></li>
                    <li ><a href="{$ca_url}clientarea/ccard/">{$lang.ccard} <span></span></a></li>
                </ul>
            </div>
        </div>
        
        <!-- Third box with links-->
        <div class="nav nav-list">
            <div class="nav-submenu">
                <ul>
                    <li class="nav-header">{$lang.userhistory}</li>
                    <li ><a href="{$ca_url}clientarea/emails/">{$lang.emails} <span></span></a></li>
                    <li ><a href="{$ca_url}clientarea/history/">{$lang.logs} <span></span></a></li>
                </ul>
            </div>
        </div>
        
        <div class="center-btn">
        <a href="{$ca_url}clientarea/" class="btn support-btn l-btn">
            <i class="icon-support-home"></i>
            {$lang.dashboard}
        </a>
        </div>
       
    </div>