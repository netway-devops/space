

<div id="replyTemplateContent">
    
    <div style="width: 100%; position: relative;">
        <label style="display:block; padding:2px; position: absolute; top: 0px; right: 80px;"><a href="#" onclick="showReplyMessage(1); return false;">ขยายทั้งหมด</a></label>
        <label style="display:block; padding:2px; position: absolute; top: 0px; right: 0px;"><a href="#" onclick="showReplyMessage(0); return false;">ย่อทั้งหมด</a></label>
    </div>
    
    <h2 id="tocReplyTpl" style="border-bottom: 1px solid #AAAAAA;">Reply template</h2>
    
    {if $aReplies|@count}
    <ul style="margin:1px; padding:1px;">
    {foreach from=$aReplies item="aReply"}
    <li style=" display: block; border-bottom: 1px dotted #EFEFEF;">
        
        <div style="width: 100%; position: relative;">
            <label style="display:block; padding:2px; position: absolute; top: 0px; right: 0px;"><a href="">Suggestion (0)</a></label>
        </div>
        <a name="rt{$aReply.id}{$aReply.is_global}"></a>
        <h3 style=" background-color: #EEEEEE; cursor: pointer; padding-right: 100px; font-weight: normal;" onclick="$(this).next().toggle();">
            <span>{$aReply.subject}</span>
            {if $aReply.is_global}<label style="background-color: #EFEFEF; font-size: 0.8em; font-weight: normal;">Global</label>{/if}
        </h3>
        <p class="replyMessage" title="#rt{$aReply.id}{$aReply.is_global}">
            <span id="rt{$aReply.id}_msg">{$aReply.message|nl2br}</span>
            <br /><br />
            <a href="javascript:void(0);" onclick="{literal}CKEDITOR.instances.replyarea.setData($('#rt{/literal}{$aReply.id}{literal}_msg').html());{/literal}" class="menuitm menul"> &lt; นำไปใช้ตอบ ticket </a>
        </p>
    </li>
    {/foreach}
    </ul>
    {else}
    <p align="center" style="padding:15px; color: gray;">--- ไม่พบข้อมูล reply template ที่เกี่ยวข้อง ---</p>
    {/if}
    
</div>


<script language="JavaScript">

{literal}

$(document).ready(function () {
    
    $('.replyMessage').hide();
    
    $('a[href*="#rt"]').each( function () {
        var url     = $(this).attr('href');
        var n       = url.indexOf('#rt');
        if (n > -1) {
            var res     = url.substring(n);
            var res2    = url.substring(n+1);
            $(this).attr('href', res);
            $(this).click( function () {
                $.scrollTo($('a[name="'+res2+'"]'),1000);
                $('.replyMessage').hide();
                $('p[title="'+res+'"]').fadeIn('slow');
                return false;
            });
        }
    });
    
    $('#replyTemplateArea').empty();
    $('#replyTemplateContent').detach().appendTo('#replyTemplateArea');
    
});

function showReplyMessage (status)
{
    if (status) {
        $('.replyMessage').show();
    } else {
        $('.replyMessage').hide();
    }
}

{/literal}
</script>

