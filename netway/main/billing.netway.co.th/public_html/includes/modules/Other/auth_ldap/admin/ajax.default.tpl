{if $action=='testconnection'}
    {if $ok}<span class="label-success label">Success</span>{else}<span class="label-danger label">Failed</span>{/if}
{elseif $action=='testuser'}
    {if $result}<span class="label-success label">Found</span>{else}<span class="label-danger label">Failed</span>{/if}
{/if}