{foreach from=$aDatas item=aData}
{if $aData.transaction_id == 'transaction_id'}{continue}{/if}
<tr>
    <td>{$aData.transaction_id}</td>
    <td>{$aData.transaction_subject}</td>
    <td>{$aData.paypal_reference_id}</td>
    <td>{$aData.transaction_initiation_date}</td>
    <td>{$aData.transaction_amount}</td>
	<td>
	    <a href="?cmd=paypalhandle&action=skipVerify&transactionId={$aData.transaction_id}" class="linkVerify">ไม่สนใจ</a>
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
                    document.reload();
                });
            }
            return false;
        });
    });
	
});
{/literal}
</script>