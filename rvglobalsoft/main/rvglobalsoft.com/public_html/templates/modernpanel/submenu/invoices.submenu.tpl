<!-- Invoice Info -->
{if $acc_balance || $acc_balance == 0}
<div>
    <h2>{$lang.invoicespanel}</h2>
    <p class="no-icon">{$lang.paysearchyourinvoiceshere}</p>
    
    <div class="invoices-balance">
        <div class="p15">
            <span>{$lang.curbalance}</span>
            <p>{if $acc_credit_balance < 0}- {/if}{if $currency.sign}<span>{$currency.sign}</span>{/if}{$acc_credit_balance|abs|price:$currency:false} {$currency.code}</p>
            {if $enableFeatures.deposit!='off' }
                <button class="btn c-white-btn" href="{$ca_url}clientarea/addfunds/" onclick="window.location='{$ca_url}clientarea/addfunds/'">+ {$lang.addfunds}</button>
            {/if}
        </div>
    </div>

    <div class="short-separator">
    </div>

</div>
{/if}
<!-- End of Invoice Info -->
<!-- Quick Menu -->
<div>
    <h2>{$lang.quicklinks}</h2>
    <p class="no-icon">{$lang.importantlinks}</p>
    <div class="quick-menu">
        <ul class="link-list">
            <li {if $cmd == 'clientarea' && $action=='default'}class="active"{/if}>
                <a href="{$ca_url}clientarea">
                    <i class="icon icon-qm-dashboard"></i>
                    <p>{$lang.dashboard}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            <li {if $cmd == 'clientarea' && $action=='details'}class="active"{/if}>
                <a href="{$ca_url}clientarea/details/">
                    <i class="icon icon-qm-details"></i>
                    <p>{$lang.details}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            <li {if $cmd == 'clientarea' && $action=='profiles'}class="active"{/if}>
                <a href="{$ca_url}clientarea/profiles/">
                    <i class="icon icon-qm-contacts"></i>
                    <p>{$lang.managecontacts}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            {if $enableFeatures.deposit!='off' }
                <li  {if $cmd == 'clientarea' && $action=='addfunds'}class="active"{/if}>
                    <a href="{$ca_url}clientarea/addfunds/">
                        <i class="icon icon-qm-funds"></i>
                        <p>{$lang.addfunds}</p>
                        <span>
                            <i class="icon-single-arrow"></i>
                        </span>
                    </a>
                </li>
            {/if}
            <li {if $cmd == 'clientarea' && $action=='invoices'}class="active"{/if}>
                <a href="{$ca_url}clientarea/invoices">
                    <i class="icon icon-qm-invoices"></i>
                    <p>{$lang.invoices}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            <li {if $cmd == 'clientarea' && $action=='history'}class="active"{/if}>
                <a href="{$ca_url}clientarea/history/">
                    <i class="icon icon-qm-logs"></i>
                    <p>{$lang.logs}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
        </ul>
    </div>
</div>
<!-- End of Quick Links -->
