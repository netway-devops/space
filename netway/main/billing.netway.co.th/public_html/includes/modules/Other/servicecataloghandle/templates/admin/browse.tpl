{include file="$tplPath/admin/header.tpl"}

{include file="$tplPath/admin/search_box.tpl"}

<script type="text/javascript">
{literal}

$(document).ready(function () {
    $('#addCategory, .sortCategory, .editCategory, .sortServiceCatalog').click(function () {
        var fbUrl   = $(this).prop('href');
        $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    });
    
    $('#grab-sorter li table').hover( 
        function () {
            $(this).css('background-color', '#E5E5E5');
        } , 
        function () {
            $(this).removeAttr('style');
        }
    );
    
    $('.list-service-catalog').each( function () {
        $this   = $(this);
        listServiceCatalog($this, $this.attr('tabindex'), $this.attr('title'));
    });
    
});

function sortServiceCatalog ()
{
    $('.sortServiceCatalog').click(function () {
        var fbUrl   = $(this).prop('href');
        $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    });
}

function previewServiceCatalog (obj)
{
    var fbUrl   = obj.prop('href');
    $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
    return false;
}

function listServiceCatalog (thisObj, $catId, strLevel)
{
    thisObj.parent().addLoader();
    $('.listServiceCatalog'+ $catId).html('');
    
    $.getJSON('?cmd=servicecataloghandle&action=listServiceCatalog&catId='+ $catId +'&type={/literal}{$oInfo->type}{literal}', function (a) {
        var data        = a.data;
        var oDatas      = $.parseJSON(data);
        // var type        = '{/literal}{$oInfo->type}{literal}';
        $('#preloader').remove();
        
        if (! oDatas.length) {
            return;
            $('.listServiceCatalog'+ $catId).append(''
                + '<p align="center">--- ไม่มีข้อมูล ---</p>'
                + '');
            return;
        }
        
        var str         = '<table width="100%" cellspacing="0" cellpadding="0" style="padding:5px;background:#F5F9FF;">'
            + '<tbody style="background:#ffffff; border-top:solid 1px #ddd;">'
            + '<tr><td></td><td style="color:gray;"><!-- สามารถคัดลอก link column นี้ไปไส่ใน {/literal}{if $oInfo->type == 'incidentKB'}Incident KB{else}Service Catalog{/if}{literal} อื่นได้ --></td><td></td></tr>';
        $.each(oDatas, function (index, oData) {
            var aStyle      = (oData.is_publish == '1') ? 'font-weight: bold; color:black;' : 'color:black;';
            var eStyle      = (oData.staff_id == '{/literal}{$aAdmin.id}{literal}' || parseInt(oData.level) > 1) ? '' : 'display: none;';
            var process     = (oData.process) ? '| Process: '+ oData.process +' ' : '';
            var processList = (oData.processList) ? '<span style="padding-left:15px; display:block; color:gray;">'+oData.processList +'</span>' : '';
            
            str         += '<tr>'
                + '<td width="150" style="border-bottom: 1px dotted #AAAAAA;">'+ strLevel +' <span style="'+ aStyle +'"><small style="color:gray;"> <!--'+ oData.firstname  +'--> </small> </span></td>'
                + '<td style="border-bottom: 1px dotted #AAAAAA;">'+ (oData.zendesk_guide_id ? '#'+ oData.id:'') +' ' +'<a href="?cmd=servicecataloghandle&action=view{/literal}{if $oInfo->type == 'incidentKB'}IncidentKB{/if}{literal}&id='+ oData.id +'" target="_blank">'+ oData.title +'</a> | Guide: <a href="https://support.netway.co.th/hc/th/articles/'+ oData.zendesk_guide_id +'" target="_blank">'+ oData.zendesk_guide_id +'</a> '+ process +' '+ processList +'</td>'
                + '<td width="100" style="border-bottom: 1px dotted #AAAAAA;">'
                // + '<a href="?cmd=servicecataloghandle&action=preview&id='+ oData.id +'&type={/literal}{$oInfo->type}{literal}" onclick="previewServiceCatalog($(this)); return false;"><span style="color:blue;">View</span></a>&nbsp;'
                // + '<a href="?cmd=servicecataloghandle&action=view{/literal}{if $oInfo->type == 'incidentKB'}IncidentKB{/if}{literal}&id='+ oData.id +'" target="_blank"><span style="color:green; '+ eStyle +'">แก้ไข</span></a>&nbsp;'
                + (oData.zendesk_guide_id ? '' : '<a href="?cmd=servicecataloghandle&action=delete{/literal}{if $oInfo->type == 'incidentKB'}IncidentKB{else}ServiceCatalog{/if}{literal}&id='+ oData.id +'" onclick="return confirm(\'ยืนยันการลบ?\');"><span style="color:red; '+ eStyle +'">ลบ</span></a>&nbsp;' )
                // + ((index) ? '': '<a href="?cmd=servicecataloghandle&action=sortServiceCatalog&catId='+ $catId +'&type={/literal}{$oInfo->type}{literal}" class="menuitm menuf sortServiceCatalog"><span style="color:blue;">เรียง</span></a>&nbsp;')
                + '</td>'
                + '</tr>';
        });
        str             += '</tbody></table>';
        
        $('.listServiceCatalog'+ $catId).html(str);
        sortServiceCatalog();
    });
    
    return false;
}


