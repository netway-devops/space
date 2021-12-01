<div id="formcontainer">
    <div id="formloader">
        
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="#">Select</a>
                    <a class="tchoice" href="#">Add</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3 style="margin-bottom:0px;">เลือกแจ้งเตือนข้อมูลไปยัง</h3>
                    
                    <form method="post" action="" id="selectAddressForm" >
                        {securitytoken}
                        <input type="hidden" name="serviceId" value="{$serviceId}" />
                        <input type="hidden" name="type" value="{$type}" />
                    {if count($aAddress)}
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                    {foreach from=$aAddress item=aAddr}
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <input type="radio" name="client_id" id="clientAddressId{$aAddr.id}" value="{$aAddr.id}" />
                            </td>
                            <td>
                                {if $aAddr.date_update_by}
                                <div style="float: right; color: #999999;">แก้ไช {$aAddr.date_update_by}@{$aAddr.date_update}</div>
                                {/if}
                                <div onclick="$('#clientAddressId{$aAddr.id}').prop('checked', 'checked');" style="cursor: pointer;">
                                <b>{$aAddr.email}</b> 
                                <a href="?cmd=clients&action=showprofile&id={$aAddr.id}" class="editbtn" target="_blank">Edit</a>
                                <br />
                                 {$aAddr.firstname} {$aAddr.lastname} {$aAddr.phonenumber}
                                <div>
                                    {$aAddr.note}
                                </div>
                                </div>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return selectContactAddress()"><span class="addsth"> เพิ่ม </span></a></span>
                            </td>
                        </tr>
                    </tfoot>
                    </table>
                    {else}
                    <p align="center"> --- ไม่มีข้อมูล --- </p>
                    {/if}
                    </form>
                    
                </div>
                
                <div class="tabb" style="display:none">
                    <h3 style="margin-bottom:0px;">เพิ่มที่อยู่</h3>
                    
                    <form method="post" action="" id="addAddressForm" >
                        {securitytoken}
                        <input type="hidden" name="serviceId" value="{$serviceId}" />
                        <input type="hidden" name="type" value="{$type}" />
                    
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>E-mail</label>
                            </td>
                            <td>
                                <input type="text" name="email" value="" size="40" />*
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>ชื่อ - นามสกุล</label>
                            </td>
                            <td>
                                <input type="text" name="firstname" value="" size="30" placeholder="firstname" />
                                <input type="text" name="lastname" value="" size="30" placeholder="lastname" />
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>โทรศัพท์</label>
                            </td>
                            <td>
                                <input type="text" name="phonenumber" value="" size="40" />
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>หมายเหตุ</label>
                            </td>
                            <td>
                                <textarea name="notes" rows="4" cols="60"></textarea>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return addContactAddress()"><span class="addsth"> เพิ่ม </span></a></span>
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
    
    function selectContactAddress ()
    {
        $('.spinner').show();
        $.post('?cmd=addresshandle&action=updateToNotify', $('#selectAddressForm').serializeObject(), function (a) {
            parse_response(a);
            $('.spinner').hide();
            window.location.reload(true);
        });
        return false;
    }
    
    function addContactAddress ()
    {
        if (! $('#addAddressForm input[name="email"]').val() ) {
            alert('กรุณากรอกข้อมูล e-mail ด้วยสิครับ');
            return false;
        }
        $('.spinner').show();
        $.post('?cmd=addresshandle&action=addToNotify', $('#addAddressForm').serializeObject(), function (data) {
            parse_response(data);
            $('.spinner').hide();

            if (data.indexOf("<!-- {") == 0) {
                var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                if (codes.DATA.length > 0) {
                    var objContact  = $.parseJSON(codes.DATA);
                    
                    $('.spinner').show();
                    $.post('?cmd=addresshandle&action=updateToNotify', {
                            serviceId:  objContact.serviceId,
                            type:       objContact.addressType,
                            client_id:  objContact.contactId
                        }, function (a) {
                            parse_response(a);
                            $('.spinner').hide();
                            window.location.reload(true);
                    });
                    
                }
            }
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