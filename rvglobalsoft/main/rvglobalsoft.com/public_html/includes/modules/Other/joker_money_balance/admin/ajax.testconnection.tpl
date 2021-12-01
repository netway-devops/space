{if $result}
    {if $result.result == 'Success'}
        <b><span style="color: #009900;;">{$result.result}</span></b>
    {else}
        <b><span style="color: #e51c23;">{$result.result}: {$result.error}</span></b>
    {/if}
{else}
    <b><span>Could not connect</span></b>
{/if}