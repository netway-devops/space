{foreach from=$cst.items item=cit key=id}
    {assign var="ssh_id" value=$cst.data[$id]}
    <ul>
        {foreach from=$ssh_id|json_decode:1 item=ssh_key}
            <li>{if $cst.ssh_keys[$ssh_key].name}{$cst.ssh_keys[$ssh_key].name}{else}{$ssh_key}{/if}</li>
        {/foreach}
    </ul>
{/foreach}