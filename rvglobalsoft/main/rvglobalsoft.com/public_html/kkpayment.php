<?php
DEFINE("MERCHANT_THB","401001015676001");
DEFINE("TERMINAL_THB","70340650");
DEFINE("MERCHANT_USD","402001015684001");
DEFINE("TERMINAL_USD","70340651");
?>
<html>
<head>
<title>RV Global Soft Co., Ltd.</title>
<link rel="stylesheet" href="wep.css" type="text/css">
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td valign="top"> 

<?php

if (isset($_POST['merchant_id'])) {
    $order_no = trim($_POST['orderNo']); 
    $amount = trim($_POST['amount']);
    $amount = number_format($amount, 2, '.', '');
    $transac_amount = sprintf("%012s",$amount);
    $transac_amount =  preg_replace('/\./', '', $transac_amount);
if ($_POST['merchant_id'] == MERCHANT_USD) {
        $terminal = TERMINAL_USD;
        $currency = 'USD.';
} else {
        $terminal = TERMINAL_THB;
        $currency = 'THB.';
}

?>


<form name="sendform" method="post" action="https://rt05.kasikornbank.com/pgpayment/payment.aspx">

<input name="MERCHANT2" type="hidden" size="15" value="<?php echo $_POST['merchant_id']; ?>">
<input name="TERM2" type="hidden" size="15" value="<?php echo $terminal; ?>">
<input name="URL2" type="hidden" size="15" value="http://www.webexperts.co.th/kkpayment.php">
<input name="RESPURL" type="hidden" size="15" value="http://www.webexperts.co.th/kkpayment.php">
<input name="IPCUST2" type="hidden" size="15" value="203.150.224.166">
<input name="INVMERCHANT" type="hidden" size="15" value="<?php echo $order_no; ?>">
<input name="FILLSPACE" type="hidden" size="15" value="Y">

<table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="#EFEFEF">
  <tr bgcolor="#F3EFDA"> 
    <td colspan="2"><strong>KASIKORN BANK :: Summary Order</strong></td>
  </tr>

        <tr valign="middle" bgcolor="#FFFFFF"> 
      <td width="150" height="30"><b>Merchant ID:</b></td>
      <td><?php echo $_POST['merchant_id']; ?></td>
    </tr>

        <tr valign="middle" bgcolor="#FFFFFF"> 
      <td height="30"><b>Invoice number:</b></td>
      <td><?php echo $order_no; ?></td>
    </tr>

        <tr valign="middle" bgcolor="#FFFFFF"> 
      <td height="30"><b>Currency:</b></td>
      <td><?php echo $currency; ?></td>
    </tr>

        <tr valign="middle" bgcolor="#FFFFFF"> 
      <td height="30"><b>Amount:</b></td>
      <td><input name="AMOUNT2" type="hidden" size="15" value="<?php echo $transac_amount; ?>"><?php echo $amount; ?></td>
    </tr>

        <tr valign="middle" bgcolor="#FFFFFF"> 
      <td height="30"><b>Payment for:</b></td>
      <td><input name="DETAIL2" type="hidden" size="15" value="<?php echo trim($_POST['detail']); ?>"><?php echo trim($_POST['detail']); ?></td>
    </tr>

        <tr bgcolor="#FFFFFF"> 
      <td height="40">&nbsp;</td>
      <td><input type="submit" name="Submit" value="Checkout"></td>
    </tr>
</table>
</form>

<?
} else {
?>

<br>


<form name="kk_payment" method="post" action="">
<table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="#EFEFEF">
  <tr bgcolor="#F3EFDA"> 
    <td colspan="2"><strong>KASIKORN BANK :: Quick Order</strong></td>
  </tr>

        <tr valign="middle" bgcolor="#FFFFFF"> 
      <td width="150" height="30"><b>Currency:</b></td>
      <td><input type="radio" name="merchant_id" value="<?php echo MERCHANT_USD; ?>" checked="checked" /> USD. 
      <input type="radio" name="merchant_id" value="<?php echo MERCHANT_THB; ?>" /> THB.</td>
    </tr>

        <tr valign="middle" bgcolor="#FFFFFF"> 
      <td height="30"><b>Amount:</b></td>
      <td><input name="amount" type="text" id="amount" size="20"></td>
    </tr>
    
     <tr valign="middle" bgcolor="#FFFFFF">
         <td height="30"><b>Invoice number:</b></td>
         <td><input name="orderNo" type="text" id="orderNo" size="20"></td>
     </tr>    

     <tr valign="middle" bgcolor="#FFFFFF"> 
      <td height="30"><b>Payment For:</b></td>
      <td><input name="detail" type="text" id="detail" size="20" value="RVSiteBuilder CC Batch"></td>
    </tr>

        <tr bgcolor="#FFFFFF"> 
      <td height="40">&nbsp;</td>
      <td><input type="submit" name="Submit" value="Summary"></td>
    </tr>
</table>
</form>



<br>
<?php
}
?>
      <p>&nbsp;</p>
      <p>&nbsp; </p></td>
  </tr>
</table>
</body>
</html>

