<div id="formcontainer">
    <div id="formloader">
        
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="javascript:void(0);">Add</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3 style="margin-bottom:0px;">เพิ่มเหตุการณ์เกี่ยวกับ account นี้</h3>
                    
                    <form method="post" action="" id="addEventForm" >
                        {securitytoken}
                        <input type="hidden" name="accountId" value="{$accountId}" />
                    
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>เหตุการณ์</label>
                            </td>
                            <td>
                                <select name="type">
                                    <option value="Disk Space" {if $type == 'Disk Space'} selected="selected" {/if}>Disk Space</option>
                                    <option value="Banwidth" {if $type == 'Banwidth'} selected="selected" {/if}>Banwidth</option>
                                    <option value="Spam" {if $type == 'Spam'} selected="selected" {/if}>Spam</option>
                                    <option value="Overload" {if $type == 'Overload'} selected="selected" {/if}>Overload</option>
                                </select>
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>อ้างอิง link</label>
                            </td>
                            <td>
                                <input type="text" name="link" value="" size="60" onchange="addAccountGetMessage(this.value)" />
                                <small>ไส่ link url มาเต็มๆได้เลย</small>
                            </td>
                        </tr>
                        <tr id="eventRelated" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>เลือกรายการที่เกี่ยวข้อง</label>
                            </td>
                            <td>
                                <ul style="list-style: none; margin: 0px; padding: 0px;"></ul>
                            </td>
                        </tr>
                        <tr id="accountEventNote" class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>หมายเหตุ</label>
                            </td>
                            <td>
                                <textarea name="note" id="eventNote" rows="4" cols="60"></textarea>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return addAccountEvent()"><span class="addsth"> เพิ่ม </span></a></span>
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
    
    $(document).ready( function () {
        $('#addEventForm').submit( function () {
            return false;
        });
    });
    
    $('#lefthandmenu').TabbedMenu({elem:'.tabb'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});
    
    function addAccountEvent ()
    {
        $('.spinner').show();
        $.post('?cmd=accounteventhandle&action=addEvent', $('#addEventForm').serializeObject(), function (data) {
            parse_response(data);
            $('.spinner').hide();
            if (data.indexOf("<!-- {") == 0) {
                var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                if (codes.ERROR.length == 0) {
                    window.location.reload(true);
                }
            }
        });
        return false;
    }
    
    function addAccountGetMessage (url)
    {
        $('#eventRelated').hide();
        if (url.length <= 1) {
            $('#accountEventNote').hideLoader();
            return false;
        }
        $('#accountEventNote').addLoader();
        $('#accountEventNote').click(function () {
            $(this).hideLoader();
        });
        
        $.post('?cmd=accounteventhandle&action=getMessage', {link: url}, function (data) {
            $('#accountEventNote').hideLoader();
            parse_response(data);
            
            if (data.indexOf("<!-- {") == 0) {
                var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                if (codes.DATA.length > 0) {
                    var objResult   = $.parseJSON(codes.DATA);
                    console.log(objResult);
                    if (objResult.hasOwnProperty('message')) {
                        $('#eventNote').val(objResult.message);
                    } else if (objResult.hasOwnProperty('lists')) {
                        $('#eventRelated').show();
                        $('#eventRelated ul').empty();
                        $.each(objResult.lists, function(i, item) {
                            $('#eventRelated ul').append('<li><label style="width: 100%; height: 1.6em; text-align: left; font-weight: normal;"><input type="radio" name="message" value="'+ item.date +': '+ item.note +'" onclick="$(\'#eventNote\').val(this.value);$(\'#eventRelated\').hide();" /> '+ item.date +': '+ item.note +'</label></li>');
                        });
                    }
                }
            }
            
        });
        
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