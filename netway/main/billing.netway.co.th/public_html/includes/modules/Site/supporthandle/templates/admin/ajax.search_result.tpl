<div align="right"><a href="javascript:void(0);" onclick="$(this).parent().parent().hide();" style="color:red;">[x] Hide</a></div>

{if $isCache}
<div class="mmfeatured-yl">
    <p align="center">ข้อมูลนี้ดึงมาจาก cache ถ้าไม่พบข้อมูลที่ต้องการ <a href="javascript:void(0);" onclick="ticketSimpleQuery('-reload-');" style="color: red;">เรียกข้อมูลใหม่</a></p>
</div>
{/if}

{if $nodata || ( ! isset($aTicket.id) && ! $aTickets|@count )}
<div>
    <p align="center">--- ไม่พบข้อมูล ---</p>
</div>
{/if}


{if isset($aTicket.id)}
<div>
    <strong>ค้นหาจากหมายเลข ticket</strong>
    <table width="100%" border="0" class="glike hover">
    <tr>
        <td width="150">{$aTicket.name}</td>
        {if $aTicket.id}
        <td><strong>[ {$aTicket.status} ]</strong> <a href="?cmd=tickets&action=view&num={$aTicket.ticket_number}">#{$aTicket.ticket_number} - {$aTicket.subject}</a></td>
        <td>{$aTicket.email}</td>
        <td>{$aTicket.lastreply}</td>
        {/if}
    </tr>
    </table>
</div>
{/if}


{if $aTickets|@count}
<div>
    <strong>ค้นหาจากเนื้อหา ticket</strong>
    <table width="100%" border="0" class="glike hover">
    {foreach from=$aTickets item="aTicket"}
    <tr>
        <td width="150">{$aTicket.name}</td>
        {if $aTicket.id}
        <td><strong>[ {$aTicket.status} ]</strong> <a href="?cmd=tickets&action=view&num={$aTicket.ticket_number}&internal=1">#{$aTicket.ticket_number} - {$aTicket.subject}</a></td>
        <td>{$aTicket.email}</td>
        <td>{$aTicket.lastreply}</td>
        {/if}
    </tr>
    {/foreach}
    </table>
</div>
{/if}