<div id="formcontainer">
    <div id="formloader">
        
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="#">Select</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3 style="margin-bottom:0px;">เลือกที่อยู่</h3>
                    
                    <form method="post" action="" id="selectAddressForm" >
                        {securitytoken}
                        <input type="hidden" name="invoiceId" value="{$invoiceId}" />
                        <input type="hidden" name="accountId" value="{$accountId}" />
                        <input type="hidden" name="domainId" value="{$domainId}" />
                        <input type="hidden" name="orderDraftId" value="{$orderDraftId}" />
                        <input type="hidden" name="estimateId" value="{$estimateId}" />
                        <input type="hidden" name="type" value="{$type}" />
                    {if count($aAddress)}
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                    {foreach from=$aAddress item=aAddr}
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <input type="radio" name="client_id" id="clientAddressId{$aAddr.id}" value="{$aAddr.id}" {if $aAddr.id == $currentContactId} checked="checked" {/if} />
                            </td>
                            <td>
                                <div onclick="$('#clientAddressId{$aAddr.id}').prop('checked', 'checked');" style="cursor: pointer;">
                                <b>{$aAddr.firstname} {$aAddr.lastname}</b> 
                                {if !$aAddr.parent_id}
                                    <b>(main account)</b> &nbsp;
                                    <a href="?cmd=clients&action=show&id={$aAddr.id}" class="editbtn" target="_blank">Edit</a>
                                {else}
                                    <a href="?cmd=clients&action=showprofile&id={$aAddr.id}" class="editbtn" target="_blank">Edit</a>
                                {/if}
                                <br />
                                {$aAddr.phonenumber}
                                <address>
                                {if $type == 'billing'}
                                    {$aAddr.billingAddress|nl2br}
                                {else}
                                    {$aAddr.mailingAddress|nl2br}
                                {/if}
                                </address>
                                </div>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ></td>
                            <td>
                                <br />
                                <input type="checkbox" name="skip_contactname" value="1" checked="checked" /> ไม่ใส่ชื่อผู้ติดต่อใน billing address
                            </td>
                        </tr>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return selectContactAddress()"><span>{$lang.savechanges}</span></a></span>
                            </td>
                        </tr>
                    </tfoot>
                    </table>
                    {else}
                    <p align="center"> --- ไม่มีข้อมูล --- </p>
                    {/if}
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
        $.post('?cmd=addresshandle&action=updateToInvoice', $('#selectAddressForm').serializeObject(), function (a) {
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