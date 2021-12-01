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
        <td class="cssright">Packagess</td>
        <td class="cssleft">{$accounts.product_name} ({$accounts.commonname})</td>
        <td class="cssright" nowrap="true">Authority Order Id:</td>
        <td class="cssleft">{$accounts.authority_orderid}</td>
    </tr>
    <tr>
        <td class="cssright">E-mail:</td>
        <td class="cssleft">{$accounts.email_approval}</td>
        <td class="cssright">CSR:</td>
        <td class="cssleft">
            <a href="" target="_blank">Download</a>
        </td>
    </tr>
</table>
<fieldset  id="for_order_complete">
    CERTIFICATE : <a href="">Download</a><br />
    <textarea  cols="100" rows="5" name="code_certificate" readonly="ture">{$accounts.code_certificate}</textarea><br />
    CA :  <a href="">Download</a><br />
    <textarea  cols="100" rows="5" name="code_ca" readonly="ture">{$accounts.code_ca}</textarea><br />
    Expire Date: {$accounts.date_expire}<br />
</fieldset>

<table width="80%" border="0" cellpadding="2" cellspacing="2">
    <tr>
        <td class="cssright">Action</td>
        <td class="cssleft">
            <div class="{if !isset($adminctrl.access) || !$adminctrl.access }isForbidAccess{/if}">
                <input type="submit"  name="suspend" value="Suspend" {if !$adminctrl.allow.suspend} class="manumode"{/if} {if !$adminctrl.allow.suspend && $details.manual!='1'}style="display:none"{/if}  onclick="return confirm('{$lang.suspendconfirm}')"/>
                <input type="submit" name="unsuspend" value="Unsuspend" {if !$adminctrl.access.allow.unsuspend} class="manumode"{/if} {if !$adminctrl.allow.unsuspend && $details.manual!='1'}style="display:none"{/if}/>
                <input type="submit" name="terminate"  value="Terminate" {if !$adminctrl.access.allow.terminate}class="manumode"{/if} {if !$adminctrl.allow.terminate && $details.manual!='1'}style="display:none;color:#ff0000;"{else} style="color:#ff0000"{/if} onclick="return confirm('{$lang.terminateconfirm}')"/>
                <input type="submit" name="renewal"  value="Renewal" {if !$adminctrl.allow.renewal}style="display:none"{/if}/>
            </div>
        </td>
    </tr>
    
    <tr>
        <td class="cssright">{$lang.sendacce}</td>
        <td class="cssleft">
            <select name="mail_id" id="mail_id">
            {foreach from=$product_emails item=send_email}
                <option value="{$send_email.id}">{$send_email.tplname}</option>
            {/foreach}
                <option value="custom" style="font-weight:bold">{$lang.newmess}</option>
            </select>
            <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail"/>
        </td>
    </tr>
</table>

