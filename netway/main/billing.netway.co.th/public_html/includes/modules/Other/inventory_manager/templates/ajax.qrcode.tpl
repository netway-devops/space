<h3>QR Code</h3>
<div class="right" style="margin: -16px 20px 0px 0px; text-align: center;">
    <img id="qrcodeimage" src="?cmd=inventory_manager&action=qr&id={$product.id}"><br>
    <a class="printit" href="?cmd=inventory_manager&action=qr&id={$product.id}" onclick="return printQr();" ><i class="fa fa-print"></i> Print</a>
</div>
<table cellpadding="6" cellspacing="0">
    <tr>
        <td><b>S/N:</td>
        <td>{$product.sn}</td>
    </tr>
    <tr>
        <td><b>Item ID:</td>
        <td><a href="{$siteurl}?cmd=inventory_manager#e{$product.id}" target="_blank">#{$product.id}</a></a></td>
    </tr>
    <tr>
        <td><b>URL:</td>
        <td><a href="{$siteurl}?cmd=inventory_manager#e{$product.id}" target="_blank">{$siteurl}?cmd=inventory_manager#e{$product.id}</a></td>
    </tr>
</table>
