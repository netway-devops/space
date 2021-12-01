<div id="formcontainer">
    <div id="formloader">
        
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="javascript:void(0);">List: {$type}</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                
                <div class="tabb">
                    <h3 style="margin-bottom:0px;">ข้อมูล account เหตุการณ์เกี่ยวกับ {$type}</h3>
                    
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        {if count($aLists)}
                            {foreach from=$aLists item=aList}
                            <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                                <td>
                                    {$aList.note}<br />
                                    &#8230;<small>{$aList.admin}</small>&nbsp;&nbsp;&nbsp;
                                    {if $aList.link}
                                    <a href="{$aList.link}" target="_blank">Link <img width="10" border="0" src="images/icon_new_window.gif"></a>
                                    {/if}
                                </td>
                                {if isset($admindata.access.editAccounts)}
                                <td>
                                    <a href="javascript:void(0);" onclick="{literal}if(confirm('ยืนยันการลบ?')) {$.get('?cmd=accounteventhandle&action=delete&eventId={/literal}{$aList.id}{literal}', function (data) { window.location.reload(true); });}{/literal}" class="delbtn right"><small>[Delete]</small></a>
                                </td>
                                {/if}
                            </tr>
                            {/foreach}
                        {else}
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <p align="center">ไม่พบข้อมูล</p>
                            </td>
                        </tr>
                        {/if}
                    </tbody>
                    </table>
                    
                </div>
                
            </td>
        </tr>
        </table>
        
    </div>

    
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">

            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>

        </div>
        <div class="clear"></div>
    </div>
</div>