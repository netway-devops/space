{include file="`$clouddir`header.cloud.tpl"}

{if $vpsdo=='vmdetails'}
    {include file="`$clouddir`details.tpl"}
{else}
    {include file="`$clouddir``$vpsdo`.tpl"}

{/if}
{include file="`$clouddir`footer.cloud.tpl"}