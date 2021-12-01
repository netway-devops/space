<form action="" method="post">
    <input type="hidden" name="make" value="changepass" />
<table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table" >


    <tr>
        <td style="padding-top:15px;font-weight:bold">Current Password</td>
        <td>{$currentpass}</td>
    </tr>

    <tr>
        <td style="padding-top:15px;font-weight:bold">New Password</td>
        <td><input type="text" name="newpassword" value="{$currentpass}" style="width:350px;"/>
    </td>
    </tr>
</table>
    <div class="form-actions" style="text-align: center">


<input type="submit" style="font-weight:bold" value="Change your password" class="btn btn-info ">
<div class="clear"></div>
</div>{securitytoken}
</form>
