
<span class="editbtn_flash">
    <a href="https://app.clickup.com/t/{$clickupTaskId}" target="_blank">{if $clickupTaskId}https://app.clickup.com/t/{$clickupTaskId}{else}none{/if}</a>
    <a href="#" class="editbtn" onclick="$(this).parent().hide().next().show();return false;">Edit</a>
</span>
<span class="editbtn_flash" style="display: none;">
    <input type="text" id="clickupTaskId" name="clickup_task_id" value="{$clickupTaskId}" class="inp" />
    <a href="#" class="editbtn saved" style="visibility: visible" onclick="orderdrafthandle_saveDeal(); return false;">Save</a>

<script language="JavaScript">
var orderDraftId    = {$orderDraftId};
{literal}
function orderdrafthandle_saveDeal () {
    var taskId = $('#clickupTaskId').val() ;
    let aData   = {
        orderDraftId: orderDraftId,
        clickup_task_id: taskId.substring(taskId.indexOf("t/")+2)
    };
    $('#client_tab').addLoader();
    $.post('?cmd=orderdrafthandle&action=updateDealId', aData, function (data) {
        ajax_update('?cmd=orderdrafthandle&action=addDealForm&orderDraftId='+ orderDraftId, false, '#dealForm');
        $('#preloader').remove();
    });
}
{/literal}
</script>

</span>
