{foreach from=$aDatas item=aData}
{if $aData.cId == 'cId'}{continue}{/if}
<tr>
    <td><a href="?cmd=clients&action=show&id={$aData.cId}" target="_blank">{$aData.cId}</a></td>
    <td>{$aData.Firstname}</td>
    <td>{$aData.Lastname}</td>
    <td>{$aData.Email}</td>
    <td>&nbsp;</td>
</tr>
{/foreach}
<script type="text/javascript">
sorterUpdate({$sorterlow},{$sorterhigh},{$sorterrecords});
{literal}
$(document).ready(function() {
    $('#totalpages').val({/literal}{$totalpages}{literal});
    $("div.pagination").pagination($("#totalpages").val());
});
{/literal}
</script>