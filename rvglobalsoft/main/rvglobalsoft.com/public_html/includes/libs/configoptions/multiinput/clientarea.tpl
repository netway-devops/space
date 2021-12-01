{foreach from=$cst.items item=cit key=id}
    {assign var="minput_id" value=$cst.data[$id]}
    <ul>
        {foreach from=$minput_id|json_decode:1 item=minput_val}
            <li>{$minput_val}</li>
        {/foreach}
    </ul>
{/foreach}