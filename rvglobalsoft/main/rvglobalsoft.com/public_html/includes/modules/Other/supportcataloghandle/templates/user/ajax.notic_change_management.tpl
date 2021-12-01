{if $aNotic|@count}
<div style="background-color: #FCFBD4; border: 1px dotted #000000;">
    <div class="right"><a href="javascript:void(0);" onclick="$(this).parent().parent().children().children().show();$(this).hide();">ดูเพิ่มเติม</a></div>
    {foreach from=$aNotic item=arr}
    <div style="border-bottom: 1px dotted #CCCCCC; color:gray;">
        แจ้งปรับปรุงระบบ: {$arr.domain} @ {$arr.server} กำหนดการ วันที่ {$arr.start_date} เวลา {$arr.start_date_time} น. - วันที่ {$arr.end_date} เวลา {$arr.end_date_time} น. {$arr.title}<br/>
        <span style="display: none;">{$arr.note_for_client}</span>
    </div>
    {/foreach}
</div>
{/if}