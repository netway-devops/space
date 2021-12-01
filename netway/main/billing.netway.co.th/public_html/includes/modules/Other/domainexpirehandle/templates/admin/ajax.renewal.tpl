{foreach from=$aDatas item=aData}
<tr>
    <td>{$aData.domain_log_id}</td>
    <td>{$aData.log_date}</td>
    <td><a href="?cmd=domains&action=edit&id={$aData.domain_id}" target="_blank">{$aData.name}</a></td>
    <td>{$aData.module}</td>
    <td>{$aData.start_date_invoice_item}</td>
    <td>
        
        {if $aData.is_invoice_expire_date}
        <span title="เนื่องจากหาไม่ได้จาก domain log เลยไปเอาค่าจาก invoice item แทน">{$aData.end_date_domain_log}*</span>
        {else}
        {$aData.end_date_domain_log}
        {/if}
    </td>
    <td>{$aData.year}</td>
    <td><a href="?cmd=invoices&action=edit&id={$aData.invoice_id}" target="_blank">{$aData.invoice_id}</a></td>
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