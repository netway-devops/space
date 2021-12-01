
<div class="stickyChild">
    <div class="mmfeatured-e">
        <a class="menuitm menul" id="goUp" onclick="tocNavigateToReplyInside('#scBottomPosition');" > <span style="color:red"> &#9660; เลื่อนลงไปล่างสุด </span></a>
        <a class="menuitm menul" onclick="expandTicketReply();" style="background-color: #E5E5E5; line-height: 1.2em; float: right;"> <span style="color:red"> - ย่อ / + ขยาย </span> </a>
    </div>
</div>

<div>
    <div id="scTopPosition"></div>
    
    {if isset($aCustomField)}
    <div align="center">
        <table border="0" width="500">
            <tr style="background-color: #FFDA9F;">
                <td align="left" class="light"><strong>{'Custom field'|capitalize}</strong></td>
                <td>
                    <a href="https://docs.google.com/a/rvglobalsoft.com/document/d/1tFEeqrsZlFhQ3WQVhElvnWYNyfgsNTKoukXFO-kBGAA/">คู่มือ SSH</a> &nbsp;
                    <a href="javascript:void(0);" onclick="$('.cf-show').hide();$('.cf-edit').show().parent().parent().parent().css('width', '600px');$(this).hide();$('#cfDelete').hide();$('#cfSave').show();" style="color:blue;">Edit</a>
                    <button onclick="{literal}$.post('?cmd=supporthandle&action=updateCustomfield&ticketId={/literal}{$ticket.id}{literal}', $('input[name^=cf]').serialize(), function(a) { parse_response(a); location.reload(); return false; }){/literal}" id="cfSave" style="display: none;">Save</button>
                    <a id="cfDelete" href="?cmd=supporthandle&action=deleteCustomfield&ticketId={$ticket.id}" onclick="{literal}if(confirm('ยืนยันการลบ?')){$.post($(this).attr('href'), {}, function(a) { parse_response(a); location.reload(); });} return false;{/literal}" style="color:red;">Delete</a>
                </td>
            </tr>
            {foreach from=$aCustomField item=v key=k}
            {assign var="kLang" value="SupportCF"|cat:$k}
            <tr class="cf-show" style="background-color: #FFFFCB;">
                <td align="right"  class="light">{if isset($lang.$kLang)}{$lang.$kLang}{else}{$k}{/if}</td>
                <td align="left">
                    {$v}
                </td>
            </tr>
            <tr class="cf-edit" style="background-color: #EEFFC1; display: none;">
                <td align="right"  class="light">{if isset($lang.$kLang)}{$lang.$kLang}{else}{$k}{/if}</td>
                <td align="left">
                    <input type="text" name="cf[{$k}]" value="{$v}" size="60" />
                </td>
            </tr>
            {/foreach}
            <tr><td colspan="2">&nbsp;</td></tr>
        </table>
    </div>
    {/if}
    
    <div id="scTicketStart"><div class="ticketmsg"></div></div>
    <div><p>&nbsp;</p></div>
    <div id="scTicketReply"></div>
    
    <div id="scBottomPosition"></div>
</div>


<script language="JavaScript">

{literal}
$(document).ready( function () {

    $('#client_tab .slide:eq(0)').detach().appendTo('#scTicketStart div.ticketmsg');
    $('#client_tab').prepend('<div class="slide"></div>');
    
    var isReplied           = $('div[id^="reply_"][class*="ticketmsg"]').length;
    
    if (isReplied) {
        $('div[id^="reply_"][class*="ticketmsg"]').each( function (i) {
            $(this).detach().appendTo('#scTicketReply');
        });
        
    }
    
    $('.stickyChild').Stickyfill();
    
});
{/literal}
</script>
