<div id="formcontainer">
    <div id="formloader">
        
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="#">Edit</a>
                    <a class="tchoice" href="#">Suggestion</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3>Edit reply template</h3>
                    <p>แก้ไข reply template ให้สามารถใช้งานได้อย่างถูกต้อง ให้ดูด้วยว่ามี Service Catalog / Incident KB ใหนใช้ reply template นี้บ้าง เพราะถ้าแก้ไขแล้วจะกระทบส่วนนั้นๆได้</p>
                    
                    <form id="editReplyTemplateFrom" method="post" action="">
                        {securitytoken}
                        <input type="hidden" name="serviceCatalogId" value="{$serviceCatalogId}" />
                        <input type="hidden" name="kbId" value="{$kbId}" />
                        <input type="hidden" name="id" value="{$aReply.id}" />
                        
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>หัวข้อ</td>
                            <td>
                                <div style="display: block;">หัวข้อเพื่อบอก staff ว่า reply template นี้เกี่ยวกับอะไร</div>
                                <input type="text" id="subject" name="subject" value="{$aReply.subject}" size="40" style="width:90%;" />
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>Message</td>
                            <td>
                                <div style="display: block;">รายละเอียดที่จะส่งให้ลูกค้า</div>
                                <textarea id="message" name="message" rows="10" cols="60" style="width: 90%;">{$aReply.message}</textarea>
                                <script type="text/javascript">
                                {literal}
                                CKEDITOR.replace('message', {toolbar:'Ticket', width:'100%', height:'250px'});
                                CKEDITOR.add;
                                $(document).ready(function () {
                                    CKEDITOR.instances.message.on('blur', function(event) {
                                        updateEditorData(event);
                                    });
                                    CKFinder.setupCKEditor( CKEDITOR.instances.message , '/7944web/templates/default/js/ckfinder' );
                                });
                                function updateEditorData (event)
                                {
                                    var data    = event.editor.getData();
                                    data        = decodeURIComponent(data);
                                    data        = data.replace(/\/\#\.([^\s]+)/, ' ');
                                    $('textarea[name="message"]').val(data);
                                }
                                {/literal}
                                </script>
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>Owner</td>
                            <td>
                                <div style="display: block;">staff ที่เป็นคน create reply template นี้</div>
                                <strong>{$aReply.owner}</strong>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                {if ! $isDisable}
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return updateReplyTemplate()"><span>Update</span></a></span>
                                {else}
                                <span class="bcontainer" ><a class="new_control editbtn disabled" href="#" onclick="return alert('ไม่มีสิทธิ์แก้ไขข้อมูลนี้'); false;"><span>Update</span></a></span>
                                {/if}
                            </td>
                        </tr>
                    </tfoot>
                    </table>
                    </form>
                    
                    <div><p>&nbsp;</p></div>
                    
                    <h3>Service catalog ทีใช้ reply template นี้</h3>
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody id="scUsedReplyTemplate" style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td></td>
                        </tr>
                    </tbody>
                    </table>
                    
                    <div><p>&nbsp;</p></div>
                    
                    <h3>Incident KB ทีใช้ reply template นี้</h3>
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody id="inUsedReplyTemplate" style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td></td>
                        </tr>
                    </tbody>
                    </table>
                    
                    <div><p>&nbsp;</p></div>
                    
                </div>
                
            </td>
        </tr>
        </table>
        
    </div>
    
    <script type="text/javascript">
    {literal}
    
    $('#lefthandmenu').TabbedMenu({elem:'.tabb'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});
    
    $(document).ready( function () {
        
        $.getJSON('?cmd=servicecataloghandle&action=relatedByReplyTemplate&type=ServiceCatalog&serviceCatalogId={/literal}{$serviceCatalogId}{literal}&id={/literal}{$aReply.id}{literal}', function (a) {
            var data        = a.data;
            var oDatas      = $.parseJSON(data);
            
            if (! oDatas.length) {
                $('#scUsedReplyTemplate').append('<tr class="havecontrols" style="border-bottom:solid 1px #ddd;">'
                    + '<td><p align="center">--- ไม่มีข้อมูล ---</p></td>'
                    + '</tr>');
                return;
            }
            
            $.each(oDatas, function (index, oData) {
                $('#scUsedReplyTemplate').append('<tr class="havecontrols" style="border-bottom:solid 1px #ddd;">'
                    + '<td><a href="?cmd=servicecataloghandle&action=view&id='+ oData.id +'" target="_blank">#'+ oData.id +' '+ oData.title +'</a></td>'
                    + '</tr>');
            });
            
        });
        
        
        $.getJSON('?cmd=servicecataloghandle&action=relatedByReplyTemplate&type=IncidentKB&kbId={/literal}{$kbId}{literal}&id={/literal}{$aReply.id}{literal}', function (a) {
            var data        = a.data;
            var oDatas      = $.parseJSON(data);
            
            if (! oDatas.length) {
                $('#inUsedReplyTemplate').append('<tr class="havecontrols" style="border-bottom:solid 1px #ddd;">'
                    + '<td><p align="center">--- ไม่มีข้อมูล ---</p></td>'
                    + '</tr>');
                return;
            }
            
            $.each(oDatas, function (index, oData) {
                $('#inUsedReplyTemplate').append('<tr class="havecontrols" style="border-bottom:solid 1px #ddd;">'
                    + '<td><a href="?cmd=servicecataloghandle&action=viewIncidentKB&id='+ oData.id +'" target="_blank">#'+ oData.id +' '+ oData.title +'</a></td>'
                    + '</tr>');
            });
            
        });
        
    });
    
    function updateReplyTemplate ()
    {
        $('.spinner').show();
        $.post('?cmd=servicecataloghandle&action=updateReplyTemplate', $('#editReplyTemplateFrom').serializeObject(), function (a) {
            parse_response(a);
            $('.spinner').hide();
        });
        return false;
    }
    
    {/literal}
    </script>
    
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">

            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>

        </div>
        <div class="clear"></div>
    </div>
</div>