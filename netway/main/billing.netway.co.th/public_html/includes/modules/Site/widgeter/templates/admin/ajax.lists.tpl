{foreach from=$aDatas item=aData}
{if $widgetNow == 'widgetManualDuedateError'}
{if $aData.id == 'id'}{continue}{/if}
{assign var='row_domain' value=$aData.domain|strpos:"_"}
{if $aData.domain|substr:$row_domain+1 != 'isdomain'}
{literal}
<script type="text/javascript">
$(document).ready(function () {
    $( ".update{/literal}{$aData.id}{literal}" ).hide();
    $.post('?cmd=getaccountexpirydatehandle&action=updateaccountexpirydate&id={/literal}{$aData.id}{literal}',function(data){
    //alert("Data: " + data + "\nStatus: " + status);
    if (data.indexOf("<!-- {") == 0) {
        var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
        if (codes.INFO.length > 0 && codes.INFO == 'isupdate') {
            $( ".update{/literal}{$aData.id}{literal}" ).show();
        }
    }
  });
});
</script>
{/literal}
{/if}
<tr>
    <td colspan="3"><a href="?cmd={if $aData.domain|substr:$row_domain+1 == 'isdomain'}domains{else}accounts{/if}&action=edit&id={$aData.id}" data-type="{if $aData.domain|substr:$row_domain+1 == 'isdomain'}domains{else}accounts{/if}" data-id="{$aData.id}" class="item-list" target="_blank">{if $aData.domain == ''}. . .{else}{if $aData.domain|substr:$row_domain+1 == 'isdomain'}{$aData.domain|substr:0:$row_domain}{else}{$aData.domain}{/if}{/if}</a></td>
    <td colspan="3">{if $aData.domain|substr:$row_domain+1 == 'isdomain'}Domain{else}Service{/if}</td>
    <td colspan="2">{$aData.next_due}</td>
    <td colspan="2">{$aData.expiry_date}</td>
    <td colspan="2">{$aData.next_invoice_date}</td>
    <td colspan="2">{if $aData.domain|substr:$row_domain+1 != 'isdomain'}<div class="update{$aData.id}"><font color="green">มีการอัพเดทข้อมูล</font></div>{/if}</td>
</tr>
{elseif $widgetNow == 'widgetListDueIn30Days'}
{if $aData.id == 'id'}{continue}{/if}
<tr>
    <td colspan="3"><a href="?cmd=invoices&action=edit&id={$aData.id}" target="_blank">{$aData.id}</a></td>
    <td colspan="2">{$aData.duedate|date_format:'%d %b %Y'}</td>
    <td ><a href="?cmd=accounts&action=edit&id={$aData.item_id}" target="_blank">{$aData.description}</a></td>
</tr>
{elseif $widgetNow == 'widgetListRecurringError'}
{if $aData.id == 'id'}{continue}{/if}
<tr>
    <td colspan="3"><a href="?cmd=accounts&action=edit&id={$aData.id}&isValidRecurringShow=1" target="_blank">{$aData.id}</a></td>
    <td colspan="2"><a href="?cmd=accounts&action=edit&id={$aData.id}&isValidRecurringShow=1" target="_blank">{$aData.name}</a></td>
    <td ><a href="?cmd=accounts&action=edit&id={$aData.id}&isValidRecurringShow=1" target="_blank">{$aData.cname}</a></td>
</tr>
{else}
{if $aData.id == 'id'}{continue}{/if}
<tr>
    <td><a href="?cmd={$aData.serviceType}&action=edit&id={$aData.id}" target="_blank">{$aData.id}</a></td>
    <td>{$aData.serviceType}</td>
    <td><a href="?cmd={$aData.serviceType}&action=edit&id={$aData.id}" target="_blank">{$aData.name}</a></td>
    <td>{$aData.nextDue}</td>
    <td>{$aData.expiryDate}</td>
    <td>{$aData.status}</td>
	<td>&nbsp;</td>
</tr>
{/if}
{/foreach}

{literal}
<script type="text/javascript">
sorterUpdate({$sorterlow},{$sorterhigh},{$sorterrecords});
$(document).ready(function() {
    $('#totalpages').val({/literal}{$totalpages}{literal});
	$("div.pagination").pagination($("#totalpages").val());
});
{/literal}
</script>

{if $widgetNow == 'widgetManualDuedateError'}
<script language="JavaScript">
{literal}
    $('.item-list').each( function (i) {
        var $this       = $(this);
        var dataType    = $(this).attr('data-type');
        var dataId      = $(this).attr('data-id');
        $this.parent().append(' <span class="loading" style="color:blue;">(กำลังตรวจสอบ...)</span>');
        $.getJSON('?cmd=widgeter&action=checkinvoice&type='+ dataType +'&id='+ dataId, function (data) {
            $this.parent().find('span').remove();
            if (data.status == 'Cancelled') {
                $this.parent().append(' <span style="color:red;">(Invoice: Cancelled)</span>');
            }
        });
        
    });
{/literal}
</script>
{/if}