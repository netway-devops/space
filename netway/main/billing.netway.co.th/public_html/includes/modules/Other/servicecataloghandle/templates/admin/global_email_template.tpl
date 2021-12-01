{include file="$tplPath/admin/header.tpl"}


<div class="mod_desc">
<div class="headshelf">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
    <tbody>
    <tr>
        <td width="70%">Subject</td>
        <td class="mrow1">Action</td>
    </tr>
    </tbody>
    </table>
</div>
<div class="mmdescr">
    <ul id="grab-sorter" style="width:100%">
        <li style="border:none; line-height: 28px;">
            
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tbody>
            <tr>
                <td width="70%">
                    <a href="?cmd=servicecataloghandle&action=addGlobalTemplate" onclick="$('#newGlobalTemplate').toggle();return false;" style="margin-right: 30px;font-weight:bold;" class="menuitm"><span class="addsth">Add New</span></a>
                </td>
                <td class="mrow1">
                    <a href="?cmd=servicecataloghandle&action=sortGlobalTemplate" class="menuitm menuf sortGlobalTemplate">เรียงลำดับ</a>
                </td>
            </tr>
            <tr id="newGlobalTemplate" style="display: none;">
                <td>
                    
                <table width="500" cellspacing="0" cellpadding="0" border="0">
                <tbody style="background:#ffffff; border-top:solid 1px #ddd;">
                    <tr class="havecontrols" style="border-bottom:solid 1px #ddd;">
                        <td>
                            <label>หัวข้อ template เกี่ยวกับ</label>
                        </td>
                        <td>
                            <input type="text" id="subject" name="subject" value="" size="40" style="width: 90%; line-height: 1.4em;" />
                        </td>
                        <td>
                            <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return addGlobalTemplate()"><span>Add</span></a></span>
                        </td>
                    </tr>
                </tbody>
                </table>
                
                </td>
                <td>&nbsp;</td>
            </tr>
            </tbody>
            </table>
            
        </li>
        {if $aLists|@count}
        {foreach from=$aLists item=aList}
        <lii style="background-color: #FFFFFF; line-height: 24px;">
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="whitetable fs11 statustables">
            <tbody>
            <tr>
                <td width="70%">
                    &nbsp;&nbsp; {$aList.subject}
                </td>
                <td class="mrow1">
                    <a href="?cmd=servicecataloghandle&action=editGlobalTemplate&id={$aList.id}" class="menuitm menuc editCategory">แก้ไข</a>
                    <a href="?cmd=servicecataloghandle&action=deleteGlobalTemplate&id={$aList.id}" onclick="return confirm('ยืนยันการลบ?');" class="menuitm menul"><span style="color:#FF0000">ลบ</span></a>
                </td>
            </tr>
            </tbody>
            </table>
        </li>
        {/foreach}
        {else}
        <li style="background-color: #FFFFFF; line-height: 24px;">
            <p align="center">--- ยังไม่มีข้อมูล ---</p>
        </li>
        {/if}
    </ul>
    

</div>
</div>

<script type="text/javascript">
{literal}

$(document).ready(function () {
    $('.sortGlobalTemplate').click(function () {
        var fbUrl   = $(this).prop('href');
        $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    });
});

function addGlobalTemplate ()
{
    var subject     = $('#subject').val();
    
    if (subject == '') {
        alert('กรุณาระบุหัวข้อ template');
        return false;
    }
    
    $.post('?cmd=servicecataloghandle&action=addGlobalTemplate', {subject:subject}, function (a) {
        var data        = a.data;
        var oDatas      = $.parseJSON(data);
        
        document.location = '?cmd=servicecataloghandle&action=editGlobalTemplate&id='+ oDatas.id;
        
    });
    
    return false;
}

{/literal}
</script>

{include file="$tplPath/admin/footer.tpl"}
