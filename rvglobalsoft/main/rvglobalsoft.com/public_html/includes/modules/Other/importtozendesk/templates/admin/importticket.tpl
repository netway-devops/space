{include file="$tplPath/admin/header.tpl"}

<table cellpadding="2" cellspacing="2">
{foreach from=$aDatas item="aData" key="k"}
<tr>
    <td><a href="https://netway.co.th/7944web/index.php?cmd=tickets&action=view&list=all&num={$k}" target="_blank">#{$k}</a></td>
    <td><a href="https://netway.zendesk.com/agent/tickets/{$aData.id}" target="_blank">#{$aData.id}</a></td>
    <td>{$aData.type}</td>
    <td>{$aData.subject}</td>
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
