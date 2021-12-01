{if !$license_ip}

Error: Please contact support.

{else}
<form action="" method="post">
    <input type="hidden" name="make" value="uprdns" />
<table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table" >
   

    <tr>
        <td style="padding-top:15px;font-weight:bold">{$lang.currentipadd}</td>
        <td>{$license_ip}</td>
    </tr>

    <tr>
        <td style="padding-top:15px;font-weight:bold">New IP</td>
        <td><input type="text" name="license_ip" value="{$license_ip}" style="width:350px;"/>
    </td>
    </tr>
</table>
    <div class="form-actions" style="text-align: center">


<input type="submit" style="font-weight:bold" value="Update your license IP" class="btn btn-info ">
<div class="clear"></div>
</div>{securitytoken}
</form>

{/if}