<div id="formcontainer">
    <div id="formloader">
        
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="#">Create</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3 style="margin-bottom:0px;">Create change management ticket</h3>
                    
                    <form id="createChangeForm" method="post" action="">
                    {securitytoken}
                    <input type="hidden" name="invoiceId" value="" />
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px; background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                Subject
                            </td>
                            <td>
                                <p><input type="text" name="subject" value="" style="width: 90%;" /></p>
                            </td>
                        </tr>
                        <tr valign="top" class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <p>เลือก Service ของลูกค้า</p>
                            </td>
                            <td>
                                <p>
                                    <input type="text" name="account" value="" size="6" readonly="readonly" placeholder="#ID" />
                                    <input type="text" name="search" value="" placeholder="ค้นหาจาก ชื่อ domain, ชื่อ server แล้วเลือก" style="width: 60%;" />
                                </p>
                                <table id="listClientService" width="100%" cellpadding="2" cellspacing="2" border="0"></table>
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                เงื่อนไขการยืนยัน
                            </td>
                            <td>
                                <label style="width: 300px; text-align: left">
                                    <input type="radio" name="confirm" value="confirm" />
                                    รอให้ลูกค้ายืนยันให้ดำเนินการ
                                </label>
                                <label style="width: 300px; text-align: left">
                                    <input type="radio" name="confirm" value="notify" />
                                    บังคับเปลี่ยน แต่มีการแจ้งผู้ได้รับผลกระทบ
                                </label>
                                <label style="width: 300px; text-align: left">
                                    <input type="radio" name="confirm" value="force" />
                                    บังคับการเปลี่ยนแปลง ไม่แจ้งผู้ได้รับผลกระทบ
                                </label>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><div class="left spinner"><img src="ajax-loading2.gif"></div><br ></td>
                            <td>
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return submitChangeTicket();"><span>Submit ticket</span></a></span>
                                * ระบบจะไม่มีการส่ง email ไปหาลูกค้า ตอน click ปุ่ม create นี้
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
    
    $('#lefthandmenu').TabbedMenu({elem:'.tabb'});
    
    $(document).ready( function () {
        
        $('#createChangeForm input[name="search"]').keypress(function( event ) {
            if ( event.which == 13 ) {
                var query   = $(this).val();
                
                $('#listClientService').parent().addLoader();
                $.get('?cmd=accounthandle&action=search', {keyword:query}, function (data) {
                    $('#preloader').remove();
                    var codes   = {};
                    if (data.indexOf("<!-- {") == 0) {
                        codes   = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                    }
                    
                    $('#listClientService tr').remove('');
                    var numdata = 0;
                    if (Object.keys(codes.DATA).length > 0) {
                        $.each(codes.DATA[0], function(k, v) {
                            $('#listClientService').append('<tr id="account_'+ v.id +'"><td>'
                                +'<a href="javascript:void(0);" onclick="selectAccount('+ v.id 
                                +')" class="greenbtn menuitm menul">Select</a>' 
                                +'</td><td><strong>Service: '+ v.domain +' @ '+  v.service +'</strong>'
                                +'<br />'+ v.firstname +' '+ v.lastname 
                                +' ('+ v.email +')<br />'+ v.companyname +'</td></tr>');
                                numdata++;
                        });
                    }
                    if (! numdata) {
                        $('#listClientService').append('<tr><td colspan="2"><p>--- ไม่พบข้อมูล ---</p></td></tr>');
                    }
                    
                });
                
            }
        });
    
    });
    
    function selectAccount (id)
    {
        $('#createChangeForm input[name="account"]').val(id);
        $('#listClientService tr:not(#account_'+ id +')').remove('');
        
        return false;
    }
    
    function submitChangeTicket ()
    {
        if (! $('#createChangeForm input[name="account"]').val()
            || ! $('#createChangeForm input[name="subject"]').val()
            || (typeof $('#createChangeForm input[name="confirm"]:checked').val() == "undefined")
            ) {
            alert('กรุณากรอกข้อมูลให้ครบถ้วน');
            return false;
        }
        
        $('.spinner').show();
        $.post('?cmd=supportcataloghandle&action=addChangeTicket', $('#createChangeForm').serializeObject(), function (data) {
            parse_response(data);
            $('.spinner').hide();
            
            var codes   = {};
            if (data.indexOf("<!-- {") == 0) {
                codes   = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
            }
            
            var data    = codes.DATA[0];
            if (typeof data.ticket_id !== 'undefined') {
                window.location = '?cmd=tickets&action=view&num='+ data.ticket_id;
            }
            
        });
        
        return false;
    }
    
    {/literal}
    </script>
    
</div>