

<ul class="nav nav-tabs">
    <li {if $action == 'details'}class="active-nav"{/if}><a href="{$ca_url}clientarea/details/"><div class="nav-bg-fix">{$lang.details}</div></a></li>
    <li {if $action == 'password'}class="active-nav"{/if}><a href="{$ca_url}clientarea/password/"><div class="nav-bg-fix">{$lang.changepass}</div></a></li>
    <li {if $action == 'profiles'}class="active-nav"{/if}><a href="{$ca_url}profiles/"><div class="nav-bg-fix">{$lang.managecontacts}</div></a></li>
    {if $enableFeatures.security=='on'}
        <li {if $action == 'ipaccess'}class="active-nav"{/if}><a href="{$ca_url}clientarea/ipaccess/"><div class="nav-bg-fix">{$lang.security} </div></a></li>
    {/if}
    {if $enableFeatures.deposit!='off' }
        <li {if $action == 'addfunds'}class="active-nav"{/if}><a href="{$ca_url}clientarea/addfunds/"><div class="nav-bg-fix">{$lang.addfunds}</div></a></li>
    {/if}
    <li><a href="{$ca_url}clientarea/invoices/"><div class="nav-bg-fix">{$lang.invoices}</div></a></li>
    <li><a href="{$ca_url}clientarea/ccard/"><div class="nav-bg-fix">{$lang.ccard}</div></a></li>
    <li><a href="{$ca_url}clientarea/emails/"><div class="nav-bg-fix">{$lang.emails}</div></a></li>
    <li><a href="{$ca_url}clientarea/history/"><div class="nav-bg-fix">{$lang.logs}</div></a></li>
    <li class="more-hidden"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><div class="nav-bg-fix">
    {$lang.more}<span class="caret"></span>
    </div></a>
        <ul id="more-hidden" class="dropdown-menu">
            <div class="dropdown-padding">
            </div>
        </ul>
    </li>
</ul>