{include file='notificationinfo.tpl'}

<div class="bordered-section article">
<h2 class="bbottom ">{$lang.confirmPayment}</h2>
<div class="p19">

	<p class="well well-small">ลูกค้าของ Netway Communication Co.,Ltd. สามารถยืนยันการชำระค่าบริการได้ตามแบบฟอร์มด้านล่างนี้ค่ะ</p>
	
	<form method="post" action="" name="signupform" id="formSubmit" class="form-horizontal">
	
	{include file='validateinfo.tpl'}
	
	<fieldset>
	<legend>เลือกระบุข้อมูลบริการ</legend>
	<div class="control-group">
		<label class="control-label" for="service">บริการที่ชำระ :</label>
		<div class="controls">
		   <select name="service" id="service" class="input-large">
		       <option value="">--- กรุณาเลือก ---</option>
			   {foreach from=$aServices key=k item=aService}
			   <option value="{$aService.name}" {if $oData->service == $aService.name} selected="selected" {/if}>{$aService.name}</option>
			   {/foreach}
		   </select>
		</div>
	</div>
	
    <div class="control-group">
        <label class="control-label" for="domainname">ชื่อโดเมน :</label>
        <div class="controls">
           <input type="text" name="domainname" id="domainname" value="{$oData->domainname}" class="input-xlarge" />
        </div>
    </div>
	
	</fieldset>
	
	<fieldset>
	<legend>หรือระบุเลขที่สั่งซื้อ</legend>
	
    <div class="control-group">
        <label class="control-label" for="invoiceno">เลขที่สั่งซื้อ :</label>
        <div class="controls">
           <input type="text" name="invoiceno" id="invoiceno" value="{$oData->invoiceno}" class="input-xxlarge" />
        </div>
    </div>
	
	{if isset($oClient->id) && $oClient->id && count($aInvoices)}
    <div class="control-group">
        <label class="control-label">&nbsp;</label>
        <div class="controls">
        	หรือเลือกจากเลขที่สั่งซื้อที่ยังไม่ได้ชำระค่าบริการต่อไปนี้
           {foreach from=$aInvoices key=k item=aInvoice }
		   <label style="width:50%;"><input type="checkbox" name="invoicenos[]" id="invoicenos" value="{$aInvoice.mask}" {if in_array($aInvoice.mask, $oData->invoicenos)} checked="checked" {/if} /> &nbsp; {$aInvoice.mask} ยอดค้างชำระ ฿{$aInvoice.totalFormat} &nbsp; </label>
		   {/foreach}
        </div>
    </div>
	{/if}
	
    </fieldset>
	
    <fieldset>
    <legend>รายละเอียด</legend>
	
    <div class="control-group">
        <label class="control-label" for="amount">จำนวนเงินที่ชำระค่าบริการ* :</label>
        <div class="controls">
           <input type="text" name="amount" id="amount" value="{$oData->amount}" class="input-medium required" title="จำนวนเงินที่ชำระค่าบริการ" /> บาท
        </div>
    </div>
	
    <div class="control-group">
        <label class="control-label" for="payment">วิธีการชำระ* :</label>
        <div class="controls">
           <select name="payment" id="payment" class="required" title="วิธีการชำระ">
            <option value="">--- โอนเงินเข้าบัญชีธนาคาร ---</option>
			<option value="ธนาคาร กรุงเทพ" {if $oData->payment == 'ธนาคาร กรุงเทพ'} selected="selected" {/if}>ธนาคาร กรุงเทพ</option>
			<option value="ธนาคาร ไทยพาณิชย์" {if $oData->payment == 'ธนาคาร ไทยพาณิชย์'} selected="selected" {/if}>ธนาคาร ไทยพาณิชย์</option>
			<option value="ธนาคาร กสิกรไทย" {if $oData->payment == 'ธนาคาร กสิกรไทย'} selected="selected" {/if}>ธนาคาร กสิกรไทย</option>
			<option value="ธนาคาร ทหารไทย" {if $oData->payment == 'ธนาคาร ทหารไทย'} selected="selected" {/if}>ธนาคาร ทหารไทย</option>
			<option value="ธนาคาร กรุงไทย" {if $oData->payment == 'ธนาคาร กรุงไทย'} selected="selected" {/if}>ธนาคาร กรุงไทย</option>
			<option value="ธนาคาร กรุงศรีอยุธยา" {if $oData->payment == 'ธนาคาร กรุงศรีอยุธยา'} selected="selected" {/if}>ธนาคาร กรุงศรีอยุธยา</option>
           </select>
        </div>
    </div>
	
    <div class="control-group">
        <label class="control-label" for="payday">วันที่ชำระเงิน* :</label>
        <div class="controls">
           <input type="text" name="payday" id="payday" value="{$oData->payday}" class="input-medium required" title="วันที่ชำระเงิน" />
		   &nbsp; เวลา 
		   <input type="text" name="paytime" id="paytime" value="{$oData->paytime}" class="input-small required" title="เวลาที่ชำระเงิน" /> น.
        </div>
    </div>
	
    
    <div class="control-group">
        <label class="control-label" for="fullname">ชื่อผู้ติดต่อ* :</label>
        <div class="controls">
           <input type="text" name="fullname" id="fullname" value="{$oData->fullname}" class="input-large required" title="ชื่อผู้ติดต่อ" />
        </div>
    </div>
    
    <div class="control-group">
        <label class="control-label" for="email">E-mail* :</label>
        <div class="controls">
           <input type="text" name="email" id="email" value="{$oData->email}" class="input-large required" title="E-mail address" />
        </div>
    </div>
	
    <div class="control-group">
        <label class="control-label" for="company">ชื่อบริษัท :</label>
        <div class="controls">
           <input type="text" name="company" id="company" value="{$oData->company}" class="input-large" />
        </div>
    </div>
	
    <div class="control-group">
        <label class="control-label" for="phone">เบอร์โทรศีพท์* :</label>
        <div class="controls">
           <input type="text" name="phone" id="phone" value="{$oData->phone}" class="input-large required" title="เบอร์โทรศีพท์" />
        </div>
    </div>
    
    <div class="control-group">
        <label class="control-label" for="comment">หมายเหตุ :</label>
        <div class="controls">
           <textarea name="comment" rows="3" class="input-xlarge">{$oData->comment}</textarea>
        </div>
    </div>
    
	{if ! isset($oClient->id) || ! $oClient->id}
    <div class="control-group">
        <label class="control-label" for="securecode">รหัสยืนยัน* :</label>
        <div class="controls">
            <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" />
			<a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a><br />
            <input type="text" name="securecode" id="securecode" value="" class="input-small required" title="รหัสยืนยัน" /><br />
		    ขออภัยในความไม่สดวก จำเป็นจะต้องยืนยันรหัสที่แสดงในข้อความภาพ เพื่อยืนยันการส่งข้อมูล
        </div>
    </div>
	{/if}
	
	</fieldset>
	
    <div class="form-actions">
        <center><input type="submit" name="send" value="{$lang.submit}" class="btn btn-info btn-large" style="font-weight:bold"/></center>
    </div>
		
	</form>
	
</div>
</div>



{literal}
<script language="JavaScript">
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