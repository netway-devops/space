{include file='notificationinfo.tpl'}

<!-- Modal -->
<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <h3 id="myModalLabel">Already Customer</h3>
  </div>
  <div class="modal-body">
    <form action="confirm-payment.php" method="post">
        {assign var="onlycustomer" value="1"}
        {include file="ajax.login.tpl"}
    </form>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>



    <div class="d-flex align-items-center flex-column form-credentials">
        <h1 class="my-4">{$lang.confirmPayment}</h1>
     	    <p class="well well-small">
                <span class="span12">ลูกค้าของ Netway Communication Co.,Ltd. สามารถยืนยันการชำระค่าบริการได้ตามแบบฟอร์มด้านล่างนี้ค่ะ</span>
            </p>

        {if ! isset($oClient->id)}
    
    <div class="well well-small">
        <span class="span12">
            ถ้าเคยสั่งซื้อบริการหรือเป็นลูกค้าอยู่แล้ว คุณสามารถ Login เพื่อดูข้อมูลค่าบริการที่ค้างชำระ และยืนยันการชำระเงินได้อย่างรวดเร็วยิ่งขึ้น  <a href="javascript:return false;" class="btn btn-success" data-toggle="modal" data-target="#loginModal">Login</a>
        </span>
    </div>
        {/if}
    
        <form method="post" action="" name="signupform" id="formSubmit" class="form-horizontal">

            {include file='validateinfo.tpl'}
       
            <fieldset>
            <legend>เลือกระบุข้อมูลบริการ</legend>
            <div class="control-group">
                <label class="control-label" for="service">บริการที่ชำระ :</label>
            
                   <select name="service" id="service" class="input-large">
                       <option value="">--- กรุณาเลือก ---</option>
                       {foreach from=$aServices key=k item=aService}
                       <option value="{$aService.name}" {if $oData->service == $aService.name} selected="selected" {/if}>{$aService.name}</option>
                       {/foreach}
                   </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
        <br>
            <div class="control-group">
                <label class="control-label" for="domainname">ชื่อโดเมน :</label>
                   <input type="text" name="domainname" id="domainname" value="{$oData->domainname}" class="input-xlarge" />
           </div>
             
	</fieldset>
    <br> 
    <br>
	<fieldset>
	<legend>หรือระบุเลขที่สั่งซื้อ</legend>

    <div class="control-group">
        <label class="control-label" for="invoiceno">เลขที่สั่งซื้อ :</label>
        <input type="text" name="invoiceno" id="invoiceno" value="{$oData->invoiceno}" class="input-xxlarge" />
        
    </div>

	{if isset($oClient->id) && $oClient->id && count($aInvoices)}
    <div class="control-group">
        <label class="control-label">&nbsp;</label>
         	หรือเลือกจากเลขที่สั่งซื้อที่ยังไม่ได้ชำระค่าบริการต่อไปนี้
           {foreach from=$aInvoices key=k item=aInvoice }
		   <label style="width:50%;"><input type="checkbox" name="invoicenos[]" id="invoicenos" value="{$aInvoice.mask}" {if in_array($aInvoice.mask, $oData->invoicenos)} checked="checked" {/if} /> &nbsp; {$aInvoice.mask} ยอดค้างชำระ ฿{$aInvoice.totalFormat} &nbsp; </label>
		   {/foreach}
    </div>
   	{/if}

    </fieldset>
    <br><br>
    <fieldset>
    <legend>รายละเอียด</legend>

    <div class="control-group">
        <label class="control-label" for="amount">จำนวนเงินที่ชำระค่าบริการ * :</label>
            <input type="text" name="amount" id="amount" value="{$oData->amount}" class="input-medium required" title="จำนวนเงินที่ชำระค่าบริการ" /> บาท
    </div>
    <br>
    <div class="control-group">
        <label class="control-label" for="payment">วิธีการชำระ * :</label>
            <select name="payment" id="payment" class="required" title="วิธีการชำระ">
            <option value="">--- โอนเงินเข้าบัญชีธนาคาร ---</option>
			<option value="ธนาคาร กรุงเทพ" {if $oData->payment == 'ธนาคาร กรุงเทพ'} selected="selected" {/if}>ธนาคาร กรุงเทพ</option>
			<option value="ธนาคาร ไทยพาณิชย์" {if $oData->payment == 'ธนาคาร ไทยพาณิชย์'} selected="selected" {/if}>ธนาคาร ไทยพาณิชย์</option>
			<option value="ธนาคาร กสิกรไทย" {if $oData->payment == 'ธนาคาร กสิกรไทย'} selected="selected" {/if}>ธนาคาร กสิกรไทย</option>
			<option value="PromptPay" {if $oData->payment == 'PromptPay'} selected="selected" {/if}>PromptPay</option>
			<option value="QR Code" {if $oData->payment == 'QR Code'} selected="selected" {/if}>QR Code</option>
            <option value="บัตรเครดิต" {if $oData->payment == 'บัตรเครดิต'} selected="selected" {/if}>บัตรเครดิต</option>
            <option value="PayPal" {if $oData->payment == 'PayPal'} selected="selected" {/if}>PayPal</option>
			</select>
    </div>
    
    <br>
    <div class="control-group">
        <label class="control-label" for="payday">วันที่ชำระเงิน * :</label>
           <input type="text" name="payday" id="payday" value="{$oData->payday}" class="input-medium required" title="วันที่ชำระเงิน" />
		   &nbsp; เวลา :
		   <input type="text" name="paytime" id="paytime" value="{$oData->paytime}" class="input-small required" title="เวลาที่ชำระเงิน" /> น.
    </div>

    <br>
    <div class="control-group">
        <label class="control-label" for="fullname">ชื่อผู้ติดต่อ * :</label>
           <input type="text" name="fullname" id="fullname" value="{$oData->fullname}" class="input-large required" title="ชื่อผู้ติดต่อ" />
    </div>
    
    <br>
    <div class="control-group">
        <label class="control-label" for="email">E-mail * :</label>
           <input type="text" name="email" id="email" value="{$oData->email}" class="input-large required" title="E-mail address" />
    </div>
    
    <br>
    <div class="control-group">
        <label class="control-label" for="company">ชื่อบริษัท :</label>
            <input type="text" name="company" id="company" value="{$oData->company}" class="input-large" />
    </div>

    <br>
    <div class="control-group">
        <label class="control-label" for="phone">เบอร์โทรศัพท์ * :</label>
           <input type="text" name="phone" id="phone" value="{$oData->phone}" class="input-large required" title="เบอร์โทรศีพท์" />
    </div>
    
        <br>
            <div class="control-group">
                <label class="control-label" for="comment">หมายเหตุ :</label>
                <div class="controls">
                   <textarea name="comment" rows="3" class="input-xlarge">{$oData->comment}</textarea>
                </div>
            </div>
        <br>
            {if ! isset($oClient->id) || ! $oClient->id}
            <div class="control-group">
                <label class="control-label" for="securecode">รหัสยืนยัน* :</label>
                <div class="controls">
                    <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" />
                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a><br />
                    <input type="text" name="securecode" id="securecode" value="" class="input-small required" title="รหัสยืนยัน" /><br/><br>
                    *** ขออภัยในความไม่สะดวก จำเป็นจะต้องยืนยันรหัสที่แสดงในข้อความภาพ เพื่อยืนยันการส่งข้อมูล
                </div>
            </div>
            {/if}
        
            </fieldset>
        <br>
            <div class="form-actions" style="padding-left: 0;">
                <center><input type="submit" name="send" value="{$lang.submit}" class="btn btn-info btn-lg w-25"></center>
            </div>
        
            </form>
        
        </div>
    </div>




{literal}
<script language="javascript">
$(document).ready(function() {
    $('#payday').datepicker();
});

function singup_image_reload(){
    var d = new Date();
    $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
    return false;
}

/* --- Additional form validate --- */
function validateFormSubmitted () {
	if ($('input[name^=invoicenos]:checked').length > 0) {
		return true;
	}
    if ($('#invoiceno').val() != '') {
        return true;
    }
	if ($('#service').val() != '' && $('#domainname').val() != '') {
        return true;
    }
	alert('กรุณาระบุเลขที่สั่งซื้อ หรือระบุบริการและชื่อโดเมน ที่ต้องการแจ้งยืนยัน');
	return false;
}
</script>
{/literal}