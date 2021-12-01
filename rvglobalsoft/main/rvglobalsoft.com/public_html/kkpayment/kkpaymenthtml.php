
<?php if($forPutData == true){?>
<!-- ////////////////// Action View ///////////////// -->
 <form name="kk_payment" method="post" action="" FLEXY:IGNORE="yes">
<input type="hidden" name="action" value="kkpaymentForm" />
<table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="#EFEFEF">
<tr bgcolor="#F3EFDA"> 
<td colspan="2"><strong>KASIKORN BANK :: Quick Order</strong></td>
</tr>
<tr valign="middle" bgcolor="#FFFFFF"> 
<td width="100" height="30"><b>Currency:</b></td>
<td>
BATH
<!-- 
<input type="radio" name="merchant_id" value="<?php echo $oMerchantUSD;?>" <?php if($_POST['merchant_id'] == $oMerchantUSD || $_POST['merchant_id'] == '') echo  ' checked="checked" ';?> /> USD.
<input type="radio" name="merchant_id" value="<?php echo $oMerchantTHB;?>" <?php if($_POST['merchant_id'] == $oMerchantTHB ) echo  ' checked="checked" ';?>/> THB.
 -->
</td>
</tr>
<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Amount:</b></td>
<td><input name="amount" type="text" id="amount" size="20" value="<?php echo $_POST['amount'];?>" /></td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Payment For:</b></td>
<td><input name="detail" type="text" id="detail" size="20" value="<?php echo $_POST['detail'];?>" /></td>
</tr>

<tr bgcolor="#FFFFFF"> 
<td height="40">&nbsp;</td>
<td><input type="submit" name="Submit" value="Summary"></td>
</tr>
</table>
</form>
<!-- ////////////////////////// End View /////////////////////// -->
<?php }?>

<?php if ($forSend == true) {?>
<!-- ///////////////////// Validate For send Post ///////////////////// -->

<form name="sendform" method="post" action="https://rt05.kasikornbank.com/pgpayment/payment.aspx" FLEXY:IGNORE="yes">
<input name="MERCHANT2" type="hidden" size="15" value="<?php echo$merchantId;?>">
<input name="TERM2" type="hidden" size="15" value="<?php echo$terminal;?>">
<input name="URL2" type="hidden" size="15" value="{makeUrl(#view#,#kkpayment#,#main#)}">
<input name="RESPURL" type="hidden" size="15" value="{makeUrl(#view#,#kkpayment#,#main#)}">
<input name="IPCUST2" type="hidden" size="15" value="203.150.224.166">
<input name="INVMERCHANT" type="hidden" size="15" value="<?php echo$orderNo;?>">
<input name="FILLSPACE" type="hidden" size="15" value="Y">

<table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="#EFEFEF">
<tr bgcolor="#F3EFDA"> 
<td colspan="2"><strong>KASIKORN BANK :: Summary Order</strong></td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td width="100" height="30"><b>Merchant ID:</b></td>
<td><?php echo$merchantId;?></td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Invoice No:</b></td>
<td><?php echo$orderNo;?></td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Currency:</b></td>
<td><?php echo$currency;?></td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Amount:</b></td>
<td><input name="AMOUNT2" type="hidden" size="15" value="<?php echo$transac_amount;?>" /><?php echo$amount;?></td>
</tr>

<tr valign="middle" bgcolor="#FFFFFF"> 
<td height="30"><b>Payment For:</b></td>
<td><input name="DETAIL2" type="hidden" size="15" value="<?php echo$detail;?>" /><?php echo$detail;?></td>
</tr>

<tr bgcolor="#FFFFFF"> 
<td height="40">&nbsp;</td>
<td><input type="submit" name="Submit" value="Checkout"></td>
</tr>
</table>
</form>
<!-- //////////////// END Validate Send Post ///////////////// -->
<?php }?>
                       
  
