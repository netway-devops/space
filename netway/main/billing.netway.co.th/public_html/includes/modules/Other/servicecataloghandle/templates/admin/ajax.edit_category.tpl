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
                    <h3>แก้ไข Category สำหรับ {if $type == 'incidentKB'}Incident KB{else}Service Catalog{/if} </h3>
                    
                    <form method="post" action="" id="editCategoryForm" >
                    {securitytoken}
                    <input type="hidden" name="id" value="{$aData.id}" />
                    <input type="hidden" name="type" value="{$type}" />
                    
                    <table width="100%" cellspacing="0" cellpadding="0" style="padding:15px;background:#F5F9FF;">
                    <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>หมวดหลัก</label>
                            </td>
                            <td>
                                <select name="parentId">
                                    <option value="0"> --- หมวดหลัก ---</option>
                                    {foreach from=$aLists item=arr key=k}
                                    <option value="{$arr.id}" {if $arr.id == $aData.parent_id} selected="selected" {/if} {if $arr.isDisable} disabled="disabled"{/if}> {$arr.level} {$arr.name} </option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                            <td>
                                <label>ชื่อหมวด</label>
                            </td>
                            <td>
                                <input type="text" name="name" value="{$aData.name}" size="40" />
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td><br ><br ></td>
                            <td>
                                <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return editCategory()"><span>Update</span></a></span>
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
    
    function editCategory ()
    {
        $('.spinner').show();
        $.post('?cmd=servicecataloghandle&action=updateCategory', $('#editCategoryForm').serializeObject(), function (a) {
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