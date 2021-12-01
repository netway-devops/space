{foreach from=$aDatas item=aData}
<tr valign="top">
    <td><a href="https://netway.co.th/7944web/index.php?cmd=accounts&action=edit&id={$aData.id}" target="_blank">{$aData.id}</a></td>
    <td>{$aData.domain}</td>
    <td>{$aData.status}</td>
    <td>{$aData.seat}</td>
    <td>{$aData.price|number_format:2:".":","}</td>
    <td>{$aData.billingcycle}</td>
    <td>{$aData.total|number_format:2:".":","}</td>
    <td>{$aData.recurring_new|number_format:2:".":","}</td>
    <td>{$aData.next_due|substr:0:10|date_format}</td>
    <td>{$aData.expiry_date|substr:0:10|date_format}</td>
    <td>{$aData.name}</td>
    <td>{$aData.sync_date|substr:0:10|date_format}</td>
</tr>
{/foreach}

{literal}
<script type="text/javascript">
sorterUpdate({$sorterlow},{$sorterhigh},{$sorterrecords});
$(document).ready(function() {
    $('#totalpages').val({/literal}{$totalpages}{literal});
	$("div.pagination").pagination($("#totalpages").val());
});
</script>
{/literal}
