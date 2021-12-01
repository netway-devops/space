
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

{elseif $action=='ccprocessing'}
    {include file='clientarea/ccprocessing.tpl'}

{elseif $action=='emails'}
    {include file='clientarea/emails.tpl'}

{elseif $action=='history'}
    {include file='clientarea/history.tpl'} 

{elseif $action=='invoices'}
    {include file='clientarea/invoices.tpl'}

{elseif $action=='domains'}
    {include file='services/domains.tpl'}

{elseif $action=='services' || $action=='accounts' || $action=='reseller' || $action=='vps' || $action=='servers'}
    {include file='services/services.tpl'}

{elseif $action=='cancel'}
    {include file='services/cancelationrequest.tpl'}

{else}
    {include file='clientarea/dashboard.tpl'}
{/if}


