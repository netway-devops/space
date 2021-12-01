{foreach from=$aDatas item=aData}
{if $aData.id == 'id'}{continue}{/if}
<tr>
    <td>{$aData.date}</td>
    <td><a href="?cmd=accounts&action=edit&id={$aData.account_id}" target="_blank">{$aData.account_id}</a></td>
    <td><a href="?cmd=invoices&action=edit&id={$aData.invoice_id}" target="_blank">{$aData.invoice_id}</a></td>
    <td><a href="?cmd=transactions&action=edit&id={$aData.tid}" target="_blank">{$aData.tid}</a></td>
    <td><a href="https://www.paypal.com/activity/payment/{$aData.trans_id}" target="_blank">{$aData.trans_id}</a></td>
    <td><a href="https://www.paypal.com/billing/subscriptions/{$aData.paypal_reference_id}" target="_blank">{$aData.paypal_reference_id}</a></td>
    <td>{$aData.paypal_account}</td>
	<td>
	    <a href="?cmd=paypalhandle&action=suspendsubscription&accountLogId={$aData.id}" class="linkVerify new_control greenbtn">ดำเนินการแล้ว</a>
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
        $(this).click( function () {
            if (confirm('ยืนยัน ?')) {
                var url     = $(this).attr('href');
                $.post(url, {}, function () {
                    document.location = '?cmd=widgeter&action=lists&widget=widgetSuspendPaypalSubscription';
                });
            }
            return false;
        });
    });
	
});
{/literal}
</script>