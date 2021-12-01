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
                    <h3>Fulfillment activity list</h3>
                    <p>รายการ activity ที่สามารถนำไปใช้ใน process fulfillment</p>
                    
                    <form method="post" action="">
                        {securitytoken}
                    
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody id="listFulfillmentTask" style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td colspan="2">
                                <p>
                                <input type="search" id="searchKeyword" placeholder="ค้นหา fulfillment activity ที่จะนำไปใช้" class="styled inp" style="width: 90%; line-height: 2em;" />
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
                    <h3>View fulfillment activity</h3>
                    <p>รายละเอียดเกี่ยวกับ fulfillment activity</p>
                    
                    <h4 id="ptName"><u>Name:</u><br> <span></span></h4>
                    <p id="ptAssign"><u>Assign Team:</u> <span></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <u>Assign Staff:</u> <span></span> </p>
                    <p id="ptDetail"><u>Detail:</u><br> <span></span></p>
                    <p id="ptOwner"><u>Owner:</u> <span></span></p>
                    
                </div>
                
                <div class="tabb">
                    <h3>Add Fulfillment Activity</h3>
                    <p>เพิ่ม Fulfillment Activity สำหรับใช้งานในการทำ fullfilment process</p>
                    
                    <form id="addFulfilmentTask" method="post" action="">
                        {securitytoken}
                        <input type="hidden" name="serviceCatalogId" value="{$serviceCatalogId}" />
                        <input type="hidden" name="groupId" value="{$groupId}" />
                        
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>ชื่อ Activity</td>
                            <td>
                                <div style="display: block;">ชื่อหัวข้องานที่จะให้ staff ดำเนินการ</div>
                                <input type="text" id="name" name="name" value="" size="40" style="width:90%;" />
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>OLA</td>
                            <td>
                                <div style="display: block;">operational level agreement กำหนดระยะเวลาในการดำเนินการ activity นี้</div>
                                <input type="text" id="ola" name="ola" value="" size="3" /> นาที
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
                                        <option value="{$staffId}">Lv.{$arr2.level} {$arr2.firstname}</option>
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
                                <textarea id="taskDetail" name="detail" rows="10" cols="60" style="width: 90%;"></textarea>
                                <script language="JavaScript">
                                {literal}
                                CKEDITOR.replace('taskDetail', {toolbar:'Basic', width:'100%', height:'300px'});
                                {/literal}
                                </script>
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>Google Form</td>
                            <td>
                                <div style="display: block;">Link Form กรอกข้อมูลสำหรับการทำ Fulfillment</div>
                                <input type="text" id="linkGForm" name="linkGForm" value="" size="40" style="width:90%;" />
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>Response File on google drive</td>
                            <td>
                                <div style="display: block;">ชื่อไฟล์ที่เก็บ Response data ของ Form บน google drive</div>
                                <input type="text" id="linkGFormResponse" name="linkGFormResponse" value="" size="40" style="width:90%;" />
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return addFulfillmentTask()"><span>Add</span></a></span>
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
                searchFulfillmentTask($(this).val());
                return false;
            }
        });
        
        searchFulfillmentTask('');
        
    });
    
    
    function searchFulfillmentTask (keyword)
    {
        $.getJSON('?cmd=servicecataloghandle&action=searchFulfillmentTask&keyword='+ keyword 
            + '&groupId={/literal}{$groupId}{literal}'
            + '&serviceCatalogId={/literal}{$serviceCatalogId}{literal}', function (a) {
            var data        = a.data;
            var oDatas      = $.parseJSON(data);
            lsitFulfillmentTask (oDatas);
        });
    }
    
    function lsitFulfillmentTask (oDatas)
    {
        $('.listReplyTemplate').remove();
        
        if (! oDatas.length) {
            return;
        }
        
        $.each(oDatas, function (index, oData) {
            $('#listFulfillmentTask').append('<tr class="havecontrols" style=" padding: 5px; border-bottom:solid 1px #ddd;">'
                + '<td width="100">'
                + '<a class="new_control greenbtn" href="#" onclick="return selectFulfillmentTask('+oData.id+')"><span>Select</span></a>'
                + '<a class="new_control editbtn" href="#" onclick="return viewFulfillmentTask('+oData.id+')"><span>View</span></a>'
                + '</td>'
                + '<td>'
                + '<strong>'+oData.name+'</strong><br />'
                + ''+oData.detail+'<br />'
                + '</td>'
                + '</tr>');
        });
        
    }
    
    function selectFulfillmentTask (id)
    {
        $('.spinner').show();
        $.post('?cmd=servicecataloghandle&action=selectFulfillmentTask', {
            id      : id,
            serviceCatalogId    : {/literal}{$serviceCatalogId}{literal},
            groupId             : {/literal}{$groupId}{literal}
            }, function (a) {
            parse_response(a);
            $('.spinner').hide();
            window.location.reload(true);
        });
        return false;
    }
    
    function viewFulfillmentTask (id)
    {
        $('.spinner').show();
        $.getJSON('?cmd=servicecataloghandle&action=viewFulfillmentTask&id='+ id, function (a) {
            var data        = a.data;
            var oData       = $.parseJSON(data);
            
            $('#ptName span').html(oData.name);
            $('#ptDetail span').html(oData.detail);
            $('#ptOwner span').html(oData.owner);
            $('#ptAssign span').eq(0).html(oData.team);
            $('#ptAssign span').eq(1).html(oData.staffname);
            
            
            $('#lefthandmenu').TabbedMenu({elem:'.tabb',picked:1});
            $('.tchoice').eq(1).show();
            
            $('.spinner').hide();
        });
        return false;
    }
    
    function addFulfillmentTask ()
    {
        setTimeout(function () {
            $('#taskDetail').val(CKEDITOR.instances.taskDetail.getData());
            
            $('.spinner').show();
            $.post('?cmd=servicecataloghandle&action=createFulfillmentTask', $('#addFulfilmentTask').serializeObject(), function (a) {
                parse_response(a);
                $('.spinner').hide();
                window.location.reload(true);
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