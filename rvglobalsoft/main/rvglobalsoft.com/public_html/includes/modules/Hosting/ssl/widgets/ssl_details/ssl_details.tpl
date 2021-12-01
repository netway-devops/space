{literal}
<style>
    .cssright{
        width:10%;
        text-align:left;
    }
    .cssleft{
        width:40%;
        text-align:left;
    }
</style>
{/literal}

<table width="80%" border="0" cellpadding="2" cellspacing="2">
    <tr>
        <td class="cssright">Package</td>
        <td class="cssleft">{$accounts.product_name} ({$accounts.commonname})</td>
        <td class="cssright" nowrap="true">E-mail:</td>
        <td class="cssleft">{$accounts.email_approval}</td>
    </tr>
</table>
<fieldset  id="for_order_complete">
    CSR: <a href="">Download</a><br />
    <textarea  cols="100" rows="5" cols="100" name="code_certificate" readonly="ture" style="font-size: 9px;">{$accounts.csr}</textarea><br />
    
    CERTIFICATE: <a href="">Download</a><br />
    <textarea  cols="100" rows="5" name="code_certificate" readonly="ture">{$accounts.code_certificate}</textarea><br />
    CA: <a href="">Download</a><br />
    <textarea  cols="100" rows="5" name="code_ca" readonly="ture">{$accounts.code_ca}</textarea><br />
    Expire Date: <br />
</fieldset>