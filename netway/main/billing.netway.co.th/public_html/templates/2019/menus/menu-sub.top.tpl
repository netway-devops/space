<nav class="navbar sub-bar d-lg-none shadow-none flex-column bg-white justify-content-start" style="min-height:100px!important;">
    <div class="w-100 navbar-body py-0 my-0 bg-white d-flex flex-row" style="height: 50px!important;">
        <ul class="navbar-nav navbar-menu" style="height:49px;">
            <li class="nav-item">
                <a class="nav-link border-left-0" href="#" role="button" onclick="$('.sub-bar .navbar-search').toggle();$('.sub-bar .navbar-search input').focus();return false;">
                    <i class="material-icons">search</i>
                </a>
            </li>
        </ul>
        <ul class="navbar-nav navbar-menu d-flex justify-content-end" style="height:49px;">
            {if $logged=='1'}
                {clientwidget module="header" section="notifications" wrapper=""}
                {if 'config:EnablePortalNotifications:on'|checkcondition}
                    <li class="nav-item dropdown">
                        <a href="#" class="nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <i class="material-icons">notifications</i>
                            {if $new_notifications > 0}
                                <span class="badge badge-pill badge-primary">{$new_notifications}</span>
                            {/if}
                        </a>
                        <div class="dropdown-menu dropdown-menu-right notifications-drop mt-2">
                            <div class="notifications-drop-title d-flex flex-row justify-content-between align-items-center">
                                <div>{$lang.Notifications} ({$new_notifications})</div>
                                <div>
                                    {if $new_notifications > 0}
                                        <a href="{$ca_url}clientarea/portal_notifications/&checkall=1&security_token={$security_token}"  title="{$lang.markallasread}"><i class="material-icons icon-info-color mr-3">playlist_add_check</i></a>
                                    {/if}
                                    <a href="{$ca_url}clientarea/portal_notifications/"  title="{$lang.showall}"><i class="material-icons icon-info-color">list</i></a>
                                </div>
                            </div>
                            <div class="notifications-drop-items">
                                {foreach from=$notificationsh item=item}
                                    <a class="dropdown-item notifications-drop-item text-dark {if $item.seen} seen {/if}" href="?cmd=clientarea&action=portal_notifications&notification={$item.id}">
                                        <i class="material-icons size-xs notifications-drop-item-icon">fiber_manual_record</i>
                                        <div class="notifications-drop-item-title">
                                            <span>{$item.subject}</span>
                                        </div>
                                        <small class="text-secondary">{$item.date_added|dateformat:$date_format}</small>
                                    </a>
                                    {foreachelse}
                                    <div class="dropdown-item disabled d-flex flex-column justify-content-center align-items-center">
                                        <i class="material-icons size-hg m-3">notifications</i>
                                        <strong>{$lang.nothing}</strong>
                                    </div>
                                {/foreach}
                                {if $new_notifications > 5}
                                    <a class="dropdown-item notifications-drop-item text-dark" href="{$ca_url}clientarea/portal_notifications/">
                                        <div class="text-secondary">
                                            {$lang.showall}...
                                        </div>
                                    </a>
                                {/if}
                            </div>
                        </div>
                    </li>
                {/if}
                <li class="nav-item dropdown">
                    {if $dueinvoices}
                        <a class="nav-link" href="{$ca_url}clientarea/invoices/" role="button">
                            <i class="material-icons">account_balance_wallet</i>
                            <span class="navbar-menu-balance">
                            <span><small class="text-gray">{$lang.balance}</small></span>
                            <span><small class="text-danger font-weight-bold text-nowrap">-{$acc_balance|price:$clientdata.currency_id:true:false}</small></span>
                        </span>
                        </a>
                    {elseif $enableFeatures.deposit!='off'}
                        <a class="nav-link" href="{$ca_url}clientarea/addfunds/" role="button">
                            <i class="material-icons">account_balance_wallet</i>
                            <span class="navbar-menu-balance">
                            <span><small class="text-gray">{$lang.balance}</small></span>
                            <span><small class="text-success font-weight-bold text-nowrap">{if $acc_credit}{$acc_credit|price:$clientdata.currency_id:true:false}{else}{"0"|price:$clientdata.currency_id}{/if}</small></span>
                        </span>
                        </a>
                    {else}
                        <span class="nav-link">
                        <i class="material-icons">account_balance_wallet</i>
                        <span class="navbar-menu-balance">
                            <span><small class="text-gray">{$lang.balance}</small></span>
                            <span><small class="text-success font-weight-bold text-nowrap">{if $acc_credit}{$acc_credit|price:$clientdata.currency_id:true:false}{else}{"0"|price:$clientdata.currency_id}{/if}</small></span>
                        </span>
                    </span>
                    {/if}
                </li>
            {/if}
            {if $languages}
                <li class="nav-item dropdown">
                    <a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">
                        <i class="material-icons">language</i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg mt-2">
                        {foreach from=$languages item=ling}
                            <a class="dropdown-item language-change" href="{$ca_url}{$cmd}&action={$action}&languagechange={$ling|capitalize}">
                                {$lang[$ling]|capitalize}
                            </a>
                        {/foreach}
                    </div>
                </li>
            {/if}
        </ul>
    </div>
    <div class="w-100 navbar-search navbar-body bg-white my-0 py-0" style="display: none; height:50px;">
        <form class="form-inline w-100 my-0 py-0" style="height:50px;">
            <div class="input-group my-0 py-0">
                <input type="text" class="form-control form-control-noborders prompt py-1" placeholder="{$lang.search}" id="navbar-search-box"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <div class="input-group-prepend input-icon-placeholder">
                    <span class="navbar-search-loader"></span>
                </div>
            </div>
            <div class="dropdown-menu navbar-search-results" style="display: none;"></div>
        </form>
    </div>
</nav>