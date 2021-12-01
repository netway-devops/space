
<div id="formcontainer">
    <div id="formloader">
        
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="#">lists</a>
                    <a class="tchoice" href="#" style="display: none;">View</a>
                    <a class="tchoice" href="#">Add</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3>List reply template</h3>
                    <p>เลือก reply template ที่สามารถใช้งานได้</p>
                    
                    <form method="post" action="">
                        {securitytoken}
                    
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody id="listReplyTemplate" style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td colspan="2">
                                <p>
                                <input type="search" id="searchKeyword" placeholder="ค้นหา reply template" class="styled inp" style="width: 90%; line-height: 2em;" />
                                </p>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </tfoot>
                    </table>
                    </form>
                    
                </div>
                
                <div class="tabb">
                    <h3>View reply template</h3>
                    <p>รายละเอียดเกี่ยวกับ reply template</p>
                    
                    <h4 id="rtSubject"><u>Subject:</u><br><span></span></h4>
                    <p id="rtMessage"><u>Message:</u><br><span></span></p>
                    <p id="rtOwner"><u>Owner:</u> <span></span></p>
                    
                </div>
                
                <div class="tabb">
                    <h3>Add reply template</h3>
                    <p>เพิ่ม Reply template สำหรับใช้งานใน {if $kbId} Incident KB {else} Service catalog {/if}</p>
                    
                    <form id="addReplyTemplateForm" method="post" action="">
                        {securitytoken}
                        <input type="hidden" name="serviceCatalogId" value="{$serviceCatalogId}" />
                        <input type="hidden" name="kbId" value="{$kbId}" />
                        
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>หัวข้อ</td>
                            <td>
                                <div style="display: block;">หัวข้อเพื่อบอก staff ว่า reply template นี้เกี่ยวกับอะไร</div>
                                <input type="text" id="subject" name="subject" value="" size="40" style="width:90%;" />
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>Message</td>
                            <td>
                                <div style="display: block;">รายละเอียดที่จะส่งให้ลูกค้า</div>
                                <textarea id="message" name="message" rows="10" cols="60" style="width: 90%;"></textarea>
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
                        {if $kbId}
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>สำหรับ</td>
                            <td>
                                <div style="display: block;">reply template นี้เหมาะกับแผนก</div>
                                <select name="level">
                                    <option value="1">Helpdesk</option>
                                    <option value="2">Support</option>
                                </select>
                            </td>
                        </tr>
                        {/if}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return addReplyTemplate()"><span>Add</span></a></span>
                            </td>
                        </tr>
                    </tfoot>
                    </table>
                    </form>
                    
                </div>
                
            </td>
        </tr>
        </table>
        
    </div>
    
    <script type="text/javascript">
    {literal}
    
    $('#lefthandmenu').TabbedMenu({elem:'.tabb'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});
    
    $(document).ready( function () {
        
        $('#searchKeyword').keypress(function (e) {
            if ( e.which == 13 ) {
                searchReplyTemplate($(this).val());
                return false;
            }
        });
        
        searchReplyTemplate('');
        
    });
    
    function searchReplyTemplate (keyword)
    {
        $.getJSON('?cmd=servicecataloghandle&action=searchReplyTemplate&keyword='+ keyword 
            + '&kbId={/literal}{$kbId}{literal}&serviceCatalogId={/literal}{$serviceCatalogId}{literal}', function (a) {
            var data        = a.data;
            var oDatas      = $.parseJSON(data);
            lsitReplyTemplate (oDatas);
        });
    }
    
    function lsitReplyTemplate (oDatas)
    {
        $('.listReplyTemplate').remove();
        
        if (! oDatas.length) {
            return;
        }
        
        $.each(oDatas, function (index, oData) {
            $('#listReplyTemplate').append('<tr class="havecontrols listReplyTemplate" style=" padding: 5px; border-bottom:solid 1px #ddd;">'
                + '<td width="150">'
                {/literal}{if $kbId}{literal}
                + '<select class="greenbtn" onchange="selectReplyTemplate('+oData.id+', this.value)"><option value="">Select</option><option value="1">Helpdesk</option><option value="2">Support</option></select>'
                {/literal}{else}{literal}
                + '<a class="new_control greenbtn" href="#" onclick="return selectReplyTemplate('+oData.id+', 0)"><span>Select</span></a>'
                {/literal}{/if}{literal}
                + '<a class="new_control editbtn" href="#" onclick="return viewReplyTemplate('+oData.id+')"><span>View</span></a>'
                + '</td>'
                + '<td>'
                + '<strong>'+oData.subject+'</strong><br />'
                + ''+oData.message+'<br />'
                + '</td>'
                + '</tr>');
        });
        
    }
    
    function selectReplyTemplate (id, level)
    {
        $('.spinner').show();
        $.post('?cmd=servicecataloghandle&action=selectReplyTemplate', {
            id      : id,
            level   : level,
            kbId    : '{/literal}{$kbId}{literal}',
            serviceCatalogId    : '{/literal}{$serviceCatalogId}{literal}'
            }, function (a) {
            parse_response(a);
            $('.spinner').hide();
            window.location.reload(true);
        });
        return false;
    }
    
    function viewReplyTemplate (id)
    {
        $('.spinner').show();
        $.getJSON('?cmd=servicecataloghandle&action=viewReplyTemplate&id='+ id, function (a) {
            var data        = a.data;
            var oData       = $.parseJSON(data);
            
            $('#rtSubject span').html(oData.subject);
            $('#rtMessage span').html(oData.message);
            $('#rtOwner span').html(oData.owner);
            
            $('#lefthandmenu').TabbedMenu({elem:'.tabb',picked:1});
            $('.tchoice').eq(1).show();
            
            $('.spinner').hide();
        });
        return false;
    }
    
    function addReplyTemplate ()
    {
        $('.spinner').show();
        $.post('?cmd=servicecataloghandle&action=createReplyTemplate', $('#addReplyTemplateForm').serializeObject(), function (a) {
            parse_response(a);
            $('.spinner').hide();
            window.location.reload(true);
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