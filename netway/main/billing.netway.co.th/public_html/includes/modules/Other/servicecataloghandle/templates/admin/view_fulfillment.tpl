<script type="text/javascript">
{literal}

$(document).ready(function () {
    $('.addTaskToList, .editFulfillmentTask, .sortProcessGroup, .sortProcess, .editTemplate').click(function () {
        var fbUrl   = $(this).prop('href');
        $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    });
    
    $('#addFulfillmentGroup').click(function () {
        $('#processGroup').toggle();
        return false;
    });
    
    $('.editGroupName').editable( function (value, settings) {
            $.post('?cmd=servicecataloghandle&action=updateProcessGroup', {
                serviceCatalogId    : {/literal}{$serviceCatalogId}{literal},
                groupId     : $(this).prop('tabindex'),
                name        : value
                }, function (a) {
                parse_response(a);
            });
            return value;
        }, {
        type        : 'text',
        cancel      : 'Cancel',
        submit      : 'Update',
        tooltip     : 'คลิกเพื่อแก้ไขชื่อ Fulfillment Group'
    });
    
    $('.slaTagEdit').each( function () {
        $(this).change( function () {
            $.post('?cmd=servicecataloghandle&action=updateProcessGroup', {
                serviceCatalogId    : {/literal}{$serviceCatalogId}{literal},
                groupId     : $(this).prop('tabindex'),
                tag         : $(this).val()
                }, function (a) {
                parse_response(a);
            });
        });
    });
    
    /*
    $('.dla').each( function (i) {
        var t       = 0;
        var id      = $(this).attr('id');
        $('.ola_'+ id).each( function () {
            t       = t + parseInt($(this).text());
        });
        $(this).text(t + ' นาที');
    });
    */
   
    $('#fromProcessGroupId').select2();
});

function addProcessGroup ()
{
    $.post('?cmd=servicecataloghandle&action=createProcessGroup', {
        serviceCatalogId    : {/literal}{$serviceCatalogId}{literal},
        name        : $('#processGroupName').val(),
        from        : $('#fromProcessGroupId').val(),
        tag        : $('#slaTag').val()
        }, function (a) {
        parse_response(a);
        window.location.reload(true);
    });
    
    return false;
}

function duplicate_fulfillment_process_group(id){
	
	if(confirm('ต้องการจะ Duplicate Activity Group นี้ใช่หรือไม่?')){
		$.post('?cmd=servicecataloghandle&action=duplicateFulfillmentProcessGroup', {
	        processGroupId    	: id,
	        serviceCatalogId    : {/literal}{$serviceCatalogId}{literal}
	        }, function (a) {
	        parse_response(a);
	        window.location.reload(true);
	    });
   }
   return false;
	
}

function delete_fulfillment_process_group(id){
	
	if(confirm('ต้องการจะ Delete Activity Group นี้ใช่หรือไม่?')){
		$.post('?cmd=servicecataloghandle&action=deleteFulfillmentProcessGroup', {
	        processGroupId    	: id,
	        serviceCatalogId    : {/literal}{$serviceCatalogId}{literal}
	        }, function (a) {
	        parse_response(a);
	        window.location.reload(true);
	    });
   	}
    return false;
	
}

{/literal}
</script>


<div style="display: block;">
<div style="float: left;"><h3>Request fulfillment process</h3></div>
<div style="float: right;">
    <a id="addFulfillmentGroup" href="#" style="font-weight:bold;" class="menuitm"><span class="addsth">Group</span></a>
    <a href="?cmd=servicecataloghandle&action=sortProcessGroup&serviceCatalogId={$serviceCatalogId}" class="menuitm menuf sortProcessGroup {if ! $aProcessGroup|@count} disabled {/if}"><span class="movesth" title="move"></span>&nbsp;เรียง</a>
</div>

<div id="processGroup" class="mmfeatured" style="display: none;">
<div class="mmfeatured-inner">

    <table width="100%" cellspacing="0" cellpadding="0">
    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
            <td width="100">
                <label>SLA tag</label>
            </td>
            <td>
                <select name="sla_tag" id="slaTag">
                    <option value="fulfillment_1hr">fulfillment_1hr</option>
                    <option value="fulfillment_2hr">fulfillment_2hr</option>
                    <option value="fulfillment_4hr">fulfillment_4hr</option>
                    <option value="fulfillment_8hr">fulfillment_8hr</option>
                    <option value="fulfillment_24hr">fulfillment_24hr</option>
                    <option value="fulfillment_48hr">fulfillment_48hr</option>
                </select>
            </td>
        </tr>
        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
            <td width="100">
                <label>ชื่อหมวด</label>
            </td>
            <td>
                <input type="text" id="processGroupName" name="processGroupName" value="" size="40" style="width: 90%; line-height: 1.4em;" />
            </td>
        </tr>
        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
            <td>
                <label>&nbsp;</label>
            </td>
            <td colspan="2">
                <label>หรือเลือกใช้ fulfillment process group ที่มีอยู่แล้ว</label>
            </td>
        </tr>
        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
            <td>
                <label>&nbsp;</label>
            </td>
            <td>
                <select id="fromProcessGroupId" name="fromProcessGroupId" style="width: 90%;">
                <option value="">เลือก Process Group --- Category --- From Service Catalog</option>
                {foreach from=$aOtherProcessGroup item=arr}
                <option value="{$arr.id}">{$arr.title}  ---  {$arr.name}</option>
                {/foreach}
                </select>
            </td>
        </tr>
    <tfoot>
        <tr>
            <td><br ><br ></td>
            <td>
                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return addProcessGroup()"><span>Add</span></a></span>
            </td>
        </tr>
    </tfoot>
    </table>
    
