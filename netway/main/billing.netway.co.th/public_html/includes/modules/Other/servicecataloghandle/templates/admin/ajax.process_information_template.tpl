<!--https://github.com/dennyferra/TypeWatch -->
<script type="text/javascript" src="{$template_dir}js/jquery.typewatch.js?v={$hb_version}"></script>

<div id="formcontainer">
    <div id="formloader">
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="#">Edit</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3>Edit Template</h3>
                    <p>
                        แก้ไข template เพื่อเป็นโครงร่างให้เจ้าหน้าที่ใช้ในการระบุข้อมูลที่จำเป็น <br />
                        template ใช้ตอนสร้าง fulfillment แบบ <br />
                        A  (ตอนระบบ automation fail)<br />
                        B (ตอน provision plugin เรียกใช้โดยอัตโนมัติ)<br />
                        C (เจ้าหน้าที่สร้างตอนทำ order provision)<br />
                        ยกเว้น D (convert ticket ลูกค้าเป็น fulfillment ticket)<br />
                    </p>
                    
                    <form id="editProcessTemplate" method="post" action="">
                    {securitytoken}
                    <input type="hidden" name="serviceCatalogId" value="{$aData.sc_id}" />
                    <input type="hidden" name="processGroupId" value="{$aData.id}" />
                    
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <div style="display: block;">รายละเอียด</div>
                                <textarea id="dataTemplate" name="dataTemplate" rows="15" cols="60" style="width: 90%;">{if $aData.data_template}
{$aData.data_template}
{else}
-----------------------------------
Owner ของ ticket เป็น noreply จะไม่มี email ไปหาลูกค้า

ถ้าต้องการสื่อสารกับ ลูกค้า ทำได้ 2 แบบ คือ
1. แก้ไข owner ticket นี้ ให้เป็นของลูกค้า
2. สร้าง ticket ใหม่ เพื่อคุยกับลูกค้าโดยเฉพาะ

Order ID: {literal}{$orderUrl}{/literal}
Account ID: {literal}{$accountUrl}{/literal}
Product/services name: {literal}{$productName}{/literal}
โดเมน/hostname (ถ้ามี): {literal}{$domainName}{/literal}
Client ID: {literal}{$clientUrl}{/literal}
-----------------------------------
{/if}</textarea>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                    </form>
                    
                    <p>
                        {literal}
                        {$orderUrl} = link ไปยังหน้า Order Detail<br />
                        {$productName} = ชื่อบริการ <br />
                        {$domainName} = ชื่อ Domin หรือ Hosting account <br />
                        {$accountUrl} = link ไปยังหน้า Account Detail <br />
                        {$clientUrl} = link ไปยังหน้า Client Detail <br />
                        {/literal}
                    </p>
                    
                    <div><p>&nbsp;</p></div>
                    
                </div>
                
                
            </td>
        </tr>
        </table>
        
    </div>
    
    <script type="text/javascript">
    {literal}
    
    $('#lefthandmenu').TabbedMenu({elem:'.tabb',picked:0});
    
    $(document).ready( function () {
        
        $("#dataTemplate").typeWatch({
            callback    : function (value) {
                $('.spinner').show();
                $.post('?cmd=servicecataloghandle&action=updateProcessTemplate', $('#editProcessTemplate').serializeObject(), function (a) {
                    parse_response(a);
                    $('.spinner').hide();
                    $('.bcontainer').show();
                });
            },
            wait: 1000,
            highlight: false,
            allowSubmit: false,
            captureLength: 5
        });
        
        $("#dataTemplate").keypress( function () {
            $('.bcontainer').hide();
        });
        
    });
    
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