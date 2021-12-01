{if $depts}
    {foreach from=$depts item=dept name=cat}
        <tr>
            <td><a href="?cmd=ticketdepts&action=edit&id={$dept.id}">{$dept.name}</a></td>
            <td><a href="?cmd=ticketdepts&action=edit&id={$dept.id}">{$dept.description}</a></td>
            <td><a href="?cmd=ticketdepts&action=edit&id={$dept.id}">{$dept.email}</a></td>
            <td>{if $dept.visible=='1'}{$lang.No}{else}{$lang.Yes}{/if}</td>
            <td>
                <input type="hidden" name="sort[]" value="{$dept.id}"/>
                {if !$smarty.foreach.cat.first}
                    <a href="javascript:void(0);" onclick="sortit(this, 'up')" class="upsorter">Up</a>
                {/if}</td>
            <td>{if !$smarty.foreach.cat.last}
                    <a href="javascript:void(0);" onclick="sortit(this, 'down')" class="downsorter">Down</a>
                {/if}</td>
            <td><a href="?cmd=ticketdepts&make=delete&id={$dept.id}&security_token={$security_token}" class="delbtn"
                   onclick="return confirm('{$lang.deletedeptconfirm}');">Delete</a></td>
        </tr>
    {/foreach}
    <script type="text/javascript">bindTicketEvents();</script>
{/if}
