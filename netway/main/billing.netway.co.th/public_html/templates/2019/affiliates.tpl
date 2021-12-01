{if $affiliate}
    {if $action == 'default' || $action == '_default'}
        {include file='affiliates/details.tpl'}
    {elseif $action == 'commissions'}
        {include file='affiliates/commissions.tpl'}
    {elseif $action == 'vouchers'}
        {include file='affiliates/vouchers.tpl'}
    {elseif $action == 'addvoucher'}
        {include file='affiliates/addvoucher.tpl'}
    {elseif $action == 'payouts'}
        {include file='affiliates/payouts.tpl'}
    {elseif $action == 'commission_plans'}
        {include file='affiliates/commission_plans.tpl'}
    {/if}
{else}
    {include file='affiliates/invite.tpl'}
{/if}
