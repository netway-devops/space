<div id="loginbox_container">
    <div class="wbox">
        <div class="wbox_header">{$lang.login}</div>
        <div  class="wbox_content">
            <div class="alert alert-info">{$lang.mobile2fa_login_desc}</div>

            <div style="text-align: center;padding:10px;">
                <button href="#" class="btn btn-request btn-primary btnRequest" data-resend="0">
                    <i class="fa fa-envelope"></i>
                    <span data-state="visible">{$lang.mobile2fa_sendpass}</span>
                    <span data-state="hidden" style="display: none;">{$lang.mobile2fa_resendpass}</span>
                </button>
            </div>
            <form name="?cmd=mobile_2fa" action="" method="post" style="display:none;" id="2faform">
                <input type="hidden" name="make" value="submit"/>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" colspan="2" style="padding-bottom:10px;"><label for="securitycode" class="styled">{$lang.password}</label>
                            <input name="securitycode" value="" class="styled"  type="number" id="securitycode" style="width:98%" autofocus/>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <div class="form-actions">

                                <div class="right">
                                    <button type="submit" value="" class="btn btn-info btn-large" style="font-weight:bold"><i class="icon-ok icon-white"></i> {$lang.login}</button>
                                </div>
                                <div class="clear"></div>
                            </div>

                        </td>
                    </tr>



                </table>{securitytoken}</form>
        </div>
    </div>
</div>
{literal}
<script type="text/javascript">
    $(document).on('click','.btnRequest',function (e) {
        e.preventDefault();
        var b = $(this);
        var w = {/literal}'{$lang.mobile2fa_waitplease}'{literal};
        var v = $(b).html();
        var t = $('input[name="security_token"]').val();
        var r = $(b).attr('data-resend');
        $(b).prop('disabled', true).html(w);
        setTimeout(function(){
            $(b).prop('disabled', false);
        }, 10000); //turn off for 10 seconds
        $.ajax({url: '?cmd=mobile_2fa&action=request&make=request&resend='+r+'&security_token='+t, type: 'post', data: {}, success: function (data) {
                $(b).attr('data-resend','1').html(v);
                $('#2faform').fadeOut('fast').fadeIn('fast');
                $(b).find('[data-state="visible"]').hide();
                $('#securitycode').focus();
                $(b).find('[data-state="hidden"]').show();
            }});
    });
</script>
{/literal}