{/literal}
</script>

<div class="mod_desc">
<div class="headshelf">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
    <tbody>
    <tr>
        <td width="70%">Category</td>
        <td class="mrow1">Action</td>
    </tr>
    </tbody>
    </table>
</div>
<div class="mmdescr">
    <p>{$oInfo->typeName} จะต้องอยู่ในหมวด level สุดท้าย ไม่มีหมวดย่อยแล้ว</p>
    <ul id="grab-sorter" style="width:100%">
        <li style="border:none; line-height: 28px;">
            
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tbody>
            <tr>
                <td width="70%">
                    <!--<a id="addCategory" href="?cmd=servicecataloghandle&action=addCategory&type={$oInfo->type}" style="margin-right: 30px;font-weight:bold;" class="menuitm"><span class="addsth">Add Category</span></a>-->
                </td>
                <td class="mrow1">
                    <!--<a href="?cmd=servicecataloghandle&action=sortCategory&parentId=0&type={$oInfo->type}" class="menuitm menuf sortCategory">เรียงลำดับ</a>-->
                </td>
            </tr>
            </tbody>
            </table>
            
            <div align="right">
                
            </div>
        </li>
        
        {foreach from=$aCategories item=aCat}
        {if ! $aCat.zendesk_category_id  && ! $aCat.zendesk_section_id }{continue}{/if}
        <li style="background-color: {if $aCat.level == '--- '} #F5F9FF; {else} #FFFFFF; {/if} line-height: 24px;">
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tbody>
            <tr>
                <td width="70%">
                    <a href="#{$aCat.id}" class="list-service-catalog" onclick="listServiceCatalog($(this), {$aCat.id}, '{$aCat.level}')" tabindex="{$aCat.id}" title="{$aCat.level}">{$aCat.level} {$aCat.name} {if $aTotal[$aCat.id]} ({$aTotal[$aCat.id]}) {/if}</a>
                </td>
                <td class="mrow1">
                    <a name="#{$aCat.id}"></a>
                    <!--
                    <a href="{if ! $aCategory[$aCat.id]|@count}#{/if}?cmd=servicecataloghandle&action=sortCategory&parentId={$aCat.id}&type={$oInfo->type}" class="menuitm menuf {if $aCategory[$aCat.id]|@count} sortCategory {else} disabled {/if}">เรียงลำดับ</a>
                    <a href="?cmd=servicecataloghandle&action=editCategory&id={$aCat.id}&type={$oInfo->type}" class="menuitm menuc editCategory">แก้ไข</a>
                    <a href="{if $aCategory[$aCat.id]|@count}#{/if}?cmd=servicecataloghandle&action=deleteCategory&id={$aCat.id}&type={$oInfo->type}" onclick="{if $aCategory[$aCat.id]|@count} return false; {/if} return confirm('ยืนยันการลบ?');" class="menuitm menul {if $aCategory[$aCat.id]|@count} disabled {/if}"><span {if ! $aCategory[$aCat.id]} style="color:#FF0000" {/if}>ลบ</span></a>
                    -->
                </td>
            </tr>
            </tbody>
            </table>
            <div class="listServiceCatalog{$aCat.id}" style="display: block; width: 70%;"></div>
        </li>
        {/foreach}
        
    </ul>
    

</div>
</div>

{include file="$tplPath/admin/footer.tpl"}
