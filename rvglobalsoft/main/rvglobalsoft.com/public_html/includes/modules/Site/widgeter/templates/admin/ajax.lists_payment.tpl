{foreach from=$aDatas item=aData key=k}
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
	{elseif $widgetName eq 'widgetPaypalSub'}
	<td><a href="?cmd=invoices#{$aData.invoice}" target="_blank">{$aData.invoice}</a></td>
	{/if}
   
    <td>{$aData.date}</td>
    <td>
        {if $widgetName == 'widgetPaypalSubLog'}
        <a href="?cmd=paypalsubscriptionlog&action=detail&transactionId={$aData.transaction_id}" data-transaction-id="{$aData.transaction_id}" class="{if $k < 5} linkVerify {/if}" target="_blank">ตรวจสอบ</a>
        {else}
        {$aData.status}
        {/if}
    </td>
</tr>
{/foreach}
<script type="text/javascript">
sorterUpdate({$sorterlow},{$sorterhigh},{$sorterrecords});
{literal}
$(document).ready(function() {
    $('#totalpages').val({/literal}{$totalpages}{literal});
	$("div.pagination").pagination($("#totalpages").val());
	
    $('.linkVerify').each( function () {
        $(this).parent().append('<span>กำลังตรวจสอบ</span>');
        $.getJSON($(this).attr('href')+'&verify=1', function (data) {
            var oData   = $.parseJSON(data.data);
            if (oData.hasOwnProperty('is_manual_verify')) {
                $('a[data-transaction-id="'+ oData.transaction_id +'"]').parent().find('span').remove();
                if (oData.is_manual_verify == 1) {
                    $('a[data-transaction-id="'+ oData.transaction_id +'"]').parent().append('ตรวจสอบแล้ว');
                    $('a[data-transaction-id="'+ oData.transaction_id +'"]').hide();
                }
            }
        });
    });
	
});
{/literal}
</script>