<section class="section-account-header">
    <h1>{$lang.affiliates}</h1>
</section>

{if $cmd=='affiliates' && $affiliate}
    <div class="nav-tabs-wrapper">
        <ul class="nav nav-tabs nav-slider horizontal d-flex justify-content-between flex-nowrap align-items-center" role="tablist">
            <li>
                <ul class="nav flex-nowrap">
                    <li class="nav-item {if $action == 'default' || $action == '_default'} active {/if}">
                        <a class="nav-link" href="{$ca_url}{$cmd}/">{$lang.affiliatecenter}</a>
                    </li>
                    <li class="nav-item {if $action == 'commissions'} active {/if}">
                        <a class="nav-link" href="{$ca_url}{$cmd}/commissions/">{$lang.mycommisions}</a>
                    </li>
                    <li class="nav-item {if $action=='payouts'} active {/if}">
                        <a class="nav-link" href="{$ca_url}{$cmd}/payouts/">{$lang.payouts}</a>
                    </li>
                    <li class="nav-item {if $action=='vouchers' || $action=='addvoucher'} active {/if}">
                        <a class="nav-link" href="{$ca_url}{$cmd}/vouchers/">{$lang.myvouchers}</a>
                    </li>
                    {if $show_commission_plans}
                        <li class="nav-item {if $action=='commission_plans'} active {/if}">
                            <a class="nav-link" href="{$ca_url}{$cmd}/commission_plans/">{$lang.commission_plans}</a>
                        </li>
                    {/if}
                </ul>
            </li>
            <li>
                <ul class="nav">
                    <li class="ml-3">
                        <a class="btn btn-success btn-sm" href="{$ca_url}{$cmd}/addvoucher/">{$lang.newvoucher}</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
{/if}