{if $action=='invoices' && $invoices}
	{include file='ajax/ajax.invoices.tpl'}
{elseif $action=='creditreceipts'}
	{include file='ajax/ajax.creditreceipts.tpl'}
{elseif $action=='estimates' && $estimates}
    {include file='ajax/ajax.estimates.tpl'}
{elseif $action=='creditlogs'}
	{include file='ajax/ajax.creditlogs.tpl'}
{elseif $action=='history'}
	{include file='ajax/ajax.history.tpl'}
{elseif $action=='customfn'  || $action=='addonmodule' || $action=='services' || $action=='checkstatus'}
    {include file='ajax/ajax.services.tpl'}
{elseif $action=='domains' && $domains}
	{include file='ajax/ajax.domains.tpl'}
{elseif $action=='emails'}
	{include file='ajax/ajax.emails.tpl'}
{elseif $action=='portal_notifications'}
	{include file='ajax/ajax.portal_notifications.tpl'}
{elseif $action=='transfers'}
    {include file='ajax/ajax.transfers.tpl'}
{/if}