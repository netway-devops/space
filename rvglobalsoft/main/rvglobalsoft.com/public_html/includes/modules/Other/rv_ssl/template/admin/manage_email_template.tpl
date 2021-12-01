{php}
$mailList = array();
$allmailList = $this->get_template_vars('aEmailAll');
foreach($allmailList as $k => $v){
    $mailList[$v['id']] = $v['subject'];
}
$this->assign('mailList', $mailList);
if($_SESSION['AppSettings']['admin_login']['username'] == 'natdanai@rvglobalsoft.com'){
    $this->assign('devtest', 1);
}
{/php}
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td><h3>RV SSL Management</h3></td>
            <td class="searchbox"></td>
        </tr>
        <tr>
            <td class="leftNav">
                {if $submenuList}
                    {foreach from=$submenuList item=menu}
                    <a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}" class="tstyled">{$menu.name}</a>
                    {/foreach}
                {/if}
            </td>
            <td  valign="top">
                <div id="bodycont" >
                    <div class="blu">
                        <h1>Manage Email Template</h1>
                        <br />
                        <table class="glike hover" width="100%">
                            <tr>
                                <th width="40%">Email Action</th>
                                <th width="10%">Send To</th>
                                <th width="40%">Email Select</th>
                                <th width="10%"><div align="center">Action</div></th>
                            </tr>
                            {php} $i = 0; {/php}
                            {foreach from=$aEmailSetting item=mlist}
                            <tr>
                                <td class="slot_one_{php} echo $i; {/php}">{$libEmail[$mlist.code].text}</td>
                                <td class="slot_two_{php} echo $i; {/php}">{$mlist.email_to}</td>
                                <td class="emailSelect{php}echo $i;{/php}"><a href="?cmd=emailtemplates&action=edit&id={$mlist.email_template_id}" target="_blank">{$mailList[$mlist.email_template_id]}</a></td>
                                <td>
                                    <div align="center">
                                        <a href="javascript:void(0);" name="{php} echo $i; {/php}" class="editMail">Edit</a>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="javascript:void(0);" id="deleteMail{php} echo $i; {/php}" name="{$mlist.id}" class="deleteMail">Delete</a>
                                        <input type="button" name="{php} echo $i; {/php}" id="saveMail{php} echo $i; {/php}" class="saveMail" value="Save" style="display:none;"/>
                                    </div>
                                </td>
                            </tr>
                            {php} $i++; {/php}
                            {/foreach}
                            <tr class="newMailTr">
                                <td class="newRow1"><a href="javascript:void(0);" id="newMail" style="display:none;">Add email</a></td>
                                <td class="newRow2"></td>
                                <td class="newRow3"></td>
                                <td class="newRow4"></td>
                            </tr>
                        </table>
                        <br /><a href="javascript:void(0);" id="helpMenu">help menu</a>
                        <table class="glike hover" id="helpTable" style="margin-top:10px; <!--display:none;-->" width="40%">
                            <tr style="display:none;">
                                <th width="50%"></th>
                                <th width="50%"></th>
                            </tr>
                            <tr>
                                <th colspan="2">General Variables</th>
                            </tr>
                            
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Account ID</td>
                                <td><input type="text" value="{php}echo '{$account_id}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Order ID</td>
                                <td><input type="text" value="{php}echo '{$order_id}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Authority Order ID</td>
                                <td><input type="text" value="{php}echo '{$authority_order_id}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Email Approval</td>
                                <td><input type="text" value="{php}echo '{$email_approval}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <th colspan="2">Verification Call Variables</th>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Verification call date 1 : from</td>
                                <td><input type="text" value="{php}echo '{$date_call_from_1}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Verification call date 1 : to</td>
                                <td><input type="text" value="{php}echo '{$date_call_to_1}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Verification call time 1 : from</td>
                                <td><input type="text" value="{php}echo '{$call_from_1}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Verification call time 1 : to</td>
                                <td><input type="text" value="{php}echo '{$call_to_1}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Verification call date 2 : from</td>
                                <td><input type="text" value="{php}echo '{$date_call_from_2}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Verification call date 2 : to</td>
                                <td><input type="text" value="{php}echo '{$date_call_to_2}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Verification call time 2 : from</td>
                                <td><input type="text" value="{php}echo '{$call_from_2}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Verification call time 2 : to</td>
                                <td><input type="text" value="{php}echo '{$call_to_2}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;GMT</td>
                                <td><input type="text" value="{php}echo '{$gmt}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <th colspan="2">Other Variables</th>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Error Message while Order to Symantec</td>
                                <td><input type="text" value="{php}echo '{$error_content}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                            <tr>
                                <td>&nbsp;&nbsp;&nbsp;Live Chat URL</td>
                                <td><input type="text" value="{php}echo '{$live_chat_url}';{/php}" onClick="this.select();" readonly/></td>
                            </tr>
                        </table>
                        {if $devtest && $aEmailSettingRow > 0}
                        <br />
                        <table class="glike hover" width="40%">
                            <tr style="opacity: 0;">
                                <th width="40%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                <th width="60%"></th>
                            </tr>
                            <tr>
                                <th colspan="2">TEST EMAIL</th>
                            </tr>
                            <tr id="trAction" style="display:none;">
                                <td>Action : </td>
                                <td><span id="process"></span></td>
                            </tr>
                            <tr>
                                <td>Send To : </td>
                                <td><input id="mailTestMail" type="text" /></td>
                            </tr>
                            <tr>
                                <td>Order ID : </td>
                                <td><input id="orderIdTestMail" type="text" /></td>
                            </tr>
                            <tr>
                                <td>Select Email : </td>
                                <td>
                                    <select id="selectTestMail">
                                        {foreach from=$aEmailSetting item=mlist}
                                        <option value="{$mlist.code}">{$libEmail[$mlist.code].text}</option>
                                        {/foreach}
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Show variables : </td>
                                <td>
                                    <input id="showVar" type="checkbox"></input>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"><input id="submitTestMail" type="button" value="Send"/></td>
                            </tr>
                        </table>
                        {/if}
                    </div>
                </div>
            </td>
        </tr>
    </tbody>
