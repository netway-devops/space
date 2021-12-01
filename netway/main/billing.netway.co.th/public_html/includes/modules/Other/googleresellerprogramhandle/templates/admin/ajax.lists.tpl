{foreach from=$aDatas item=aData}
<tr valign="top">
    <td>{$aData.customerDomain} <br /> {$aData.customerId} {$aData.subscriptionId}</td>
    <td>{$aData.numberOfSeats}</td>
    <td>{$aData.skuId}</td>
    <td>{$aData.skuName}</td>
    <td>{$aData.planName}</td>
    <td>{$aData.endTime|substr:0:10|date_format}</td>
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

