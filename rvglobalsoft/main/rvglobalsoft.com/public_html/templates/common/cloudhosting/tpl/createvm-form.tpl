{if $custom_overrides.cloud_create_server_form}
    {include file=$custom_overrides.cloud_create_server_form}
    {end}
{/if}

<table width="100%" cellspacing="0" cellpadding="0" border="0"
       class="vm-create-attr table-label-value table-rw-stack table-checker">
    {foreach from=$cloud.form item=row}
        <tr {if $row.row_id}id="{$row.row_id}"{/if} >
            {if $row.id}
                <td colspan="2" id="{$row.id}">
                    {if $row.label}
                        <label class="row-label">
                            {$row.label.text}
                        </label>
                    {/if}
                    {$row.content}
                </td>
            {else}
                <td>
                    {$row.label.text}
                </td>
                <td>
                    {$row.content}
                </td>
            {/if}
        </tr>
    {/foreach}
</table>