<div>
    <h2>{$lang.affiliatespanel}</h2>
    <p class="no-icon">{$lang.basicaffilliatesinformations}</p>

    <div class="affiliates-panel">
       <div class="well-info">
            <span>{$lang.reflink}:</span>
            <p><a style="font-weight:bold" href="{$system_url}?affid={$affiliate.id}">{$system_url}?affid={$affiliate.id}</a></p>
        </div>
    </div>
</div>

<div>
    <div class="unpaid-commission">
        <div class="pull-right">
            <i class="icon-tooltip"></i>
        </div>
        <h3>{$lang.unpaidcommissions}</h3>

        <span>{$lang.approved}</span>
        <span>{$lang.Pending}</span>

        <p><span>{$currency.sign}</span>{$affiliate.balance|price:$affiliate.currency_id:false} {$currency.code}</p>
        <p><span>{$currency.sign}</span>{$affiliate.pending|price:$affiliate.currency_id:false} {$currency.code}</p>
    </div>
</div>

<div class="short-separator">
</div>
<!-- End of Invoice Info -->

<!-- Quick Menu -->
<div>
    <h2>{$lang.quicklinks}</h2>
    <p class="no-icon">{$lang.mostimportantlinksss}</p>
    <div class="quick-menu">
        <ul class="link-list">
            <li {if $action == 'default' || $action == '_default'}class="active"{/if}>
                <a href="{$ca_url}{$cmd}/">
                    <i class="icon-qm-dashboard"></i>
                    <p>{$lang.affiliatecenter}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            <li {if $action == 'commissions'} class="active" {/if}>
                <a href="{$ca_url}{$cmd}/commissions/">
                    <i class="icon-qm-affiliates"></i>
                    <p>{$lang.mycommisions}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
            <li {if $action=='vouchers' || $action=='addvoucher'} class="active" {/if}>
                <a href="{$ca_url}{$cmd}/vouchers/">
                    <i class="icon-qm-affiliates"></i>
                    <p>{$lang.myvouchers}</p>
                    <span>
                        <i class="icon-single-arrow"></i>
                    </span>
                </a>
            </li>
        </ul>
    </div>
</div>