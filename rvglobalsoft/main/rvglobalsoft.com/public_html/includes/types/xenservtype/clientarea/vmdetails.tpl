{include file="`$reselldir`header.cloud.tpl"}

{if $vpsdo=='vmdetails'}
    {include file="`$reselldir`details.tpl"}
{else}
    {include file="`$reselldir``$vpsdo`.tpl"}

{/if}
{include file="`$reselldir`footer.cloud.tpl"}