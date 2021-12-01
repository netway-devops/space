{include file="$tplPath/admin/header.tpl"}

<script type="text/javascript" src="{$template_dir}js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{$template_dir}js/ckfinder/ckfinder.js"></script>
<script type="text/javascript">

var kbId            = {$kbId};

{literal}

$(document).ready(function () {
    
    $('.catalogDetail').each(function (i) {
        $(this).change( function () {
            $(this).parent().addLoader();
            updateIncidentKB ($(this).attr('id'), $(this).val());
            
        });
    });
    
    $('.policy').hide();
    
});

function updateIncidentKB (field, value)
{
    $.post('?cmd=servicecataloghandle&action=updateIncidentKB', {
        id      : kbId,
        field   : field,
        value   : value
        }, function (data) {
        
        parse_response(data);
        $('#preloader').remove();
        
    });
}

function publsihIncidentKB ($status)
{
    $('.mmfeatured').parent().addLoader();
    updateIncidentKB ('publish', $status);
}

function changeIncidentKBOwner ($staffId)
{
    $('.mmfeatured').parent().addLoader();
    updateIncidentKB ('staff', $staffId);
    location.reload();
}

function changeIncidentKBCategory ($categoryId)
{
    $('.mmfeatured').parent().addLoader();
    updateIncidentKB ('category', $categoryId);
}

function changePolicy (policyId)
{
    $('.policy').hide();
    $('#policy'+ policyId).show();
    $('.mmfeatured').parent().addLoader();
    updateIncidentKB ('policy', policyId);
}

{/literal}
</script>

<div class="mmfeatured">
<div class="mmfeatured-inner">
    
    {if ! $isEditable}
    <div align="center" class="imp_msg" style="margin-top:10px;">
        <strong>Level 1:</strong> คุณไม่ใช่เจ้าของข้อมูล Incident KB นี้ จะต้องแจ้งเจ้าของข้อมูลหากต้องการให้มีการเปลี่ยนแปลง
    </div>
    {/if}
    
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
    <tbody>
    <tr valign="top">
        <td width="60%">
            
        <h2><span style="display: block; font-size: 0.8em;">หัวข้อ: เพื่อให้เข้าใจได้ง่ายว่ากำลังพูดถึงเรื่องอะไร</span><input type="text" id="title" name="title" value="{$oKB->title}" class="catalogDetail" style="line-height: 2em; font-size: 1.4em; width: 99%;" /></h2>
        
        <div class="bborder">
            <div class="bborder_content">
                <table width="100%" cellspacing="0" cellpadding="5">
                <tbody>
                <tr>
                    <td>
                        <select id="categoryId" name="categoryId" onchange="changeIncidentKBCategory($(this).val())" class="styled inp" style="width: 100%;">
                        {foreach from=$aCategory item=arr key=k}
                        <option value="{$arr.id}" {if $arr.id == $oKB->category_id} selected="selected" {/if}> {$arr.level} {$arr.name} </option>
                        {/foreach}
                        </select>
                    </td>
                    <td align="right" width="100">
                        <a href="?cmd=servicecataloghandle&action=browse&type=incidentKB" target="_blank">จัดการหมวด</a>
                    </td>
                </tr>
                </table>
            </div>
        </div>
        
        <div class="mmdescr">
            <p>
            <span style="display: block; font-size: 1em;">สาเหตุและวิธีตรวจสอบปัญหา</span>
            <textarea id="description" name="description" rows="3" class=" styled inp" style="width:99%;">{$oKB->description}</textarea>
            <script language="JavaScript">
            {literal}
            CKEDITOR.replace('description', {toolbar:'Basic', width:'100%', height:'200px'});
            CKEDITOR.add;
            $(document).ready(function () {
                CKEDITOR.instances.description.on('blur', function() {
                    $('#description').parent().addLoader();
                    updateIncidentKB ('description', CKEDITOR.instances.description.getData());
                });
                CKEDITOR.instances.description.on('afterPaste', function(event) {
                    updateEditorData(event);
                });
                CKFinder.setupCKEditor( CKEDITOR.instances.description , '/7944web/templates/default/js/ckfinder');
            });
            {/literal}
            </script>
            </p>
        </div>
        
        </td>
        <td width="40%">
            
            <p style="line-height: 2em;">&nbsp;</p>
            
            <div class="bborder" style="display: block; width: 400px;">
                <div class="bborder_header">ตั้งค่าเพิ่มเติม</div>
                <table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
                <tbody>
                <tr>
                    <td width="100">Publish:</td>
                    <td>
                        <input type="radio" name="publish" onclick="publsihIncidentKB(1);" value="1" {if $oKB->is_publish == '1'} checked="checked" {/if} /> Yes
                        <input type="radio" name="publish" onclick="publsihIncidentKB(0);" value="0" {if $oKB->is_publish == '0'} checked="checked" {/if} /> No
                    </td>
                </tr>
                <tr>
                    <td>SLA:</td>
                    <td>
                        <input type="text" id="slainminute" name="slainminute" value="{$oKB->sla_in_minute}" size="3" class="catalogDetail styled inp" /> นาที
                    </td>
                </tr>
                <tr>
                    <td>ผู้รับผิดชอบ:</td>
                    <td>
                        <select id="staff" name="staff" onchange="changeIncidentKBOwner($(this).val())" class="styled inp" style="width: 100%;">
                            {foreach from=$aStaff key="k" item="v" }
                            <option value="{$k}" {if $k == $oKB->staff_id} selected="selected" {/if}>{$v}</option>
                            {/foreach}
                        </select>
                        *จะมีอีเมล์ไปแจ้ง staff ที่เลือก
                    </td>
                </tr>
                <tr valign="top">
                    <td>
                        Escalation Policy:<br />
                        <a href="?cmd=editadmins&action=administrator&id={$oKB->staff_id}" target="_blank">แก้ไข</a>
                    </td>
                    <td>
                         (เงื่อนไขในการส่งต่องาน support ticket สำหรับ Incident KB นี้<br />
                         <input type="radio" name="escalation_policy" value="1" onclick="changePolicy(1)" {if $oKB->escalation_policy == 1} checked="checked" {/if} />เร่งด่วนสุดสุด<br />
                         <div id="policy1" class="policy"><small>{$oOwner->policy1|nl2br}</small></div>
                         <input type="radio" name="escalation_policy" value="2" onclick="changePolicy(2)" {if $oKB->escalation_policy == 2} checked="checked" {/if} />เร่งด่วน<br />
                         <div id="policy2" class="policy"><small>{$oOwner->policy2|nl2br}</small></div>
                         <input type="radio" name="escalation_policy" value="3" onclick="changePolicy(3)" {if $oKB->escalation_policy == 3} checked="checked" {/if} />รอได้<br />
                         <div id="policy3" class="policy"><small>{$oOwner->policy3|nl2br}</small></div>
                    </td>
                </tr>
                </tbody>
                </table>
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
        
        {include file="$tplPath/admin/view_incident_kb_detail.tpl"}
        
    </td>
    <td width="50%">
        
        {include file="$tplPath/admin/view_reply.tpl"}
        
    </td>
</tr>
</tbody>
</table>

</div>
</div>

{include file="$tplPath/admin/footer.tpl"}
