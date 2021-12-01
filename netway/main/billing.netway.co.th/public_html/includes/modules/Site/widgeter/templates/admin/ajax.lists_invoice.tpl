{foreach from=$aDatas item=aData}
{if $aData.id == 'id'}{continue}{/if}
<tr>
    <td><a href="?cmd=invoices&action=edit&id={$aData.id}" target="_blank">{$aData.id}</a></td>
    {if isset($aData.date)}
    <td>{$aData.date|date_format:'%d %b %Y'}</td>
    {/if}
    {if isset($aData.invoice_number)}
    <td>{$aData.invoice_number}</td>
    {/if}
    {if isset($aData.description)}
    <td>{$aData.description}</td>
    {/if}
    {if isset($aData.datepaid)}
    <td>{$aData.datepaid|date_format:'%d %b %Y'}</td>
    {/if}
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