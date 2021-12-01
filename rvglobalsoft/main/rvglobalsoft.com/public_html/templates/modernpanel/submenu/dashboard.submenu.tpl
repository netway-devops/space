<!-- Account Info -->
<div>
    <h2><i class="icon-acc"></i> {$lang.accountinfo}</h2>
    <p>{$lang.basicinfoaboutyouraccount}</p>
    <div class="account-info">
        {if $acc_balance || $acc_balance == 0}
        <div class="header {if $acc_credit_balance < 0}due-alert{/if}">
            <p>{$lang.curbalance}</p>
            <span>{if $acc_credit_balance < 0}- {/if}{if $currency.sign}<small>{$currency.sign}</small>{/if}{$acc_credit_balance|abs|price:$currency:false}{if $currency.code} {$currency.code}{/if}</span>
        </div>
        {/if}
        <ul class="link-list">
            <li>
                <a href="{$ca_url}clientarea/details/"><i class="icon icon-qm-dashboard"></i> {$lang.details} <i class="icon-single-arrow pull-right"></i></a>
            </li>
            {if $enableFeatures.deposit!='off' }
                <li>
                    <a href="{$ca_url}clientarea/addfunds/"><i class="icon icon-qm-funds"></i> {$lang.addfunds} <i class="icon-single-arrow pull-right"></i></a>
                </li>
            {/if}
            {if $adminlogged}
                <li class="no-border">
                    <a href="{$admin_url}/index.php{if $login.id}?cmd=clients&amp;action=show&amp;id={$login.id}{/if}"><i class="icon icon-qm-dashboard"></i> 
                        {$lang.adminreturn} <i class="icon-single-arrow pull-right"></i>
                    </a>
                </li>
            {/if}
        </ul>
    </div>
</div>
<!-- End of Account Info -->

<!-- Quick Links -->
<div>
    <h2><i class="icon-qm"></i> {$lang.quicklinks}</h2>
    <p>{$lang.importantlinks}</p>
    <div class="quick-links">
        <ul class="link-list">
            <li>
                <a href="{$ca_url}tickets/new/">
                    <p>{$lang.openticket}</p>
                    <span>
                        {$lang.dashboard_phrase_1}
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            <li>
                <a href="{$ca_url}profiles/">
                    <p>{$lang.managecontacts}</p>
                    <span>
                        {$lang.dashboard_phrase_3}
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            {if $enableFeatures.security=='on'}
            <li>
                <a href="{$ca_url}clientarea/ipaccess/">
                    <p>{$lang.security}</p>
                    <span>
                        {$lang.dashboard_phrase_4}
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            {/if}
            {if $enableFeatures.kb!='off'}
            <li>
                <a href="{$ca_url}knowledgebase/">
                    <p>{$lang.knowledgebase}</p>
                    <span>
                        {$lang.dashboard_phrase_5}
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            {/if}
            {if $enableFeatures.netstat!='off'}
            <li>
                <a href="{$ca_url}netstat/">
                    <p>{$lang.netstat}</p>
                    <span>
                        {$lang.dashboard_phrase_6}
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            {/if}
        </ul>
    </div>
</div>