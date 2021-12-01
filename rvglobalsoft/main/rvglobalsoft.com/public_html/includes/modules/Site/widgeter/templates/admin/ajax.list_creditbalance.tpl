{foreach from=$aDatas item=aData}
{if $aData.aId == 'aId'}{continue}{/if}
<tr>
    <td><a href="?cmd=accounts&action=edit&id={$aData.aId}" target="_blank">{$aData.aId}</a></td>
    <td><a href="?cmd=invoices#{$aData.invoiceId}" target="_blank">{$aData.invoiceId}</a></td>
    <td>{$aData.status}</td>
    <td>{$aData.invoicedate}</td>
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