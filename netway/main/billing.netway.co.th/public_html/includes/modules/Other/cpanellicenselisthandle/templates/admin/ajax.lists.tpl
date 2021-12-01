{foreach from=$aDatas item=aData}
<tr valign="top">
    <td><a href="?cmd=accounts&action=edit&id={$aData.AccountId}" target="_blank">{$aData.AccountId}</a></td>
    <td>{$aData.Domain}</td>
    <td>{$aData.Product}</td>
    <td>{$aData.Item}</td>
    <td>{$aData.ItemGroup}</td>
    <td>{$aData.ipid}</td>
    <td>{$aData.IPAM_IP}</td>
    <td>{$aData.Hostbill_IP}</td>
</tr>
{/foreach}

{literal}
<script type="text/javascript">
sorterUpdate({$sorterlow},{$sorterhigh},{$sorterrecords});
$(document).ready(function() {
    $('#totalpages').val({/literal}{$totalpages}{literal});
	$("div.pagination").pagination($("#totalpages").val());
});
{/literal}
</script>

