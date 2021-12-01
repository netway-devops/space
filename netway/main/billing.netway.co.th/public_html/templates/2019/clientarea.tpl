{if $action == 'details'}
    {include file='clientarea/editdetails.tpl'}

{elseif $action=='addfunds'}
    {include file='clientarea/addfunds.tpl'}

{elseif $action=='profilepassword'}
    {include file='contacts/changepassword.tpl'}

{elseif $action=='password'}
    {include file='clientarea/changepassword.tpl'}

{elseif $action=='ipaccess'}
    {include file='clientarea/ipaccess.tpl'}

{elseif $action=='ccard'}
    {include file='clientarea/creditcard.tpl'}

{elseif $action=='ach'}
    {include file='clientarea/ach.tpl'}

{elseif $action=='ccprocessing'}
    {include file='clientarea/ccprocessing.tpl'}

{elseif $action=='transfers'}
    {include file='clientarea/transfers.tpl'}

{elseif $action=='emails'}
    {include file='clientarea/emails.tpl'}

{elseif $action=='creditlogs'}
    {include file='clientarea/creditlogs.tpl'}

{elseif $action=='history'}
    {include file='clientarea/history.tpl'}

{elseif $action=='portal_notifications'}
    {include file='clientarea/portal_notifications.tpl'}

{elseif $action=='invoices'}
    {include file='clientarea/invoices.tpl'}

{elseif $action=='creditreceipts'}
    {include file='clientarea/creditreceipts.tpl'}

{elseif $action=='estimates'}
    {include file='clientarea/estimates.tpl'}

{elseif $action=='domains'}
    {include file='services/domains.tpl'}

{elseif $action=='services' || $action=='accounts' || $action=='reseller' || $action=='vps' || $action=='servers'}
    {include file='services/services.tpl'}

{elseif $action=='overview'}
    {include file='clientarea/overview.tpl'}

{elseif $action=='delete'}
    {include file='clientarea/delete.tpl'}

{elseif $action=='settings'}
    {include file='clientarea/settings.tpl'}

{elseif $action=='cancel' || $action=='canceldomain'}
    {include file='services/cancelationrequest.tpl'}

{elseif $action=='thankyou'}
    {include file='clientarea/thankyou.tpl'}

{elseif $action=='paymenet-failed'}
    {include file='clientarea/paymenetfailed.tpl'}

{else}
    {include file='clientarea/dashboard.tpl'}
{/if}

