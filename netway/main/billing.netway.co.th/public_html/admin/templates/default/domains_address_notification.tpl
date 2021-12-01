<!-- Notification address -->
                            <div style="display: block;">
                                
                                <div class="ticketmsg ticketmain" style="width: 350px; display: block; float: left;">
                                    <div><b>Billing Address:</b></div>
                                    <div style="background-color: #FFFFFF; padding: 5px;">
                                        {$billingAddress|nl2br}
                                        <br />
                                        <div align="right" style="{if !isset($admindata.access.editInvoices)}display: none;{/if}"><a href="?cmd=addresshandle&action=listInvoice&type=billing&domainId={$details.id}" class="manageContactAddress">แก้ไข</a></div>
                                    </div>
                                </div>
                                <div class="ticketmsg ticketmain" style="width: 350px; display: block; float: left; margin-left: 10px;">
                                    <div><b>Mailing Address:</b></div>
                                    <div style="background-color: #FFFFFF; padding: 5px;">
                                        {$mailingAddress|nl2br}
                                    </div>
                                </div>
                                <div style="clear: both;"></div>
                                
                                <div class="ticketmsg ticketmain" style="display: block; width:99%;">
                                    <div><b>อีเมล์ที่เกี่ยวข้องกับบริการนี้จะถูกสำเนาไปยัง (ส่วนจัดการไปทำที่หน้า client contact):</b></div>
                                    <table border="0" cellpadding="0" cellspacing="3" width="90%">
                                    <thead style="text-align: left;">
                                        <tr class="blu">
                                            <th>E-mail</th>
                                            <th>Contact person</th>
                                            <th>Phone</th>
                                            <th align="center" width="100"> <!-- {if isset($admindata.access.editAccounts)} <a href="?cmd=addresshandle&action=listNotify&type=domain&serviceId={$details.id}" class="manageContactAddress">Add</a> {/if} --> </th>
                                            <th>Note</th>
                                        </tr>
                                    </thead>
                                    {if isset($aNotifiyPersons) && count($aNotifiyPersons) }
                                    <tbody>
                                        {foreach from=$aNotifiyPersons item=aNotifiyPerson}
                                        <tr>
                                            <td width="200" nowrap="nowrap">{$aNotifiyPerson.email}</td>
                                            <td width="200" nowrap="nowrap">{$aNotifiyPerson.firstname} {$aNotifiyPerson.lastname}</td>
                                            <td width="100" nowrap="nowrap">{$aNotifiyPerson.phonenumber}</td>
                                            <td width="100" align="center" nowrap="nowrap">
                                                {if isset($admindata.access.editAccounts)}
                                                <a href="?cmd=clients&action=showprofile&id={$aNotifiyPerson.id}" class="editbtn" target="_blank">Edit</a>
                                                <!-- <a href="?cmd=addresshandle&action=removeNotify&type=domain&serviceId={$details.id}&clientId={$aNotifiyPerson.id}" class="removeContactAddress editbtn">Remove</a> -->
                                                {/if}
                                            </td>
                                            <td width="500">
                                                {if isset($admindata.access.editAccounts)}
                                                <div  tabindex="{$aNotifiyPerson.id}" class="editContactNotes" style="border-bottom: 1px dotted #F00107;"> {$aNotifiyPerson.notes} </div>
                                                {/if}
                                            </td>
                                        </tr>
                                        {/foreach}
                                    </tbody>
                                    {/if}
                                    </table>
                                    <div> หมายเหตุ: contact จะได้รับ email notify เฉพาะ custom email template เท่านั้น </div>
                                </div>
                                <div style="clear: both;">  </div>
                            </div>
                        
                            <script type="text/javascript">
                            {literal}
                            $(document).ready(function () {
                                $('.manageContactAddress').click(function () {
                                    var fbUrl   = $(this).prop('href');
                                    $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
                                    return false;
                                });
                                $('.removeContactAddress').click(function () {
                                    if (confirm('ยืนยันการลบ?')) {
                                        var rmUrl   = $(this).prop('href');
                                        $.get(rmUrl, {}, function (data){
                                            parse_response(data);
                                        });
                                        $(this).parent().parent().hide();
                                    }
                                    return false;
                                });
                                $('.editContactNotes').editable( function (value, settings) { 
                                        var contactId       = $(this).prop('tabindex');
                                        $.post('?cmd=addresshandle&action=updateNotes', {contactId:contactId, notes:value}, function (data) {
                                            parse_response(data);
                                        });
                                        return value;
                                    }, {
                                    type        : 'textarea',
                                    cancel      : 'Cancel',
                                    submit      : 'Save',
                                    tooltip     : 'Click to edit...'
                                });
                            });
                            {/literal}
                            </script>