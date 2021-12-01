{foreach from=$aDatas item=aData}
{if $aData.id == 'id'}{continue}{/if}
<tr>
    <td><a href="?cmd={$aData.serviceType}&action=edit&id={$aData.id}" target="_blank">{$aData.id}</a></td>
    <td>{$aData.serviceType}</td>
    <td><a href="?cmd={$aData.serviceType}&action=edit&id={$aData.id}" target="_blank">{$aData.name}</a></td>
    <td>{$aData.nextDue}</td>
    <td>{$aData.expiryDate}</td>
    <td>{$aData.status}</td>
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