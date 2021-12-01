
<style type="text/css">
{literal}
ul.tocSection { list-style: none; padding:0px; margin:0px; }
ul.tocSection > li { border: 1px dotted #CCCCCC; line-height: 28px; width: 99%; position: relative; margin-top: 25px; }
ul.tocSection > li > label { background-color:#EEEEEE; display:block; padding:2px; position: absolute; top: -10px; left: 10px; }
ul.tocSection > li  p { margin: 0px; padding: 5px; }
.imp_msg_error {
    display: block; 
    background-color: rgb(255, 232, 232); 
    color: red; border: 1px solid red;
    line-height: 1.4em;
    padding: 5px;
    }
.tocContentDesc { padding: 10px; display: block;}
{/literal}
</style>

{if $scId != $aSelected.sc_id && $aSelected.sc_id}
<div align="center" class="imp_msg_error" style="margin-top:10px;">
    {if $aSelected.request_type == 'Service Request'}
    <strong>Ticket#{$ticketId}: ผูกกับ Service Catalog <a href="javascript:void(0);" onclick="displayServiceCatalog(); return false;">#{$aSelected.sc_id} {$aSelected.title}</a></strong> ให้ระวังการเปลี่ยน Service Catalog มีผลกับ SLA 
    {else}
    <strong>Ticket#{$ticketId}: ผูกกับ Incident KB <a href="javascript:void(0);" onclick="displayServiceCatalog(); return false;">#{$aSelected.sc_id} {$aSelected.title}</a></strong> ให้ระวังการเปลี่ยน Incident KB มีผลกับ SLA 
    {/if}
</div>
<br />
{/if}

<div>
    <ul class="serviceCatalogTab">
        <li><a href="javascript:void(0);" onclick="selectServiceCatalogTab('info');">ข้อมูล</a></li>
        <li><a href="javascript:void(0);" onclick="selectServiceCatalogTab('policy');">Escalation</a></li>
        <li style="{if $aSelected.sc_id != $aData.id} display: none; {/if}"><a href="javascript:void(0);" onclick="selectServiceCatalogTab('fulfillment');">Fulfillment</a></li>
        <li style="{if $aSelected.sc_id == $aData.id} display: none; {/if}" style="text-align: center;">
            {if $aSelected.sc_id != $aData.id}
            <a href="javascript:void(0);" onclick="useThisServiceCatalog({$ticketId}, {$aData.id})"
                class="menuitm greenbtn" style="line-height: 20px; width: 70px; text-align: center; font-size: 16px; position: relative; margin-top: -10px; display: block;"
                title="ใช้ Service Catalog Template นี้">+ ใช้งาน</a>
            {/if}
        </li>
    </ul>
    <div id="serviceCatalogPolicy">
        <h3>Escalation Policy</h3>
        <p>กรณีที่ไม่สามารถดำเนินการเองได้ให้ ทำการ escalate ticket (ส่งต่อ) ด้วยวิธีการต่อไปนี้ <b>ตามลำดับ</b> จนกว่า จะ <b>ตอบคำถามลูกค้าได้</b> หรือ ticket ถูก <b>assign ไปยังผู้รับผิดชอบคนใหม่</b> </p>
        <p><br />{$aData.escalationPolicy|nl2br}<br /><br /></p>
    </div>
    <div id="serviceCatalogInfo">
        
        {if ! $aData.is_publish}
        <div align="center" class="imp_msg" style="margin-top:10px;">
            <strong>เอกสารยังไม่เผยแพร่:</strong> หากต้องการข้อมูลเพิ่มเติมให้ติดต่อ Service Catalog Owner
        </div>
        <br />
        {/if}
        
        <div>
            
            <h2><span style="color: gray; font-size: 0.8em; ">{$aData.catName}</span> &nbsp;&nbsp;&nbsp; {$aData.title} &nbsp; [<a href="?cmd=servicecataloghandle&action=view&id={$aData.id}" style="color:red;" target="_blank">แก้ไข</a>]</h2>
            
            <table width="100%" cellpadding="2" cellspacing="2" border="0" class="imp_msg_data">
            <tbody>
            <tr>
                <td width="70%"><strong>SLA เหลือเวลา:</strong> <span {if $aSelected.is_pause != '1' && $aSelected.endDate != '0'} data-countdown="{$aData.endingSLA}" {/if}>{if $aSelected.is_pause == '1' || $aSelected.endDate == '0'} ใช้เวลา {$aSelected.time_in_minute} นาที จากที่กำหนดไว้ {$aSelected.sla_in_minute} นาที {/if}</span></td>
                <td><strong>Staff Owner:</strong> {$aData.firstname}</td>
            </tr>
            </tbody>
            </table>
            
            <p><br />{$aData.description}<br /><br /></p>
            
        </div>
        
        <div><p>&nbsp;</p></div>
        
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr valign="top">
            <td>
                
                <div style="width: 100%; position: relative;">
                    <label style="display:block; padding:2px; position: absolute; top: 0px; right: 0px;"><a href="">Suggestion (0)</a></label>
                </div>
                
                <h2 id="tocBSC" style="border-bottom: 1px solid #AAAAAA;">Business Service Catalogue (BSC)</h2>
                
                <ul class="tocSection" style="display: block;">
                    
                    <li>
                        <label id="tocFAQ">1. รายละเอียดบริการ และ FAQs</label>
                        {if $aData.service_detail}<p>&nbsp;</p><p class="tocContentDesc">{$aData.service_detail}</p>{/if}
                    </li>
                    
                    <li>
                        <label id="tocPerm">2. สิทธิในการร้องขอ (อนาคตจะทำ automation ให้ ตอนนี้ให้ list รายการมาก่อน)</label>
                        {if $aData.request_permission}<p>&nbsp;</p><p class="tocContentDesc">{$aData.request_permission}</p>{/if}
                    </li>
                    
                    <li>
                        <label id="tocOrder">3. ขั้นตอนการสั่งซื้อ หรือ ร้องขอ <small> (กรณีเป็นบริการที่ยกเลิก หรือให้บริการเฉพาะลูกค้าเก่า ให้ระบุให้ชัดเจน)</small></label>
                        {if $aData.request_order}<p>&nbsp;</p><p class="tocContentDesc">{$aData.request_order}</p>{/if}
                    </li>
                    
                    <li>
                        <label id="tocTime">4. เงื่อนไขในการเริ่มดำเนินการส่งมอบ<!--เวลาที่สามารถซื้อได้ <small>(เช่น ตลอด 24 ชั่วโมง, ในเวลาทำการ)</small>--></label>
                        {if $aData.order_time_available}<p>&nbsp;</p><p class="tocContentDesc">{$aData.order_time_available}</p>{/if}
                    </li>
                    
                    <li>
                        <label id="tocPrice">5. ราคา <small> (ระบุให้ชัดเจนว่า อะไรฟรี อะไรเสียตังค์ อะไรต้องซื้อ บริการเสริม)</small></label>
                        {if $aData.price_rate}<p>&nbsp;</p><p class="tocContentDesc">{$aData.price_rate}</p>{/if}
                    </li>
                    
                    <li>
                        <label id="tocRelate">6. บริการอื่น ๆ ที่เกียวข้อง <small>(link ไปยัง service catalog นั้น ๆ แบบ new windows)</small></label>
                        {if $aData.service_related}<p>&nbsp;</p><p class="tocContentDesc">{$aData.service_related}</p>{/if}
                    </li>
                    
                    <li>
                        <label id="tocReserv">7. ข้อห้ามในการใช้บริการ <small>(เช่น reserved domain, porn, game, proxy, vpn, voip)</small></label>
                        {if $aData.service_policy}<p>&nbsp;</p><p class="tocContentDesc">{$aData.service_policy}</p>{/if}
                    </li>
                    
                    <li>
                        <label id="tocSale">8. เจ้าหน้าที่ขาย <small> (ระบุชื่อ และ pipeline)</small></label>
                        {if $aData.sale_person}<p>&nbsp;</p><p class="tocContentDesc">{$aData.sale_person}</p>{/if}
                    </li>
                    
                    <li>
                        <label id="tocVarant">9. การรับประกัน / คืนเงิน</label>
                        {if $aData.warranty_rate}<p>&nbsp;</p><p class="tocContentDesc">{$aData.warranty_rate}</p>{/if}
                    </li>
                    
                    
                </ul>
                
                <div><p>&nbsp;</p></div>
                
            </td>
        </tr>
        <tr>
            <td>
                {include file="$tplPath/admin/view_reply.tpl"}
            </td>
        </tr>
        </table>
        <div class="clearBoth"></div>

    </div>
    <div id="serviceCatalogFulfillment">
        <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr valign="top">
            <td>
                {* ทำให้ระบบ service catalog error ให้แมนแก้ไข include file="$tplPath/admin/view_fulfillment.tpl"*}
            </td>
        </tr>
        </table>
        <div class="clearBoth"></div>
    </div>
</div>
<div class="clearBoth"><p>&nbsp;</p></div>

<script language="JavaScript">

var ticketId        = {$ticketId};
var catId           = {$catId};
var scId            = {$scId};
var scShowTab       = {if $aSelected.is_fulfillment && $aData.id == $aSelected.sc_id} 'fulfillment' {else} 'info' {/if};

{literal}

$(document).ready(function () {
    
    selectServiceCatalogTab(scShowTab);
    
    $('[data-countdown]').each(function() {
        var $this   = $(this), finalDate = $(this).data('countdown');
        $this.countdown(finalDate, {elapse: true}, function(event) {
            $this.html(event.strftime('%D วัน %H ชั่วโมง %M นาที'));
        })
        .on('update.countdown', function(event) {
            var $this   = $(this);
            if (event.elapsed) {
                $this.html(event.strftime('<em style="color:red">- %D วัน %H ชั่วโมง %M นาที %S วินาที</em>'));
            }
        });
    });
    
    $('.tocSection a').attr('target', '_blank');
    
    $('.tocSection a[href*="cmd=servicecataloghandle&action=view&id="]').each( function (i) {
        $(this).click( function () {
            var fbUrl   = $(this).prop('href') +'&action=preview';
            $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
            return false;
        });
        
    });
    
});

function tocNavigateTo (id)
{
    $('html, body').animate({ scrollTop: $(''+id+'').offset().top-50}, 500);
    return false;
}

function useThisServiceCatalog (ticketId, id)
{
    $('#serviceRequestDisplay').parent().addLoader();
    $.post('?cmd=supportcataloghandle&action=useThisServiceCatalog', {
        ticketId    : ticketId,
        scId        : id
        }, function (a) {
        parse_response(a);
        $('#preloader').remove();
        $('#replytable').unblock();
        loadServiceCatalog( catId +'.'+ id );
        displayReplyTicketIfAssignedClient();
    });
    
    return false;
}

function gotoSelectedServiceCatalog (id)
{
    
    var n       = $('#listBoxContentlistSubCategory').find('div').find('div').length;
    
    for (var i = 0; i < n; i++) {
        var item    = $('#listSubCategory').jqxListBox('getItem', i );
        console.log(id); console.log(item.value);
        if (id == item.value) {
            $('#listSubCategory').jqxListBox('selectIndex', i ); 
            $('#listSubCategory').jqxListBox('ensureVisible', i ); 
            loadServiceCatalog(id); 
        }
    }
    
    return false;
}

function selectServiceCatalogTab (tab)
{
    $('.serviceCatalogTab li').css('background-color', '#FFFFFF');
    
    $('#serviceCatalogInfo').hide();
    $('#serviceCatalogPolicy').hide();
    $('#serviceCatalogFulfillment').hide();
    
    if (tab == 'info') {
        $('.serviceCatalogTab li:eq(0)').css('background-color', '#CCCCCC');
        $('#serviceCatalogInfo').show();
    } else if (tab == 'policy') {
        $('.serviceCatalogTab li:eq(1)').css('background-color', '#CCCCCC');
        $('#serviceCatalogPolicy').show();
    } else {
        $('.serviceCatalogTab li:eq(2)').css('background-color', '#CCCCCC');
        $('#serviceCatalogFulfillment').show();
    }
    
}

{/literal}
</script>


