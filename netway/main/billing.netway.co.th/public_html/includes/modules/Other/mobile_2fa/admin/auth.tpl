<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes"/>
    {adminwidget module="login" section="meta" wrapper=""}
    <title>{$theme_vars.AdminCustomTitle}HostBill - {$business_name} </title>
    <link href="{$template_dir}dist/stylesheets/application.css?v={$hb_version}" rel="stylesheet" media="all" />

    {if $theme_vars.AdminFavicon}
        <link rel="icon" href="{$theme_vars.AdminFavicon}"  type="image/png">
    {/if}
    <script type="text/javascript" src="{$template_dir}js/jquery.js?v={$hb_version}"></script>
    {literal}<style>


        html, body {
            /*height:100%;*/
            min-height:100%;
            position:relative;
        }
        .lighterblue {
            background: #EBF3FF;
        }
    </style>	{/literal}

</head>

<body style="" onload="$('#mobile_token').focus();">



<div class="login-box" >
    <img src="{$system_url}{$theme_vars.AdminLogoPath}" style="margin-bottom:10px;width:109px" />
    <div style=" padding:2px;margin-bottom:4px;background:#ffffff;" class="box">
        <div id="loginbox_container">
            <div class="wbox">
                <div  class="wbox_content">
                    <div class="lighterblue" style="padding: 13px;">{$lang.mobile2fa_login_desc}</div>
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        {if $error}
                            <tr><td colspan="2" style="border:1px solid #DDDDDD;background:#FFFFDF;padding:10px;">
                                    {foreach from=$error item=blad}
                                        <span class="error">{$blad}<br /></span>
                                    {/foreach}
                                </td></tr>
                        {/if}
                    </table>
                    <div style="text-align: center;padding:10px;">
                        <button href="#" class="btn btn-request btn-primary btnRequest" data-resend="0">
                            <i class="fa fa-envelope"></i>
                            <span data-state="visible">{$lang.mobile2fa_sendpass}</span>
                            <span data-state="hidden" style="display: none;">{$lang.mobile2fa_resendpass}</span>
                        </button>
                    </div>
                    <form action="?cmd=mobile_2fa" method="POST" style="display:none;margin-top: 20px;" class="formToken">
                        <input type="hidden" name="make" value="verify"/>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="left" colspan="2" style="padding:10px;"><label for="mobile_token" class="styled">{$lang.mobile2fa_login_header}</label>
                                    <input name="mobile_token" id="mobile_token" value="" class="styled"  type="number" style="width:98%" autofocus />
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <div class="form-actions">

                                        <div class="right" style="padding: 13px;">
                                            <button type="submit" value="" class="btn btn-primary btn-large" style="font-weight:bold;"><i class="icon-ok icon-white"></i> {$lang.Login}</button>
                                        </div>
                                        <div class="clear"></div>
                                    </div>

                                </td>
                            </tr>
                        </table>{securitytoken}</form>
                </div>
            </div>
        </div>







        <div class="lighterblue" style="padding: 13px;"><a href="?action=logout">{$lang.Logout}</a></div>
    </div>
    <div style="text-align:right;"><small>Powered by <a href="https://hostbillapp.com" target="_blank" >HostBill</a></small></div>
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
                $('.formToken').fadeOut('fast').fadeIn('fast');
                $(b).find('[data-state="visible"]').hide();
                $('#mobile_token').focus();
                $(b).find('[data-state="hidden"]').show();
            }});
    });
</script>
{/literal}


</body>
</html>