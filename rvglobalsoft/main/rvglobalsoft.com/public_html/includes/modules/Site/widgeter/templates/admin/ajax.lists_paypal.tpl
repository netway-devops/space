{foreach from=$aDatas item=aData key=k}
{if $aData.id == 'id'}{continue}{/if}
<tr>
    <td><a href="?cmd=paypalsubscriptionlog&action=detail&transactionId={$aData.transaction_id}" target="_blank">{$aData.transaction_id}</a></td>
    <td>{$aData.transaction_initiation_date}</td>
    <td>{$aData.transaction_amount}</td>
    <td>{$aData.paypal_account}</td>
    <td>{$aData.transaction_subject}</td>
    <td>
        <div data-transaction-id="{$aData.transaction_id}" style="display:none;"><img src="ajax-loading2.gif"><span>กำลังตรวจสอบ</span></div>
    </td>
    <td>
        <a href="?cmd=paypalhandle&action=reCheck&transactionId={$aData.transaction_id}" data-transaction-id="{$aData.transaction_id}" class="reCheckTransaction" >ตรวจสอบ</a>
        --
        <a href="?cmd=paypalhandle&action=reCheck&transactionId={$aData.transaction_id}" data-transaction-id="{$aData.transaction_id}&skip=1" class="reCheckTransaction" >ข้าม</a>
    </td>
</tr>
{/foreach}
<script type="text/javascript">
sorterUpdate({$sorterlow},{$sorterhigh},{$sorterrecords});
{literal}
$(document).ready(function() {
    $('#totalpages').val({/literal}{$totalpages}{literal});
	$("div.pagination").pagination($("#totalpages").val());	

    $('.reCheckTransaction').each( function () {
        $(this).click( function () {
            var tranId  = $(this).attr('data-transaction-id');
            $('div[data-transaction-id="'+ tranId +'"]').show();

            $.getJSON($(this).attr('href'), function (data) {
                var oData   = $.parseJSON(data.data);
                $('div[data-transaction-id="'+ tranId +'"]').html(oData.message);
            });

            return false;
        });
    });

});
{/literal}
</script>