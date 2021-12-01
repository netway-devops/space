
{if $cmd=='affiliates' && $affiliate}
    
<ul class="nav nav-tabs space-nav">

    <li {if $action == 'default' || $action == '_default'} class="active-nav" {/if}>
    	<a href="{$ca_url}{$cmd}/"><div class="nav-bg-fix">{$lang.affiliatecenter}</div></a>
    </li>
    
    <li {if $action == 'commissions'} class="active-nav" {/if}>
    	<a href="{$ca_url}{$cmd}/commissions/"><div class="nav-bg-fix">{$lang.mycommisions}</div></a>
    </li>
        
    <li {if $action=='vouchers' || $action=='addvoucher'} class="active-nav" {/if}>
    	<a href="{$ca_url}{$cmd}/vouchers/"><div class="nav-bg-fix">{$lang.myvouchers}</div></a>
    </li>
    
    <li {if $action=='payouts'} class="active-nav" {/if}>
    	<a href="{$ca_url}{$cmd}/payouts/"><div class="nav-bg-fix">{$lang.payouts}</div></a>
    </li>
   
</ul>

{/if}


