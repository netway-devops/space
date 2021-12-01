{if $aNotic|@count}
<div style="background-color: #FFD8AD; border: 1px dotted red;">
    <div class="right"><a href="javascript:void(0);" onclick="$(this).parent().parent().children().children().show();$(this).hide();">ดูเพิ่มเติม</a></div>
    {foreach from=$aNotic item=arr}
    <div style="border-bottom: 1px dotted #CCCCCC;">
        Pending change @ {$arr.domain} <a href="?cmd=tickets&action=view&num={$arr.ticket_number}" target="_blank">#{$arr.ticket_number} ({$arr.status})</a> : 
        กำหนดการ วันที่ {$arr.start_date} เวลา {$arr.start_date_time} น. - วันที่ {$arr.end_date} เวลา {$arr.end_date_time} น.
        {$arr.title}<br/>
        <span style="display: none;">{$arr.note_for_staff}</span>
    </div>
    {/foreach}
</div>
{/if}