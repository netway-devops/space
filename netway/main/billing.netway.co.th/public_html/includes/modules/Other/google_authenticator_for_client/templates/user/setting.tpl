<div id="loginbox_container">
    <div class="wbox">
        <div class="wbox_header">2 Step login Authentication</div>
        <div  class="wbox_content">
            <div class="alert alert-info">คุณสามารถ เปิด หรือปิด คุณสมบัตินี้ได้ตลอด</div>

            <form id="formSetting" name="" action="" method="post">
                <input type="hidden" name="make" value="submit"/>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" colspan="2" style="padding-bottom:10px;">
                            <label for="securitycode" class="styled">&nbsp;</label>
                            <label><input type="radio" name="status" value="1" {if $status == 'Enable'} checked="checked" {/if} /> Enable</label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colspan="2" style="padding-bottom:10px;">
                            <label for="securitycode" class="styled">&nbsp;</label>
                            <label><input type="radio" name="status" value="0" {if $status != 'Enable'} checked="checked" {/if} /> Disable</label>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <div class="form-actions">

                                <div class="right">
                                    <button type="button"  onclick="updateClientSetGoogleAuth();" value="" class="btn btn-success" style="font-weight:bold">Save</button>
                                </div>
                                <div class="clear"></div>
                            </div>

                        </td>
                    </tr>

<script language="JavaScript">
{literal}
function updateClientSetGoogleAuth ()
{
    var status      = $('input[name="status"][value="1"]').prop('checked') ? 1 : 0;
    $.post('?cmd=google_authenticator_for_client&action=updateclientfeature', {status:status}, function () {
        window.location.href    ='index.php?cmd=clientarea';
    });
}
{/literal}
</script>

                </table>{securitytoken}</form>
        </div>
    </div>
</div>