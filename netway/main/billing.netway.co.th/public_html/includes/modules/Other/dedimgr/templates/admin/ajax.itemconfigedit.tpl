<form action="?cmd=dedimgr&action=itemconfigedit&item_id={$item.id}&id={if $entry.id}{$entry.id}{else}new{/if}" method="POST">
    <input type="hidden" name="save" value="1"/>
    <table style="width: 95%" cellpadding="6" cellspacing="0">
        <tr>
            <td style="width: 80px">Description</td>
            <td><input type="text" class="form-control" size="100" name="description" value="{$entry.description|escape}"/></td>
        </tr>

        <tr>

            <td>Status</td>
            <td>
                {if $entry.id}

                    {if $entry.archived}
                        <span style="background: gray; color: white; font-weight: bold; border-radius: 3px; padding: 1px 4px;">Archived</span>
                        <input type="checkbox" name="archived" value="1"/> Set this as active configuration
                    {else}
                        <span style="background: #3EA23D; color: white; font-weight: bold; border-radius: 3px; padding: 1px 4px;">Active</span>
                        {if $upmode}<input type="checkbox" checked="checked" name="archived" value="1"/> Copy old version to archive
                        {/if}
                    {/if}
                {else}
                    <select class="inp" name="archived">
                        <option value="0">Active</option>
                        <option value="1">Archived</option>
                    </select>
                {/if} 
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top">Config</td>
            <td>
                <textarea style="width: 100%; min-height: 300px;" class="form-control" name="config">{$entry.config|escape}</textarea>
            </td>
        </tr>

    </table>
    {securitytoken}
</form>