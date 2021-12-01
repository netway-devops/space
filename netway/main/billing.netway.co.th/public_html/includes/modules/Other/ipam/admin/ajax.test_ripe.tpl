{foreach from=$variables item=variable key=id}
    <span>Field with the variable <b>{$id}</b>:</span>
    {if !$variable.error}
        <span style="color: green">OK!</span>
    {else}
        <span style="color:red;">{$variable.error}</span>
    {/if}
    <br/>
{/foreach}
<br>
<span>Connection: </span> {if $connection.status}<span style="color: green">Success</span>{else}<span style="color:red;">Failed</span>{/if}<br>
<span style="color: red">{$connection.error}</span>