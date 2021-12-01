<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    {adminwidget module="login" section="meta" wrapper=""}
    <title>{$theme_vars.AdminCustomTitle}HostBill - {$business_name} </title>
    <link href="{$template_dir}dist/stylesheets/application.css?v={$hb_version}" rel="stylesheet" media="all"/>
    {if $theme_vars.AdminFavicon}
        <link rel="icon" href="{$theme_vars.AdminFavicon}" type="image/png">
    {/if}
    <script type="text/javascript" src="{$template_dir}js/jquery.js?v={$hb_version}"></script>
    {literal}
        <style>
            html, body {
                /*height:100%;*/
                min-height: 100%;
                position: relative;
            }
            .lighterblue {
                background: #EBF3FF;
            }
        </style>
    {/literal}
</head>

<body style="" onload="$('#securitycode').focus();">
<div class="login-box">
    <img src="{$system_url}{$theme_vars.AdminLogoPath}" style="margin-bottom:10px;width:109px"/>
    <div style=" padding:2px;margin-bottom:4px;background:#ffffff;" class="box">
        <div id="loginbox_container">
            <div class="wbox">
                <div class="wbox_header">{$lang.login}</div>
                <div class="wbox_content">
                    <div class="lighterblue" style="padding: 15px;">{$lang.securitycode_info}</div>
                    {if $error}
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="2" style="border:1px solid #DDDDDD;background:#FFFFDF;padding:10px;">
                                    {foreach from=$error item=blad}
                                        <span class="error">{$blad}<br/></span>
                                    {/foreach}
                                </td>
                            </tr>
                    </table>
                    {/if}
                    <div style="padding: 15px;">
                        <form name="" action="" method="post">
                            <input type="hidden" name="make" value="submit"/>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td align="left" colspan="2" style="padding-bottom:10px;">
                                        <label for="securitycode" class="styled">{$lang.securitycode}</label>
                                        <input name="securitycode" id="securitycode" value="" class="form-control" type="number"  autofocus />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">

                                        <div class="row">

                                            {if $enabled_remembering}
                                                <div class="col-md-9">
                                                    <div class="checkbox" >
                                                        <label>
                                                            <input name="rememberme" value="1" type="checkbox"/>
                                                            {$lang.gauth_rememberme|sprintf:$remembering_days}
                                                        </label>
                                                    </div>
                                                </div>
                                            {else}

                                                <div class="hidden-xs  col-md-9"></div>
                                            {/if}
                                            <div class="col-md-3" style="text-align: right">
                                                <button type="submit" value="" class="btn btn-primary btn-block btn-large" style="font-weight:bold;">
                                                    {$lang.Login}
                                                </button>
                                            </div>

                                        </div>
                                    </td>

                                </tr>
                            </table>
                            {securitytoken}
                        </form>
                    </div>

                </div>
            </div>
        </div>
        <div class="lighterblue" style="padding: 13px;"><a href="?action=logout">{$lang.Logout}</a></div>
    </div>

</div>


</body>
</html>