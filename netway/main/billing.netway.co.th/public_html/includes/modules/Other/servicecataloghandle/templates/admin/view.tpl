{include file="$tplPath/admin/header.tpl"}

    
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

<script type="text/javascript" src="{$template_dir}js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{$template_dir}js/ckfinder/ckfinder.js"></script>
<script type="text/javascript">

var serviceCatalogId        = {$serviceCatalogId};

{literal}

$(document).ready(function () {
    
    $('.catalogDetail').each(function (i) {
        $(this).change( function () {
            $(this).parent().addLoader();
            updateServiceCatalog ($(this).attr('id'), $(this).val());
            
        });
    });
    
    $('.policy').hide();
    
});

function updateServiceCatalog (field, value)
{
    $.post('?cmd=servicecataloghandle&action=updateServiceCatalog', {
        id      : serviceCatalogId, 
        field   : field, 
        value   : value
        }, function (data) {
        
        parse_response(data);
        $('#preloader').remove();
        
    });
}

function publsihServiceCatalog ($status)
{
    $('.mmfeatured').parent().addLoader();
    updateServiceCatalog ('publish', $status);
}

function changeServiceCatalogOwner ($staffId)
{
    $('.mmfeatured').parent().addLoader();
    updateServiceCatalog ('staff', $staffId);
}

function changeServiceCatalogCategory ($categoryId)
{
    $('.mmfeatured').parent().addLoader();
    updateServiceCatalog ('category', $categoryId);
}

function updateSalePerson (val)
{
    $('.mmfeatured').parent().addLoader();
    updateServiceCatalog ('salePerson', val);
}

function changePolicy (policyId)
{
    $('.policy').hide();
    $('#policy'+ policyId).show();
    $('.mmfeatured').parent().addLoader();
    updateServiceCatalog ('policy', policyId);
}

{/literal}
</script>

