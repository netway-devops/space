{include file="`$cdndir`header.cloud.tpl"}

{if $cdndo=='cdndetails'}
    {include file="`$cdndir`details.tpl"}
{else}
    {include file="`$cdndir``$cdndo`.tpl"}

{/if}
{include file="`$cdndir`footer.cloud.tpl"}