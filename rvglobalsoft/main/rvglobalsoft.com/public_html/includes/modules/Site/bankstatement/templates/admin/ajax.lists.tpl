{foreach from=$aTransactions item=aTransaction}
<tr>
    <td><a href="?cmd=invoices&action=edit&id={$aTransaction.invoice_id}" target="_blank">{if $aTransaction.paid_id != ''}{$aTransaction.paid_id}{else}{$aTransaction.invoice_id}{/if}</a></td>
    <td>{$aBankTransfer[$aTransaction.module]}</td>
    <td>{$aTransaction.dateFormated}</td>
    <td align="right">{$aTransaction.amount|number_format:2:'.':','} บาท</td>
</tr>
{/foreach}
<script type="text/javascript">
sorterUpdate({$sorterlow},{$sorterhigh},{$sorterrecords});
{literal}
$(document).ready(function() {
    $('#totalpages').val({/literal}{$totalpages}{literal});
    $("div.pagination").pagination($("#totalpages").val())
});
{/literal}
</script>