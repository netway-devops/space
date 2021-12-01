<div id="loginbox_container">
    <div class="wbox">
        <div class="wbox_header">2 Step login Authentication</div>
        <div  class="wbox_content">
            <div class="alert alert-info">ระบุรหัส 6 หลักจาก Google Authenticator App ที่ได้เชื่อมการใช้งานไว้กับ Netway</div>

            <form name="" action="" method="post">
                <input type="hidden" name="make" value="submit"/>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" colspan="2" style="padding-bottom:10px;"><label for="securitycode" class="styled">{$lang.securitycode}</label>
                            <input id="googleAuthCode" name="googleAuthCode" value="" class="styled"  type="text" style="width:98%"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colspan="2" style="padding-bottom:10px;">
                            <label for="googleAuthCookie" class="styled">
                                <input id="googleAuthCookie" name="googleAuthCookie" value="1" class="styled"  type="checkbox" />
                                <b>เครื่องคอมพิวเตอร์ฉันปลอดภัย</b> <br />ให้ระบบข้ามการยืนยันแบบ 2 Step login Authentication สำหรับคอมพิวเตอร์เครื่องนี้นาน 30 วัน 
                            </label>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <div class="form-actions">

                                <div class="right">
                                    <button type="button"  onclick="verifyGoogleAuthCode();" value="" class="btn btn-primary" style="font-weight:bold"><i class="icon-ok icon-white"></i> Verify</button>
                                </div>
                                <div class="clear"></div>
                            </div>

                        </td>
                    </tr>

<script language="JavaScript">
{literal}
function verifyGoogleAuthCode ()
{
    var code    = $('#googleAuthCode').val();
    var save    = $('#googleAuthCookie').is(':checked');
    if (code === '') {
        alert('กรุณาระบุรหัส 6 หลักที่ได้จาก Google Authenticator App');
        return false;
    }
    $.post('?cmd=google_authenticator_for_client&action=verifygoogleauthcode', {code:code,save:save}, function (data) {
        window.location.href    ='index.php?cmd=clientarea';
    });
}
{/literal}
</script>

                </table>{securitytoken}</form>
        </div>
    </div>
</div>