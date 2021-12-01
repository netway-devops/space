<script type="text/javascript">
{literal}

$(document).ready(function () {
    $('#addReplyTemplate, .editReplyTemplate').click(function () {
        var fbUrl   = $(this).prop('href');
        $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    });
    
});

{/literal}
</script>

<div style="display: block;">
<div style="float: left;"><h3>Reply template</h3></div>
<div style="float: right;"><a id="addReplyTemplate" href="?cmd=servicecataloghandle&action=addReplyTemplate{if $kbId}&kbId={$kbId}{else}&serviceCatalogId={$serviceCatalogId}{/if}" style="margin-right: 30px;font-weight:bold;" class="menuitm"><span class="addsth">Add Reply Template</span></a></div>
<div class="mmfeatured">
<div class="mmfeatured-inner">
    
    <table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
    <tbody>
    {foreach from=$aReplies item="aReply"}
        <tr>
            <td width="60%"><a name="rt{$aReply.id}"></a><a href="#rt{$aReply.id}">{$aReply.subject}</a></td>
            <td><a href="">suggestion (0)</a></td>
            <td class="mrow1">
                <a href="?cmd=servicecataloghandle&action=editReplyTemplate&id={$aReply.id}{if $kbId}&kbId={$kbId}{else}&serviceCatalogId={$serviceCatalogId}{/if}" class="editReplyTemplate"><span style="color:green;">Edit</span></a>
                <a href="?cmd=servicecataloghandle&action=removeReplyTemplate&id={$aReply.id}{if $kbId}&kbId={$kbId}{else}&serviceCatalogId={$serviceCatalogId}{/if}" onclick="return confirm('ยืนยันการลบ?');"><span style="color:red;">Delete</span></a>
            </td>
        </tr>
    {/foreach}
    <tr>
        <td colspan="3">ลาก mouse highlight reply template subject นำไปวางในเนื้อหาฝั่งซ้ายมือได้เลย โดยไม่ต้องพิมพ์</td>
    </tr>
    </tbody>
    </table>
    
</div>
</div>
</div>

