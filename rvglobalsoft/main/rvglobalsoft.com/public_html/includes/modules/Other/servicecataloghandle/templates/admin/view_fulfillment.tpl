<script type="text/javascript">
{literal}

$(document).ready(function () {
    $('.addTaskToList, .editFulfillmentTask, .sortProcessGroup, .sortProcess').click(function () {
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
    
    $('.dla').each( function (i) {
        var t       = 0;
        var id      = $(this).attr('id');
        $('.ola_'+ id).each( function () {
            t       = t + parseInt($(this).text());
        });
        $(this).text(t + ' นาที');
    });
    
});

function addProcessGroup ()
{
    $.post('?cmd=servicecataloghandle&action=createProcessGroup', {
        serviceCatalogId    : {/literal}{$serviceCatalogId}{literal},
        name        : $('#processGroupName').val()
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
            <td>
                <label>ชื่อหมวด</label>
            </td>
            <td>
                <input type="text" id="processGroupName" name="processGroupName" value="" size="40" style="width: 90%; line-height: 1.4em;" />
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
            <td><div tabindex="{$aGroup.id}" class="editGroupName" style="border-bottom: 1px dotted #F00107;">{$aGroup.name}</div></td>
            <td width="150">DLA: <span id="{$aGroup.id}" class="dla">{$aGroup.dla_in_minute}</span></td>
            <td width="100" class="mrow1">
                <a href="?cmd=servicecataloghandle&action=addTaskToList&serviceCatalogId={$serviceCatalogId}&groupId={$aGroup.id}" class="addTaskToList menuitm"><span class="addsth"><small>Activity</small></span></a>
                <a title="Move" style="margin-top: 2px" href="?cmd=servicecataloghandle&action=sortProcess&serviceCatalogId={$serviceCatalogId}&groupId={$aGroup.id}" class="menuitm sortProcess  {if ! $aProcess[$aGroup.id]|@count} disabled {/if}"><span class="movesth" ></span></a>
            	<a style="margin-top: 2px" class="menuitm" title="Duplicate" onclick="duplicate_fulfillment_process_group({$aGroup.id});"><span class="duplicatesth"></span></a>
            	<a style="margin-top: 2px" class="menuitm" title="Delete" onclick="delete_fulfillment_process_group({$aGroup.id});"><span class="delsth"></span></a>
            </td>
        </tr>
        {assign var=tempTeam value=''}
        {foreach from=$aProcess[$aGroup.id] item="aTeam"}
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
                <div>OLA: <span class="ola_{$aGroup.id}">{$aTask.ola_in_minute}</span></div>
                <div>Assign: {$aTask.firstname}</div>
            </td>
            <td class="mrow1">
                <a href="?cmd=servicecataloghandle&action=editFulfillmentTask&serviceCatalogId={$serviceCatalogId}&id={$aTask.id}" class="editFulfillmentTask"><span style="color:green;">Edit</span></a>
                <a href="?cmd=servicecataloghandle&action=removeFulfillmentTask&serviceCatalogId={$serviceCatalogId}&id={$aTask.id}" onclick="return confirm('ยืนยันการลบ?');"><span style="color:red;">Delete</span></a>
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

