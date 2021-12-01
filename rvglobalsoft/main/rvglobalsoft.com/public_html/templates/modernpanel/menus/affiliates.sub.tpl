{if $cmd=='affiliates' && $affiliate}
    <ul id="invoice-tab" class="nav nav-tabs table-nav">
        <li {if $action == 'default' || $action == '_default'} class="active" {/if}>
            <a href="{$ca_url}{$cmd}/"><div class="tab-left"></div>{$lang.affiliatecenter}<div class="tab-right"></div></a>
        </li>

        <li {if $action == 'commissions'} class="active" {/if}>
            <a href="{$ca_url}{$cmd}/commissions/"><div class="tab-left"></div>{$lang.mycommisions}<div class="tab-right"></div></a>
        </li>
        
        <li {if $action=='payouts'} class="active" {/if}>
            <a href="{$ca_url}{$cmd}/payouts/"><div class="tab-left"></div>{$lang.payouts}<div class="tab-right"></div></a>
        </li>

        <li {if $action=='vouchers' || $action=='addvoucher'} class="active" {/if}>
            <a href="{$ca_url}{$cmd}/vouchers/"><div class="tab-left"></div>{$lang.myvouchers}<div class="tab-right"></div></a>
        </li>
        <li class="custom-tab">
            <a href="{$ca_url}{$cmd}/addvoucher/" ><div class="tab-left"></div> <i class="icon-add"></i> {$lang.newvoucher} <div class="tab-right"></div></a>
        </li>
    </ul>
{/if}


