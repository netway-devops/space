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
                    <h3>Edit Fulfillment Activity</h3>
                    <p>แก้ไข fulfillment activity ให้ตรวจสอบด้วยว่ามี service catalog ใหนใช้ fulfillment activity นี้บ้าง เพราะถ้าแก้ไขแล้วจะกระทบส่วนนั้นๆได้</p>
                    
                    <form id="editFulfillmentTaskFrom" method="post" action="">
                        {securitytoken}
                        <input type="hidden" name="serviceCatalogId" value="{$serviceCatalogId}" />
                        <input type="hidden" name="taskId" value="{$aTask.id}" />
                        
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>ชื่อ activity</td>
                            <td>
                                <div style="display: block;">ชื่อหัวข้องานที่จะให้ staff ดำเนินการ</div>
                                <input type="text" id="name" name="name" value="{$aTask.name}" size="40" style="width:90%;" />
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>OLA</td>
                            <td>
                                <div style="display: block;">operational level agreement กำหนดระยะเวลาในการดำเนินการ activity นี้</div>
                                <input type="text" id="ola" name="ola" value="{$aTask.ola_in_minute}" size="3" /> นาที
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>Assign Team:</td>
                            <td>
                                <div style="display: block;">เลือกทีมที่รับผิดชอบงานนี้ แล้วเลือกเจ้าหน้าที่ผู้รับผิดชอบ (ตั้งเป็นค่าเริ่มต้น สามารถเปลี่ยนผู้รับผิดชอบได้ที่หน้าดำเนินการ Request fullfilment process)</div>
                                <select id="assign" name="assign">
                                    {foreach from=$aAssign item="arr"}
                                    <optgroup label="{$arr.team}">
                                        {foreach from=$arr.staff item="arr2" key="staffId"}
                                        <option value="{$staffId}" {if $aTask.assign_staff_id == $staffId} selected="selected" {/if} >Lv.{$arr2.level} {$arr2.firstname}</option>
                                        {/foreach}
                                    </optgroup>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>รายละเอียด</td>
                            <td>
                                <div style="display: block;">รายละเอียดงานที่จะต้องดำเนินการ</div>
                                <textarea id="taskDetail" name="detail" rows="10" cols="60" style="width: 90%;">{$aTask.detail}</textarea>
                                <script language="JavaScript">
                                {literal}
                                CKEDITOR.replace('taskDetail', {toolbar:'Basic', width:'100%', height:'300px'});
                                CKEDITOR.add;
                                $(document).ready(function () {
                                    CKEDITOR.instances.taskDetail.on('blur', function() {
                                        $('#taskDetail').parent().addLoader();
                                        updateServiceCatalog ('taskDetail', CKEDITOR.instances.taskDetail.getData());
                                    });
                                });
                                {/literal}
                                </script>
                            </td>
                        </tr>
                         <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>Google Form</td>
                            <td>
                                <div style="display: block;">Link Form กรอกข้อมูลสำหรับการทำ Fulfillment</div>
                                <input type="text" id="linkGForm" name="linkGForm" value="{$aTask.link_google_form}" size="40" style="width:90%;" />
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>Response File on google drive</td>
                            <td>
                                <div style="display: block;">ชื่อไฟล์ที่เก็บ Response data ของ Form บน google drive</div>
                                <input type="text" id="linkGFormResponse" name="linkGFormResponse" value="{$aTask.link_response_google_form}" size="40" style="width:90%;" />
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                {if ! $isDisable}
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return updateFulfillmentTask()"><span>Update</span></a></span>
                                {else}
                                <span class="bcontainer" ><a class="new_control editbtn disabled" href="#" onclick="return alert('ไม่มีสิทธิ์แก้ไขข้อมูลนี้'); false;"><span>Update</span></a></span>
                                {/if}
                            </td>
                        </tr>
                    </tfoot>
                    </table>
                    </form>
                    
                    <div><p>&nbsp;</p></div>
                    
                    <h3>Service catalog ทีใช้ Fulfillment activity นี้</h3>
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody id="scUsedFulfillmentTask" style="background:#ffffff; border-top:solid 1px #ddd;">
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
        
        $.getJSON('?cmd=servicecataloghandle&action=relatedByFulfillmentTask&serviceCatalogId={/literal}{$serviceCatalogId}{literal}&taskId={/literal}{$aTask.id}{literal}', function (a) {
            var data        = a.data;
            var oDatas      = $.parseJSON(data);
            
            if (! oDatas.length) {
                $('#scUsedFulfillmentTask').append('<tr class="havecontrols" style="border-bottom:solid 1px #ddd;">'
                    + '<td><p align="center">--- ไม่มีข้อมูล ---</p></td>'
                    + '</tr>');
                return;
            }
            
            $.each(oDatas, function (index, oData) {
                $('#scUsedFulfillmentTask').append('<tr class="havecontrols" style="border-bottom:solid 1px #ddd;">'
                    + '<td><a href="?cmd=servicecataloghandle&action=view&id='+ oData.id +'" target="_blank">#'+ oData.id +' '+ oData.title +'</a></td>'
                    + '</tr>');
            });
            
        });
        
    });
    
    function updateFulfillmentTask ()
    {
        setTimeout(function () {
            $('#taskDetail').val(CKEDITOR.instances.taskDetail.getData());
            
            $('.spinner').show();
            $.post('?cmd=servicecataloghandle&action=updateFulfillmentTask', $('#editFulfillmentTaskFrom').serializeObject(), function (a) {
                parse_response(a);
                $('.spinner').hide();
            });
            
        }, 1000);
        
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