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
    <script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js?v={$hb_version}"></script>
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

<body style="" onload="$('#username').focus();">


<div class="login-box" >
    <img src="{$system_url}{$theme_vars.AdminLogoPath}" style="margin-bottom:10px;width:109px" />
    <div style=" padding:2px;margin-bottom:4px;background:#ffffff;" class="box">
        <div id="loginbox_container">
            <div class="wbox">
                <div class="wbox_header">{$lang.login}</div>
                <div  class="wbox_content">
                    <div class="lighterblue" style="padding: 13px;">{$lang.securitycode_info}</div>
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        {if $error}
                            <tr><td colspan="2" style="border:1px solid #DDDDDD;background:#FFFFDF;padding:10px;">
                                    {foreach from=$error item=blad}
                                        <span class="error">{$blad}<br /></span>
                                    {/foreach}
                                </td></tr>
                        {/if}
                    </table>
                    <form name="" action="" method="post">
                        <input type="hidden" name="make" value="submit"/>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="left" colspan="2" style="padding:10px;"><label for="securitycode" class="styled">{$lang.securitycode}</label>
                                    <input name="securitycode" value="" class="styled"  type="text" style="width:98%"/>
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
    <div style="text-align:right;"><small>Powered by <a href="http://hostbillapp.com" target="_blank" >HostBill</a></small></div>
</div>




</body>
</html>