<div class="mmfeatured">
<div class="mmfeatured-inner">
    
    {if ! $isEditable}
    <div align="center" class="imp_msg" style="margin-top:10px;">
        <strong>Level 1:</strong> คุณไม่ใช่เจ้าของข้อมูล Service Catalog นี้ จะต้องแจ้งเจ้าของข้อมูลหากต้องการให้มีการเปลี่ยนแปลง
    </div>
    {/if}
    
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
    <tbody>
    <tr valign="top">
        
        <td width="40%">
            
            <div class="bborder" style="width: 300px; margin-top: 1.6em;">
                <div class="bborder_header">Link กับ Guide(KB) on Zendesk</div>
                <table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
                <tbody>
                <tr>
                    <td width="100">Guide ID:</td>
                    <td>
                        <input type="text" id="guideId" name="guide_id" value="{$oCatalog->zendesk_guide_id}" readonly="readonly" class="catalogDetail" style="line-height: 2em; font-size: 1.4em; width: 99%;" />
                    </td>
                </tr>
                {if $oCatalog->zendesk_guide_id}
                <tr>
                    <td width="100">Link:</td>
                    <td>
                        <a href="https://support.netway.co.th/hc/th/articles/{$oCatalog->zendesk_guide_id}" target="_blank">{$oCatalog->title}</a>
                    </td>
                </tr>
                {/if}
                </tbody>
                </table>
                
            </div>
            
            <p style="line-height: 2em;">&nbsp;</p>
            
            <div class="bborder" style="display: none; width: 300px;">
                <div class="bborder_header">ตั้งค่าเพิ่มเติม</div>
                <table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
                <tbody>
                <tr>
                    <td width="100">Publish:</td>
                    <td>
                        <input type="radio" name="publish" onclick="publsihServiceCatalog(1);" value="1" {if $oCatalog->is_publish == '1'} checked="checked" {/if} /> Yes
                        <input type="radio" name="publish" onclick="publsihServiceCatalog(0);" value="0" {if $oCatalog->is_publish == '0'} checked="checked" {/if} /> No
                    </td>
                </tr>
                <tr>
                    <td>SLA:</td>
                    <td>
                        <input type="text" id="slainminute" name="slainminute" value="{$oCatalog->sla_in_minute}" size="3" class="catalogDetail styled inp" /> นาที
                    </td>
                </tr>
                <tr>
                    <td>ผู้รับผิดชอบ:</td>
                    <td>
                        <select id="staff" name="staff" onchange="changeServiceCatalogOwner($(this).val())" class="styled inp" style="width: 100%;">
                            {foreach from=$aStaff key="k" item="v" }
                            <option value="{$k}" {if $k == $oCatalog->staff_id} selected="selected" {/if}>{$v}</option>
                            {/foreach}
                        </select>
                        *จะมีอีเมล์ไปแจ้ง staff ที่เลือก
                    </td>
                </tr>
                <tr valign="top">
                    <td>
                        Escalation Policy:<br />
                        <a href="?cmd=editadmins&action=administrator&id={$oCatalog->staff_id}" target="_blank">แก้ไข</a>
                    </td>
                    <td>
                         (เงื่อนไขในการส่งต่องาน support ticket สำหรับ Service Catalog นี้<br />
                         <input type="radio" name="escalation_policy" value="1" onclick="changePolicy(1)" {if $oCatalog->escalation_policy == 1} checked="checked" {/if} />เร่งด่วนสุดสุด<br />
                         <div id="policy1" class="policy"><small>{$oOwner->policy1|nl2br}</small></div>
                         <input type="radio" name="escalation_policy" value="2" onclick="changePolicy(2)" {if $oCatalog->escalation_policy == 2} checked="checked" {/if} />เร่งด่วน<br />
                         <div id="policy2" class="policy"><small>{$oOwner->policy2|nl2br}</small></div>
                         <input type="radio" name="escalation_policy" value="3" onclick="changePolicy(3)" {if $oCatalog->escalation_policy == 3} checked="checked" {/if} />รอได้<br />
                         <div id="policy3" class="policy"><small>{$oOwner->policy3|nl2br}</small></div>
                    </td>
                </tr>
                </tbody>
                </table>
            </div>
            
        </td>
        
        <td width="60%">
            
        <h2><span style="display: block; font-size: 0.8em;">หัวข้อ: เพื่อให้เข้าใจได้ง่ายว่ากำลังพูดถึงเรื่องอะไร</span><input type="text" id="title" name="title" value="{$oCatalog->title}" {if $oCatalog->zendesk_guide_id} disabled="disabled" {/if} class="catalogDetail" style="line-height: 2em; font-size: 1.4em; width: 99%;" /></h2>
        
        <div class="bborder">
            <div class="bborder_content">
                <table width="100%" cellspacing="0" cellpadding="5">
                <tbody>
                <tr>
                    <td>
                        <select disabled="disabled" id="categoryId" name="categoryId" onchange="changeServiceCatalogCategory($(this).val())" class="styled inp" style="width: 100%;">
                        {foreach from=$aCategory item=arr key=k}
                        <option value="{$arr.id}" {if $arr.id == $oCatalog->category_id} selected="selected" {/if}> {$arr.level} {$arr.name} </option>
                        {/foreach}
                        </select>
                    </td>
                    <td align="right" width="100">
                        <!-- <a href="?cmd=servicecataloghandle&action=browse" target="_blank">จัดการหมวด</a> -->
                    </td>
                </tr>
                </table>
            </div>
        </div>
        
        <div class="mmdescr" style="display: none;">
            <p>
            <span style="display: block; font-size: 1em;">เกริ่นนำสั้นๆ 2-4 บรรทัด: เพื่อสื่อให้เห็นข้อมูลโดยรวมเกี่ยวกับ service catalog นี้</span>
            <textarea id="description" name="description" rows="3" class="catalogDetail styled inp" style="width:99%;">{$oCatalog->description}</textarea>
            </p>
        </div>
        
        </td>
    </tr>
    </tbody>
    </table>

</div>
</div>

<table width="100%" border="0" cellpadding="5" cellspacing="0">
<tbody>
<tr valign="top">
    <td width="50%">
        
        {include file="$tplPath/admin/view_fulfillment.tpl"}
        
    </td>
    <td width="50%">
        
    </td>
</tr>
</tbody>
</table>

</div>
</div>

{include file="$tplPath/admin/footer.tpl"}