</div>
</div>

<div class="mmfeatured">
<div class="mmfeatured-inner">
    
    
    <table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
    <tbody>
    {foreach from=$aProcessGroup item="aGroup"}
        <tr>
            <td><div tabindex="{$aGroup.id}" {if ! $aGroup.parent_id} class="editGroupName" style="border-bottom: 1px dotted #F00107;" {/if} >{$aGroup.name}</div></td>
            <td width="150">
                <!-- DLA: <span id="{$aGroup.id}" class="dla">{$aGroup.dla_in_minute}</span> -->
                SLA: 
                <select tabindex="{$aGroup.id}" name="sla_tag" class="slaTagEdit">
                    <option value="">---</option>
                    <option value="fulfillment_1hr" {if $aGroup.sla_tag == 'fulfillment_1hr'} selected="selected" {/if}>fulfillment_1hr</option>
                    <option value="fulfillment_2hr" {if $aGroup.sla_tag == 'fulfillment_2hr'} selected="selected" {/if}>fulfillment_2hr</option>
                    <option value="fulfillment_4hr" {if $aGroup.sla_tag == 'fulfillment_4hr'} selected="selected" {/if}>fulfillment_4hr</option>
                    <option value="fulfillment_8hr" {if $aGroup.sla_tag == 'fulfillment_8hr'} selected="selected" {/if}>fulfillment_8hr</option>
                    <option value="fulfillment_24hr" {if $aGroup.sla_tag == 'fulfillment_24hr'} selected="selected" {/if}>fulfillment_24hr</option>
                    <option value="fulfillment_48hr" {if $aGroup.sla_tag == 'fulfillment_48hr'} selected="selected" {/if}>fulfillment_48hr</option>
                </select>
            </td>
            <td width="100" class="mrow1">
                {if $aGroup.parent_id}
                <a href="?cmd=servicecataloghandle&action=view&id={$aGroup.parentServiceCatalogId}" target="_blank">ขอใช้ร่วมกับ #{$aGroup.parentServiceCatalogId}</a>
                {else}
                <a href="?cmd=servicecataloghandle&action=editProcessTemplate&serviceCatalogId={$serviceCatalogId}&processGroupId={$aGroup.id}" style="margin-top: 2px" class="menuitm editTemplate" title="Template สำหรับให้ข้อมูลเกี่ยวกับ Process นี้"><span class="editsth"><small>Template</small></span></a>
                <a href="?cmd=servicecataloghandle&action=addTaskToList&serviceCatalogId={$serviceCatalogId}&groupId={$aGroup.id}" class="addTaskToList menuitm"><span class="addsth"><small>Activity</small></span></a>
                <a title="Move" style="margin-top: 2px" href="?cmd=servicecataloghandle&action=sortProcess&serviceCatalogId={$serviceCatalogId}&groupId={$aGroup.id}" class="menuitm sortProcess  {if ! $aProcess[$aGroup.id]|@count} disabled {/if}"><span class="movesth" ></span></a>
            	<a style="margin-top: 2px" class="menuitm" title="Duplicate" onclick="duplicate_fulfillment_process_group({$aGroup.id});"><span class="duplicatesth"></span></a>
            	{/if}
            	<a style="margin-top: 2px" class="menuitm" title="Delete" onclick="delete_fulfillment_process_group({$aGroup.id});"><span class="delsth"></span></a>
            </td>
        </tr>
        {if $aGroup.aShareProcess|@count}
        <tr>
            <td colspan="3" style="background-color: #EFEFEF;">
                ถูกนำไปใช้ที่ 
                {foreach from=$aGroup.aShareProcess item=arr}
                <a href="?cmd=servicecataloghandle&action=view&id={$arr.sc_id}" target="_blank">#{$arr.sc_id}</a> &nbsp; 
                {/foreach}
                ด้วย
            </td>
        </tr>
        {/if}
        {if $aGroup.parent_id}
        {assign var=processGroupId value=$aGroup.parent_id}
        {else}
        {assign var=processGroupId value=$aGroup.id}
        {/if}
        {assign var=tempTeam value=''}
        {foreach from=$aProcess[$processGroupId] item="aTeam"}
        {if $tempTeam != $aTeam.team}
			{assign var=tempTeam value=$aTeam.team}
        <tr>
            <td style="padding-left: 20px;"><strong>{$aTeam.team}</strong></td>
            <td>&nbsp;</td>
            <td class="mrow1">
                &nbsp;
            </td>
        </tr>
        {/if}
        {foreach from=$aTeam.task item="aTask"}
        <tr>
            <td style="padding-left: 40px;">
                #{$aTask.id} {$aTask.name}
            </td>
            <td>
                <!--<div>OLA: <span class="ola_{$aGroup.id}">{$aTask.ola_in_minute}</span></div>-->
                <div>Assign: {$aTask.firstname}</div>
            </td>
            <td class="mrow1">
                {if ! $aGroup.parent_id}
                <a href="?cmd=servicecataloghandle&action=editFulfillmentTask&serviceCatalogId={$serviceCatalogId}&id={$aTask.id}" class="editFulfillmentTask"><span style="color:green;">Edit</span></a>
                <a href="?cmd=servicecataloghandle&action=removeFulfillmentTask&serviceCatalogId={$serviceCatalogId}&id={$aTask.id}" onclick="return confirm('ยืนยันการลบ?');"><span style="color:red;">Delete</span></a>
                {/if}
            </td>
        </tr>
        {/foreach}
        {/foreach}
        <tr>
            <td colspan="3" style="height: 10px;"></td>
        </tr>
    {/foreach}
    </tbody>
    </table>
    
    
</div>
</div>
</div>