</table>

<script type="text/javascript">
{literal}
    var emailList = JSON.parse('{/literal}{$aEmailAllJSON}{literal}');
    var emailSetting = JSON.parse('{/literal}{$aEmailSettingJSON}{literal}'); 
    var emailActionlist = [];
    
    $(document).ready(function(){
        $.ajax({
            url: '{/literal}{$system_url}{literal}7944web/index.php',
            type: 'POST',
            data: {
                cmd: 'module'
                , module: 'ssl'
                , action: 'get_email_template_lib'
            },
            success: function(data){
                var aResponse = data.aResponse;
                var count = 0;
                for(i in aResponse){
                    emailActionlist[i] = aResponse[i];
                    count++;
                }
                $('#newMail').show();
                if(emailSetting.length == count && emailSetting.length != 0){
                    $('.newMailTr').hide();
                }
            }
        });
    });
    
    $('.editMail').click(function(){
        var selOption = '';        
        selOption += '<select class="slot_three_' + $(this).attr('name') + '">';
        for(i = 0; i < emailList.length; i++){
            selOption += '<option value="' + emailList[i]['id'] + '">' + emailList[i]['subject'] + '</option>';
        }
        selOption += '</select>';
        
        $('.emailSelect' + $(this).attr('name')).html(selOption);
        $(this).hide();
        $('#deleteMail' + $(this).attr('name')).hide();
        $('#saveMail' + $(this).attr('name')).show();
    });
    
    $('.saveMail').click(function(){
        var saveId = $(this).attr('name');
        var emailcode_text = $('.slot_one_' + saveId).text();
        var emailto_text = $('.slot_two_' + saveId).text();
        var emailtempid_text = $('.slot_three_' + saveId).val();
        
        $.ajax({
            url: '{/literal}{$system_url}{literal}7944web/index.php',
            type: 'POST',
            data: {
                cmd: 'module'
                , module: 'ssl'
                , action: 'update_email_template'
                , emailcode: emailcode_text
                , emailto: emailto_text
                , emailtempid: emailtempid_text
            },
            success: function(data){
               location.reload();
            }
        });
    });
    
    $('.deleteMail').click(function(){
        if(confirm('Are you sure to delete this email setting?')){
            $.ajax({
                url: '{/literal}{$system_url}{literal}7944web/index.php',
                type: 'POST',
                data: {
                    cmd: 'module'
                    , module: 'ssl'
                    , action: 'delete_email_template'
                    , id: $(this).attr('name')
                },
                success: function(data){
                   location.reload();
                }
            });
        }
    });
    
    $('#newMail').click(function(){
        var actionOption = '';
        var selectOption = '';
        var firstKey = '';
        var chk = 0;
        
        
        for(i in emailActionlist){
            chk = 0;
            for(j = 0; j < emailSetting.length; j++){
                if(i == emailSetting[j].code){
                    delete emailActionlist[i];
                    chk = 1;
                    break;
                }
            }
            if(firstKey == '' && chk == 0){
                firstKey = i;
            }
        }
        
        actionOption += '<select id="newEmailAction">';
        for(i in emailActionlist){
            actionOption += '<option value="' + i + '">' + emailActionlist[i].text + '</option>';
        }
        actionOption += '</select>';
        
        selectOption += '<select id="newESelect">';
        for(i = 0; i < emailList.length; i++){
            selectOption += '<option value="' + emailList[i]['id'] + '">' + emailList[i]['subject'] + '</option>';
        }
        selectOption += '</select>';
        
        $('.newRow1').html(actionOption);
        $('.newRow2').html('<span id="toSpan">' + emailActionlist[firstKey].to + '</span>');
        $('.newRow3').html(selectOption);
        $('.newRow4').html('<div align="center"><input id="newAction" type="button" value="Save"/></div>');
        
        $('#newAction').click(function(){
            $.ajax({
                url: '{/literal}{$system_url}{literal}7944web/index.php',
                type: 'POST',
                data: {
                    cmd: 'module'
                    , module: 'ssl'
                    , action: 'update_email_template'
                    , emailcode: $('#newEmailAction').val()
                    , emailto: $('#toSpan').text()
                    , emailtempid: $('#newESelect').val()
                },
                success: function(data){
                   location.reload();
                }
            });
        });
        
        $('#newEmailAction').change(function(){
            $('#toSpan').text(emailActionlist[$('#newEmailAction').val()].to);
        });
    });
    
    $('#submitTestMail').click(function(){
        var sendMail = $('#mailTestMail').val();
        var orderId = $('#orderIdTestMail').val(); 
        var selectMail = $('#selectTestMail').val();
        var showVar = $('#showVar').val();
        $('#submitTestMail').attr('disabled', true);
        
        $('#process').text('');
        $('#process').css('color', false);
        $('#trAction').hide(); 
        
        if(sendMail != '' && orderId != ''){
            $.ajax({
                url: '{/literal}{$system_url}{literal}7944web/index.php',
                type: 'POST',
                data: {
                    cmd: 'module'
                    , module: 'ssl'
                    , action: 'test_email_template'
                    , emailcode: selectMail
                    , emailto: sendMail
                    , emailorderid: orderId
                    , test: $('#showVar').is(':checked')
                },
                success: function(data){
                    aResponse = data.aResponse;
                    console.log(aResponse);
                    $('#trAction').show(); 
                    if(aResponse == true){
                        $('#process').text('Message sent.');
                        $('#process').css('color', 'green');
                    } else {
                        $('#process').text(aResponse);
                        $('#process').css('color', 'red');
                    }
                    $('#submitTestMail').attr('disabled', false);
                }
            });
        } else {
            $('#trAction').show(); 
            $('#process').text('Please fill all the blank.');
            $('#process').css('color', 'red');
            $('#submitTestMail').attr('disabled', false);
        }
        
    });
    
    $('#helpMenu').click(function(){
        $('#helpTable').toggle();
    });
    
    
    
{/literal}
</script>