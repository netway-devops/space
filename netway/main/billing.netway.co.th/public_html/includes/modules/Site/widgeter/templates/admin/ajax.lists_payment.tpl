{foreach from=$aDatas item=aData}
{if $aData.id == 'id'}{continue}{/if}
<tr>
    <td><a href="?cmd={$aData.serviceType}&filter[output]={$aData.transaction_id}" target="_blank">{$aData.id}</a></td>
    <td>{$aData.paymentModule}</td>
    <td>{$aData.transaction_id}</td>
    <td><a href="?cmd=clients&filter[email]={$aData.email}" target="_blank">{$aData.email}</a></td>
    <td>{$aData.amount}</td>
    
    {if $widgetName eq 'widgetPaypalSubSB'}
	<td>{$aData.cpid}</td>
	<td>{$aData.invoice}</td>
	<td>{$aData.invoice_hb}</td>
	<td><a href="?cmd=clients&filter[email]={$aData.mail_hb}" target="_blank">{$aData.mail_hb}</a></td>
	{else}
	<td><a href="?cmd=invoices#{$aData.invoice}" target="_blank">{$aData.invoice}</a></td>
	{/if}
   
    <td>{$aData.date}</td>
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