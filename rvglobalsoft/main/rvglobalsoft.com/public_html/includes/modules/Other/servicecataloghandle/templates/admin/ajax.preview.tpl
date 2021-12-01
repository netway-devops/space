<script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/packed.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />

<style type="text/css">
{literal}
.tabb > h3 {}
.tabb > p {  border: 1px solid #CCCCCC; padding: 5px; background-color:#EFEFEF; }
{/literal}
</style>

<div id="formcontainer">
    <div id="formloader">
        
        {if isset($oKB->id)}
            <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr>
                <td class="conv_content form"  valign="top">
                    
                    <div class="tabb">
                        <h2>{$oKB->title} {if $oKB->is_publish == '1'} <small style="color:green;">Publish</small> {else} <small style="color:gray;">Un-Publish</small> {/if}</h2>
                        
                        <!-- Start content -->
                        
                        {foreach from=$aCategory item=arr key=k}
                            {if $arr.id == $oKB->category_id} {$arr.level} {$arr.name} {/if}
                        {/foreach}
                        <div>
                        ผู้รับผิดชอบ: {foreach from=$aStaff key="k" item="v"} {if $k == $oKB->staff_id} {$v} {/if} {/foreach} &nbsp;&nbsp;&nbsp; SLA: {$oKB->sla_in_minute} นาที
                        </div>
                        <p>
                            {$oKB->description}
                        </p>
                        
                        <h3>ข้อมูลสำหรับ Helpdesk</h3>
                        
                        <p>
                            {$oKB->detail_helpdesk}
                        </p>
                        
                        <div>&nbsp;</div>
                        
                        <h3>ข้อมูลสำหรับ Support</h3>
                        
                        <p>
                            {$oKB->detail_support}
                        </p>
                        
                        
                        <!-- End content -->
                        
                    </div>
                    
                </td>
            </tr>
            </table>
        {else}
            <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr>
                <td class="conv_content form"  valign="top">
                    
                    <div class="tabb">
                        <h2>{$oCatalog->title} {if $oCatalog->is_publish == '1'} <small style="color:green;">Publish</small> {else} <small style="color:gray;">Un-Publish</small> {/if}</h2>
                        
                        <!-- Start content -->
                        
                        {foreach from=$aCategory item=arr key=k}
                            {if $arr.id == $oCatalog->category_id} {$arr.level} {$arr.name} {/if}
                        {/foreach}
                        <div>
                        ผู้รับผิดชอบ: {foreach from=$aStaff key="k" item="v"} {if $k == $oCatalog->staff_id} {$v} {/if} {/foreach} &nbsp;&nbsp;&nbsp; SLA: {$oCatalog->sla_in_minute} นาที
                        </div>
                        <p>
                            {$oCatalog->description}
                        </p>
                        
                        <h3>Business Service Catalogue (BSC)</h3>
                        
                        <p>
                        1. รายละเอียดบริการ และ FAQs
                        <div>{$oBusiness->service_detail}</div>
                        </p>
                        
                        <p>
                        2. สิทธิในการร้องขอ (อนาคตจะทำ automation ให้ ตอนนี้ให้ list รายการมาก่อน)
                        <div>{$oBusiness->request_permission}</div>
                        </p>
                        
                        <p>
                        3. ขั้นตอนการสั่งซื้อ หรือ ร้องขอ <small> (กรณีเป็นบริการที่ยกเลิก หรือให้บริการเฉพาะลูกค้าเก่า ให้ระบุให้ชัดเจน)</small>
                        <div>{$oBusiness->request_order}</div>
                        </p>
                        
                        <p>
                        4. เงื่อนไขในการเริ่มดำเนินการส่งมอบ
                        <div>{$oBusiness->order_time_available}</div>
                        </p>
                        
                        <p>
                        5. ระยะเวลาในการส่งมอบ
                        <div>{$oBusiness->delivery_time}</div>
                        </p>
                        
                        <p>
                        6. ราคา <small> (ระบุให้ชัดเจนว่า อะไรฟรี อะไรเสียตังค์ อะไรต้องซื้อ บริการเสริม)</small>
                        <div>{$oBusiness->price_rate}</div>
                        </p>
                        
                        <p>
                        7. บริการอื่น ๆ ที่เกียวข้อง <small>(link ไปยัง service catalog นั้น ๆ แบบ new windows)</small>
                        <div>{$oBusiness->service_related}</div>
                        </p>
                        
                        <p>
                        8. ข้อห้ามในการใช้บริการ <small>(เช่น reserved domain, porn, game, proxy, vpn, voip)</small>
                        <div>{$oBusiness->service_policy}</div>
                        </p>
                        
                        <p>
                        9. เจ้าหน้าที่ขาย <small> (ระบุชื่อ และ pipeline)</small>
                        <div>
                            {foreach from=$aPipedrive item="aPipe" key="k"}
                            {foreach from=$aPipe.staff item="v2" key="k2"}
                            {assign var="x1" value=$aPipe.name}
                            {assign var="x2" value="#$k $x1 $v2($k2)"}
                            {if $oBusiness->sale_person == $x2} {$aPipe.name} - {$v2} {/if}
                            {/foreach}
                            {/foreach}
                        </div>
                        </p>
                        
                        <p>
                        10. การรับประกัน / คืนเงิน
                        <div>{$oBusiness->warranty_rate}</div>
                        </p>
                        
                        <div>&nbsp;</div>
                        
                        <h3>Technical Service Catalogue (hidden from users)</h3>
                        
                        <p>
                        11. Recovery and fallback information
                        <div>{$oTechnical->recovery_info}</div>
                        </p>
                        
                        <p>
                        12. ข้อมูลกรณีฉุกเฉิน ให้ดำเนินการอย่างไร แจ้งใคร
                        <div>{$oTechnical->emergency_info}</div>
                        </p>
                        
                        
                        <!-- End content -->
                        
                    </div>
                    
                </td>
            </tr>
            </table>
        {/if}
        
    </div>
    
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>
</div>