{include file="$tplPath/admin/header.tpl"}

<table cellpadding="2" cellspacing="2">
{foreach from=$aDatas item="aData" key="k"}
<tr>
    <td><a href="index.php?cmd=clients&action=show&id={$k}">#{$k}</a></td>
    <td>{$aData.json}</td>
    <td>{$aData.organization_id}</td>
    <td>{$aData.name}</td>
    <td>{$aData.created_at}</td>
</tr>
{/foreach}
</table>

<script language="JavaScript">
{literal}
$(document).ready( function () {
    
    setTimeout( function () {
        location.reload();
    },2000);
    
});
{/literal}
</script>


{include file="$tplPath/admin/footer.tpl"}
