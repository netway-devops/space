{include file="$tplPath/admin/header.tpl"}

<table cellpadding="2" cellspacing="2">
{foreach from=$aDatas item="aData" key="k"}
<tr>
    <td><a href="index.php?cmd=clients&action=show&id={$k}" target="_blank">#{$k}</a></td>
    <td><a href="{$aData.url}" target="_blank">{$aData.id}</a></td>
    <td>{$aData.name}</td>
    <td>{$aData.organization_fields.main_client_id}</td>
    <td>{$aData.updated_at}</td>
</tr>
{/foreach}
</table>

<script language="JavaScript">
{literal}
$(document).ready( function () {
    
    setTimeout( function () {
        //location.reload();
    },2000);
    
});
{/literal}
</script>


{include file="$tplPath/admin/footer.tpl"}
