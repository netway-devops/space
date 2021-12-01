{literal}
    <style>
        
        section.hero {

            height: 200px;
            padding: 0 20px;
            text-align: center;
            width: 100%;
            background: url('https://billing.netway.co.th/templates/netwaybysidepad/images/bg-kbank-min.png');
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
            background-position: top;

        }
    </style>
{/literal}
    <section class="section hero">
        <div class="container" >
            <div class="row" style="padding: 55px 0 30px 0;">
           			
				   <center>
				   <h3 class="h3-titel-content g-txt36"  style="color: #FFF;  font-style: normal;"> Quick Order</h3>
				   </center>
				 
            </div>
        </div>
    </div>
    </section> 

<div class="container">
{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/kbank.tpl.php');
{/php}

{if $forPutData}
<!-- ////////////////// Action View ///////////////// -->

 <form name="kk_payment" method="post" action="" FLEXY:IGNORE="yes">
<input type="hidden" name="action" value="kkpaymentForm" />
<div>
  <div style="margin-bottom: 40px; margin-top: 40px;">
  <img src="https://netway.co.th/templates/netwaybysidepad/images/bank/kb.png" title="ธนาคารกสิกรไทย" alt="ธนาคารกสิกรไทย" height="32" width="32"
    style="margin-top: -11px;"
  />
  <strong class="color-blue-a g-txt24" 
  style="color: #717171;  margin-bottom: 50px;">KASIKORN BANK </strong>
  <hr/>
  </div>
</div>
<div class="row">
	<div class="span6" style="font-size: 16px;font-weight: 100;line-height: 30px; ">


			<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr valign="middle" bgcolor="#FFFFFF"> 
			<td width="100" height="30" class="aright g-txt18"><b>Currency</b></td>
			<td>
			<p class="g-txt18" style="margin-left: 10px; margin-top: 3px;">BAHT</p>
			
			</td>
			</tr>
			<tr valign="middle" bgcolor="#FFFFFF"> 
			<td height="30" class="aright g-txt18"><b>Amount </b></td>
			<td><input name="amount" type="text" id="amount" size="20" value="{$amount}"  style="height: 30px; margin-left: 10px;"/></td>
			</tr>
			
			<tr valign="middle" bgcolor="#FFFFFF"> 
			<td height="30" class="aright g-txt18" nowrap="nowrap"><b>หมายเลข invoice</b></td>
			<td><input name="inv" type="text" id="inv" size="20" value="{$inv}"  style="height: 30px;  margin-left: 10px;" /></td>
			</tr>
			
			<tr valign="middle" bgcolor="#FFFFFF"> 
			<td height="30" class="aright g-txt18" nowrap="nowrap"><b>Payment For</b></td>
			<td><input name="detail" type="text" id="detail" size="20" value="{$detail}"   style="height: 30px;  margin-left: 10px;"/></td>
			</tr>
			
			<tr bgcolor="#FFFFFF"> 
			<td height="40">&nbsp;</td>
			<td valign="top"><input  class="btn-confirm nw-kb-btn-ticket" type="submit" name="Submit" value=" Summary" 
			style="border: 2px solid green; background-color: green;  margin-top: 24px;"></td>
			</tr>
			</table>
       </div>
		<div class="span6"  style=" border-style: solid; border-color: #cccccc;   border-width: 1px; border-radius: 20px; padding: 30px 30px 30px 20px;">
		   <div><b class="g-txt18">วิธีการกรอกข้อมูล</b></div> 
		   <hr/>
			<ol>
				<li  style="line-height: 33px;">Amount : กรอกยอดเงินโดยมีทศนิยม 2 ตำแหน่ง เช่น 481.50 หรือ 856.00 จำนวน Amount ไม่ต้องใส่เครื่องหมาย  " , "  ในจำนวนเงินหลักพัน</li>
				<li  style="line-height: 33px;">หมายเลข Invoice : เลขที่ Invoice เช่น 15321</li>
				<li  style="line-height: 33px;">Payment For : กรอกชื่อโดเมนที่ต้องการชำระ</li>
			</ol>
		</div>
	</div>
</div>

</form>


<!-- ////////////////////////// End View /////////////////////// -->
{/if}

{if $forSend}
<!-- ///////////////////// Validate For send Post ///////////////////// -->

<form name="sendform" id="sendform" method="post" action="https://rt05.kasikornbank.com/pgpayment/payment.aspx" FLEXY:IGNORE="yes">
<input name="MERCHANT2" type="hidden" size="15" value="{$merchantId}">
<input name="TERM2" type="hidden" size="15" value="{$terminal}">
<input name="URL2" type="hidden" size="15" value="{$urlcallback}">
<input name="RESPURL" type="hidden" size="15" value="{$urlcallback}">
<input name="IPCUST2" type="hidden" size="15" value="203.78.99.126">
<input name="INVMERCHANT" type="hidden" size="15" value="{$orderNo}">
<input name="FILLSPACE" type="hidden" size="15" value="Y">

<table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="#EFEFEF">
<tr bgcolor="#F3EFDA"> 
<td colspan="2"><strong>KASIKORN BANK :: Summary Order</strong></td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td width="100" height="30"><b>Merchant ID:</b></td>
<td>{$merchantId}</td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Invoice No:</b></td>
<td>{$orderNo}</td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Currency:</b></td>
<td>{$currency}</td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Amount:</b></td>
<td><input name="AMOUNT2" type="hidden" size="15" value="{$transac_amount}" />{$amount}</td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Payment For:</b></td>
<td><input name="DETAIL2" type="hidden" size="15" value="{$detail}" />{$detail}</td>
</tr>

<tr bgcolor="#FFFFFF"> 
<td height="40">&nbsp;</td>
<td>Waiting......</td>
</tr>
</table>
</form>
<!-- //////////////// END Validate Send Post ///////////////// -->
{literal}
<script>
    $(document).ready(function(){
        $('#sendform').submit();
    });
</script>
{/literal}
{/if}
</div>             


