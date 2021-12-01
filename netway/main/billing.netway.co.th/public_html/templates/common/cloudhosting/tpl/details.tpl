{if $custom_overrides.cloud_server_details}
    {include file=$custom_overrides.cloud_server_details}
    {end}
{/if}

<div class="vm-details-box">
    <table border="0" cellspacing="0" cellpadding="0" width="100%" class="vm-details">
        <tr>
            {foreach from=$cloud.details_parts item=part}
                <td width="50%" class="vm-details-part" valign="top">
                    <table cellpadding="0" cellspacing="0" width="100%" class="ttable vm-details-table">
                        {foreach from=$part item=row}
                            <tr class="vm-details-row">
                                <td width="120" class="vm-details-label {if $row.label.class}{$row.label.class}{/if}">
                                    <b>{$row.label.text}</b>
                                </td>
                                <td class="vm-details-value {if $row.content.class}{$row.content.class}{/if}">
                                    {$row.content.html}
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </td>
            {/foreach}
        </tr>
    </table>
</div>

{if $cloud.tags}
    <table border="0" cellspacing="0" cellpadding="5" width="100%" class="vm-tags">
        <tr>
            <td width="120" class="vm-details-label">
                <b>{$lang.tags}</b>
            </td>
            <td class="vm-details-value vm-details-tags">
                {if $cloud.tags.list}
                    <div class="vm-tags">
                        {foreach from=$cloud.tags.list item=tag}
                            <span class="vm-tag">
                                <span>{$tag.name}</span>
                                <a href="{$tag.rem_url}">x</a>
                            </span>
                        {/foreach}
                    </div>
                {else}
                    <em class="fs11">{$lang.notags}</em>
                {/if}


                <input type="button" onclick="$(this).toggle();
                                    $('#fida').toggle()" class="btn btn-primary btn-small vm-tags-add"
                       value="{$lang.newtag}"></td>
        </tr>
        <tr id="fida" style="display:none">
            <td></td>
            <td>
                <form action="{$cloud.tags.form.action}" method="post">
                    <input type="hidden" name="make" value="addtag"/>
                    <b>{$lang.newtag}:</b>
                    <input value="" type="text" name="{$cloud.tags.form.input}"/>
                    <button type="submit" class="btn btn-primary" value="1">
                        {$lang.submit}
                    </button>
                    {securitytoken}
                </form>
            </td>
        </tr>
    </table>
{/if}