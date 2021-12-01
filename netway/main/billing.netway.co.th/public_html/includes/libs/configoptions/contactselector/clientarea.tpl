{foreach from=$cst.items item=cit}
    {foreach from=$cst.contacts item=cont}
        {if $cit.data == $cont.id}
            {$cont.firstname} {$cont.lastname}
        {/if}
    {/foreach}
    <br/>
{/foreach}