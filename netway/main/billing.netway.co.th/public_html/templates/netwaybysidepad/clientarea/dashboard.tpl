{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientarea/dashboard.tpl.php');
{/php}
{*

Clientarea dashboard - summary of owned services, due invoices, opened tickets

*}
{literal}
<style>
 .ticket-pending{
        background:rgb(37, 158, 203);
        color : #FFFFFF !important;
    }
    .ticket-solved{
         background:rgb(37, 158, 203); 
         color : #FFFFFF !important;
    }
     .ticket-open{
         background:rgb(232, 42, 42);
         color : #FFFFFF !important; 
    }
     .ticket-closed{
         background:#999999;
         color : #FFFFFF !important;
    }
.alert-info {
    background-color: #f5f5f5;
    border-color: #f5f5f5;
    margin-bottom: 20px;
}
.service-box:hover p {
    font-size: 15px;
    font-weight: bold;
    text-align: center;
    margin-top: 15px;
    color: #fff;
}

.service-box p {
    color: #34495E;
    font-size: 15px;
    font-weight: bold;
    text-align: center;
    margin-top: 15px;
}
.service-box  span :hover {
    color: #ffffff;
}
.service-box {
    width: 23%;
    height: 108px;
    margin: 0px 0px 18px 18px;
    border: solid 1px #3b80d9;
}
.service-box:hover {
    width: 23%;
    height: 108px;
    margin: 0px 0px 18px 18px;
    border: solid 1px #3b80d9;
    background-color : #3b80d9;
    
}
.order-more a:hover {
    background:#27AE60;
    border: solid 1px #27AE60;
}
.font-total-14{
    font-size:14px;
}
.font-total-16{
    font-size:16px;
}
.float-button{
    float: right;
}
.right-btns button {
    float: right;
    margin-left: 15px;
    margin-right: 15px;
    margin-bottom: 15px;
}
a.view-ticket:hover{
   border: 1px solid #1082f4;
}
a.view-ticket{
    border: 1px solid #909192;
}
.grey-custom-btn:hover{
    color: #0052cd;
}
 button.support-ticket:hover{
        background:#2263da;
        border-color:#3052cd;
        color:#fff;
        text-decoration : none;
        font-size:16px;
        padding: 4px 8px 4px 8px;
    }
    button.support-ticket {
        background: #ffffff;
        border-color: #3052cd;
        color: #1d3079;
        font-size: 16px;
        padding: 4px 8px 4px 8px;
    }
</style>
{/literal}
<div class="well well-small" style="margin-bottom: 0px;padding: 34px 68px 17px 55px;background-image: linear-gradient(to left, #76fff8 , #0a70f2);">
   
       <p style="font-size: 23px;color: #ffffff;font-weight: 600;">{$lang.welcomeback}  {$login.firstname} {$login.lastname}</p>
    <!-- <span>{$offer_total} {$lang.services}</span> -->
      <p style="color: #141414;font-size:16px;line-height: 25px;">สอบถามสินค้า ผลิตภัณฑ์ และบริการต่างๆ <br>กรุณาคลิกที่ปุ่ม 
          &nbsp;&nbsp;
          <a href="https://support.netway.co.th/hc/th/requests/new" class="btn btn-primary" style="padding: 5px 6px;background-color: #ff9;color: #000;font-weight: 600;border: 2px solid #cd6801;" target="_blank">
              ส่งคำร้องเพื่อติดต่อเจ้าหน้าที่ <i class="fa fa-chevron-right" aria-hidden="true"></i> 
          </a>
     </p>
</div>
{if $isGoogleAuthActive && ! $clientSetGoogleAuth}
<div class="hero-unit">
    <h3>2 Step Verification</h3>
    <p>ลงชื่อเข้าใช้งาน 2 ระดับด้วย Google Authenticatior เพื่อความปลอดภัยในการใช้งานที่สูงขึ้น</p>
    <div align="center">
        <a href="javascript:void(0);" onclick="updateClientSetGoogleAuth(1);$('#GoogleAuthQRCode').show();$(this).parent().hide();" class="btn btn-primary" style="color: white;"><i class="icon-ok icon-white"></i> สนใจ</a>
        <a href="javascript:void(0);" onclick="updateClientSetGoogleAuth(0);$(this).parent().hide();" class="btn btn-link"><i class="icon-remove"></i> ยังไม่สนใจ (เปิดใช้งานภายหลังได้)</a>
    </div>
    <div>&nbsp;</div>
    <div id="GoogleAuthQRCode" style="display: none;">
        <p>
            Scan QRCode เพื่อเพิ่ม Account Google Authenticator<br />
            <img src="{$googleQRCodeUrl}" /><br />
            วิธีการติดตั้ง <a href="https://support.google.com/accounts/answer/1066447?hl=en" target="_blank">https://support.google.com/accounts/answer/1066447?hl=en</a>
        </p>
        <p>
            ดำเนินการดังนี้
            <ul>
                <li>สแกน QRCode ด้วย Google Authenticator</li>
                <li>กรอกตัวเลขของ Account ที่ได้</li>
            </ul>
        </p>
        <p>
            <input type="text" name="googleAuthCode" id="googleAuthCode" value="" size="10" />
            <button class="btn btn-success" onclick="verifyGoogleAuthCode();">
                <i class="icon-ok-sign icon-white"></i>
                ยืนยัน code
            </button>
        </p>
    </div>
</div>
<script language="JavaScript">
{literal}
function updateClientSetGoogleAuth (status)
{
    $.post('?cmd=google_authenticator_for_client&action=updateclientfeature', {status:status}, function () {
        
    });
}
function verifyGoogleAuthCode ()
{
    var code    = $('#googleAuthCode').val();
    if (code === '') {
        alert('กรุณาระบุรหัส 6 หลักที่ได้จาก Google Authenticator App');
        return false;
    }
    $.post('?cmd=google_authenticator_for_client&action=verifygoogleauthcode', {code:code}, function (data) {
        window.location.href    ='index.php?cmd=google_authenticator_for_client&action=setting';
    });
}
{/literal}
</script>
{/if}



<!-- Services -->
{if $offer_total >= 0}
<div class="text-block clear clearfix" style="padding:35px 35px 17px 35px;background: #ffffff;">
    <h5 style="margin: 5px 10px 26px 0;font-size: 20px;"><i class="icon-service-header"></i>{$lang.servicedetails}</h5>
    <div class="separator-down-arrow"></div>
    <div class="line-separaotr" style="margin-top: 19px;"></div>
    
    <div class="clear clearfix ">
        <!-- <div class="service-box" style="background-color:#3b80d8;" >
            <a href="{$gotodotsite}"><span style="color: #ffffff;">Create Free Website</span></a>
            <p style="color: #ffffff;"><i class="icon-domain-service"></i>netway.site</p>
        </div> -->
        
        {if $mydomains>0}
        
        <div class="service-box" >
            <div class="service-box-config">
                <a class="clearstyle btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-config-service"></i>
                </a>
                <ul class="dropdown-menu">
                    <div class="dropdown-padding">
                    {if $expdomains}
                        <li><a href="{$ca_url}clientarea/domains/">{$expdomains_count} {$lang.ExpiringDomains}</a></li>
                    {/if}
                        <li><a href="{$ca_url}checkdomain/">{$lang.ordermore}</a><span></span></li>
                        <li><a href="{$ca_url}clientarea/domains/">{$lang.listmydomains}<span></span></a></li>
                    </div>
                </ul>
            </div>
            <a href="{$ca_url}clientarea/domains"style="text-decoration: none"><p style="margin-top: 34px;font-size: 26px;text-decoration: none;">{$mydomains}</p></a>
            <a href="{$ca_url}clientarea/domains" style="text-decoration:none;">
                <p><i class="icon-domain-service"></i>{$lang.mydomains}</p>
           </a>
        </div>
        {/if}
        
        {foreach from=$offer item=offe}
        	{if $offe.total>0}
        	{assign var="offa" value="1"}
        <div class="service-box">
        	{if $offe.visible}
            <div class="service-box-config">
                <a class="clearstyle btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-config-service"></i>
                </a>
                <ul class="dropdown-menu">
                    <div class="dropdown-padding">
                        <li><a href="{$ca_url}cart/{$offe.slug}/">{$lang.ordermore}</a><span></span></li>
                        <li><a href="{$ca_url}clientarea/services/{$offe.slug}/"> {$lang.servicemanagement}</a><span></span></li>
                    </div>
                </ul>
            </div>
            {/if}
            <a href="{$ca_url}clientarea/services/{$offe.slug}/" style="text-decoration: none"><p style="margin-top: 34px;font-size: 26px;text-decoration: none;">{$offe.total}</p></a>
           <a href="{$ca_url}clientarea/services/{$offe.slug}/" style="text-decoration:none;">
               <p><i class="icon-hosting-service"></i>{$offe.name}</p>
           </a>
        </div>
        	{/if}
		{/foreach}
        
        {if $mydomains>0 || $offa}
        <div class="service-box order-more">
            <a href="{$ca_url}order">
                <i class="icon-order-more"></i>
                <span><p class="order-more-txt" >{$lang.ordermore}</p></span>
            </a>
        </div>
        {/if}
    </div>
 </div>
 {/if}
 <!-- End of Services -->
 
 <!-- Invoices --> 
 {if $dueinvoices}

 <div class="text-block clear clearfix" style="padding: 17px 35px 17px 35px;">
    <h5 style="margin: 5px 10px 26px 0;font-size: 20px;"><i class="icon-service-invoice"></i>{$lang.invoices}</h5>
    <div class="separator-down-arrow"></div>
    <div class="line-separaotr" style="margin-top: 19px;"></div>
    
    <div class="clear clearfix">
        <div class="table-box">
            <div class="table-header">
                <p>{$lang.dueinvoices} {if $acc_balance && $acc_balance>0}<span class="redone">{$acc_balance|price:$currency}</span>{/if}</p>
            </div>
            <div class="right-btns" style="margin: 15px 0px 16px 0px;">
            <form id="payallForm" method="post" action="index.php" style="margin:0px">
                {if $enableFeatures.bulkpayments!='off'} <input type="hidden" name="action" value="payall"/>{else} <input type="hidden" name="action" value="invoices"/>{/if}
                <input type="hidden" name="cmd" value="clientarea"/>
                <button type="submit" id="payAllInvoice" name="payAllInvoice" class=" btn btn-success" ><i class="icon-success"></i> {if isset($oAdmin->id)}รวม Invoice ที่เลือก{else}{$lang.paynowdueinvoices}{/if}</button>
                <button type="button" id="selectInvoice" class="btn btn-success" style="display: none; letter-spacing: 0px; font-size: 16px;"><i class="icon-edit icon-white"></i> เลือกรายการ Invoice ที่ต้องการชำระพร้อมกัน</button>
            </form>
                </div>
            <table class="table table-striped table-hover">
                <tr class="table-header-row">
                    <th class="select-invoice w5" style="display:none;">#</th>
                    <th class="font-total-16 w25 th-invoice"style="padding: 10px" >{$lang.invoicenum}  <i class=" fa fa-angle-up" style="color:#626466;font-weight: bold;"></i></th>
                     <th class=" font-total-16 w30 cell-border th-invoice">Description</th>
                    <th class=" font-total-16 w25 cell-border th-invoice">{$lang.total}</th>
                    <th class=" font-total-16 w25 cell-border th-invoice">{$lang.duedate}</i></th>                 
                </tr>
                <tr class="table-header-row" id="selectedInvoiceItems" style="display:none;">
                    <th colspan="5">รายการที่เลือก</th>
                </tr>
                <tr id="selectedInvoiceEnd" style="display:none;">
                    <th colspan="5" style="padding: 3px 0px;background-color: #8f8f8f;"></th>
                </tr>
                {foreach from=$dueinvoices item=invoice name=foo}
                <tr valign="top"  class="hover-tr" style="{if in_array($invoice.id, $aCompoundInvoice)} display: none; {/if}">
                    <td class="select-invoice" style="display:none;"><input type="checkbox" name="invoiceSelected[]" value="{$invoice.id}" onclick="addToSelectedInvoiceItems(this);" style="{if in_array($invoice.id, $aMainCompoundInvoice)} display: none; {/if}" /></td>
                    <td>
                        <a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank" style="font-size: 16px;text-decoration: none;">    
                        {if $proforma &&  ($invoice.status=='Paid' || $invoice.status=='Refunded') && $invoice.paid_id!=''}{$invoice.paid_id}{else}{$invoice.date|invprefix:$prefix}{$invoice.id}{/if}
                        &nbsp; &nbsp; &nbsp;<span class="label label-{$invoice.status}"style="font-size: 16px">{$invoice.status}</span>
                        </a>
                    </td>
                   
                    <td class="cell-border"style="font-size: 15px"> {$aInvoiceDescriptions[$invoice.id]}</td>
                    <td class="cell-border grey-c font-total-16" style="color: #4b4b4b">{$invoice.total|price:$invoice.currency_id}</td>
                    <td class="cell-border grey-c font-total-16 "style="color: #4b4b4b">{$invoice.duedate|date_format:'%d %b %Y'}</td>
                </tr>
           {/foreach} 
             
            </table>
            
            {if isset($oAdmin->id)}
            <script language="javascript">
            {literal}
            $(document).ready( function () {
                
                $('#selectInvoice').show();
                $('#payAllInvoice').hide();
                
                $('#selectInvoice').click( function () {
                    $(this).hide();
                    $('#payAllInvoice').show();
                    $('.select-invoice').show();
                    
                });
                
                $('#payallForm').submit( function () {
                    var invSelect   = '0';
                    $('input[name="invoiceSelected[]"]').each( function () {
                        if ($(this).is(':checked')) {
                            invSelect   += ',' + $(this).val();
                        }
                    });
                    
                    $.post('?cmd=invoicehandle&action=hiddenInvoice', {invoices:invSelect}, function (data) {
                        $('#payallForm')[0].submit();
                    });
                    
                    return false;
                });
                
            });
            function addToSelectedInvoiceItems (el)
            {
                var v   = $(el);
                $('#selectedInvoiceEnd').show();
                $('#selectedInvoiceItems').show();
                v.attr('onclick', '');
                $('#selectedInvoiceItems').after(v.parent().parent());
                $('html, body').animate({ scrollTop: $('#selectedInvoiceItems').offset().top}, 500);
            }
            {/literal}
            {/if}
            </script>
        </div>
    </div>
 </div>
 {/if}
 <!-- End of Invoices -->
 
 <!-- Tickets -->
 <div class="text-block clear clearfix" style="padding: 17px 35px 17px 35px;">
    <h5 style="margin: 5px 10px 26px 0;font-size: 20px;"><i class="icon-service-ticket" ></i>{$lang.openedtickets|capitalize}</h5>
    <div class="separator-down-arrow"></div>
    <div class="line-separaotr" style="    margin-top: 19px;"></div>
    <br>
     <div class="right-btns">

     </div>
    <br>
    <div class="clear clearfix">
        <div class="table-box">
            <div class="table-header">
                <p>{$lang.openedtickets|capitalize}</p>
            </div> 
            <table class="table table-hover">
                <tr class="table-header-row">
                    <th class="font-total-16"style="line-height: 33px;" >{$lang.subject}</th>
                    <th class="w20 cell-border font-total-16" style="text-align: center;">{$lang.status}</th>
                    <th class="w20 cell-border font-total-16" style="text-align: center;">Update<i class="icon-sort-arrow-down"></i></th>
                </tr>
                {foreach from=$openedtickets item=ticket name=foo}
                {if $ticket.status != 'closed'}
                <tr>
                    <td class="no-bold" style="border-right: solid 1px #edeeef;"><a href="https://support.netway.co.th/hc/th/requests/{$ticket.id}" style="font-size: 16px;">{$ticket.subject}</a></td>
                    <td style="text-align: center;"><span class="ticket-{$ticket.status} no-bold "style="font-size: 16px">{$ticket.status}</span></td>
                    <td class="cell-border grey-c font-total-16 no-bold" style="text-align: center;">{$ticket.updated_at|date_format:'%d %b %Y'}</td>
                </tr>
                {/if}
                {/foreach}
            </table>
        </div>
    </div>
 </div>
 <!-- End of Tickets -->
    
    
<!--</div>-->

