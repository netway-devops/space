{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'orders/step_Provision.tpl.php');
{/php}

{if $step.status=='Completed'}
   <span class="info-success">Order has been provisioned</span><br/>
   Please review order items to check that all of them were provisioned correctly

{else}
    To mark this step as Completed accept this order.
    
    {if $steps[2].status == 'Completed'}
    <div class="p5"><b>เจ้าหน้าที่สามารถดำเนินการทำ Provision โดยการกด Accept Order ได้เลย</b></div>
    {/if}
    
{/if}


{if $steps[2].status == 'Completed'}

<div>&nbsp;</div>

<div id="authArea" class="ticketmsg ticketmain">
    <div><p><b>Fulfillment ticket อื่นๆที่เกี่ยวข้อง</b></p></div>
    <div>
        {if $aManualFulfillmentTicket|@count}
        {foreach from=$aManualFulfillmentTicket item=arr}
        <div><span class="customTags"><span class="{if $arr.status == 'Open'} orange {elseif $arr.status == 'Closed'} green {else} red {/if}">{$arr.status}</span></span> &nbsp; <a href="?cmd=tickets&action=view&num={$arr.ticket_number}" style="color:gray" target="_blank">{$arr.subject} <img src="images/icon_new_window.gif" width="10" border="0"></a></div>
        {/foreach}
        {/if}
    </div>
    
    <div>&nbsp;</div>
    
    <div class="p5">
        <select id="fulfillmentProcessGroup" name="fulfillmentProcessGroup">
            <option value="">--- เลือก ---</option>
            {foreach from=$aProcessGroup.aHosting item=arr}
            <optgroup label="{$arr.catname} {$arr.name} {$arr.domain}">
                {foreach from=$arr.aProcessGroup item=arr2}
                <option value="Hosting,{$arr.id},{$arr2.sc_id},{$arr2.id}">
                    {if $arr2.isCreate} [Event create] {/if}
                    {if $arr2.isUpgrade} [Event upgrade] {/if}
                    {$arr2.name}
                </option>
                {/foreach}
            </optgroup>
            {/foreach}
            {foreach from=$aProcessGroup.aDomain item=arr}
            <optgroup label="{$arr.type} {$arr.name}">
                {foreach from=$arr.aProcessGroup item=arr2}
                <option value="Domain,{$arr.id},{$arr2.sc_id},{$arr2.id}">
                    {if $arr2.isCreate} [Event create] {/if}
                    {if $arr2.isRenew} [Event renew] {/if}
                    {if $arr2.isTransfer} [Event tansfer] {/if}
                    {$arr2.name}
                </option>
                {/foreach}
            </optgroup>
            {/foreach}
        </select>
        <a class="new_control greenbtn" href="javascript:void(0);" onclick="return createFulfillmentByProcessId()"><span> สร้าง Fulfillment Ticket จาก Process นี้ </span></a>
    </div>
    
</div>

{literal}
<script language="JavaScript">
function createFulfillmentByProcessId ()
{
    var fulfillmentProcessGroup   = $('#fulfillmentProcessGroup').val();
    if (fulfillmentProcessGroup == '') {
        alert('ยังไม่ได้เลือก Fulfillment Process');
        return false;
    }
    $.post('?cmd=fulfillmenthandle&action=createFulfillmentTicketByProcess', {
        fulfillmentProcessGroup     : fulfillmentProcessGroup,
        orderId     : {/literal}{$details.id}{literal}
        }, function (a) {
        window.location.reload(true);
    });
}
</script>
{/literal}

{/if}