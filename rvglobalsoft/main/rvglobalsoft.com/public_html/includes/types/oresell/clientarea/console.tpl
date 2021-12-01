
{if !$popup}
    <div class="header-bar">
        <h3 class="{$vpsdo} hasicon">{$lang.Console}</h3>
        <div class="clear"></div>
    </div>
    <div class="content-bar">
    {else}
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <base href="{$system_url}" />
                <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name}</title>
                <script type="text/javascript" src="templates/default/js/jquery.js"></script>
                {userheader}
            </head>

            <body class="{$language|capitalize}">
            {/if}
            {if $newconsole}
                {if $console.html5}
                    {literal}
                        <style>
                            html {
                                height: 100%;
                            }
                            body {
                                height: 100%;
                                margin: 0;
                                background-repeat: no-repeat;
                                background-attachment: fixed;
                                background-color: #171717;
                                background-image: linear-gradient(#272727, #171717);
                                color: #333;
                                font-family: "HelveticaNeue-Light","Helvetica Neue Light","Helvetica Neue",Helvetica,Arial,"Lucida Grande",sans-serif;
                                font-size: 75%;
                                line-height: 1.5;
                            }
                            div.flash{
                                background-color: #d3b75e;
                                background-image: linear-gradient(#e8d070, #bc9f3f);
                                box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.1), 0 1px 0 #9f8c4e inset;
                                color: #fff;
                                text-shadow: 0 1px 1px rgba(0, 0, 0, 0.35);
                            }
                            div.flash.error, div.flash.alert, div.flash.error-message {
                                background-color: #c93841;
                                background-image: linear-gradient(#dc3f4b, #b73137);
                                border-bottom: 1px solid #8a252a;
                                box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.1), 0 1px 0 #e44950 inset;
                            }

                            div.flash.success, div.flash.notice {
                                background-color: #89ae59;
                                background-image: linear-gradient(#a3ce68, #708e4a);
                                border-bottom: 1px solid #4e7b22;
                                box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.1), 0 1px 0 #b4d584 inset;
                            }
                            div button{
                                -moz-border-bottom-colors: none;
                                -moz-border-left-colors: none;
                                -moz-border-right-colors: none;
                                -moz-border-top-colors: none;
                                background-color: #eeeeee;
                                background-image: linear-gradient(rgba(247, 247, 247, 0.85) 0%, rgba(246, 247, 247, 0.85) 25%, rgba(236, 238, 239, 0.85) 85%, rgba(232, 232, 234, 0.85) 100%);
                                border-color: #c5c4c4 #c5c4c4 #a7a6a6;
                                border-image: none;
                                border-radius: 3px;
                                border-style: solid;
                                border-width: 1px;
                                box-shadow: 0 1px 1px 1px rgba(255, 255, 255, 0.6) inset, 0 1px 0 #f0f0f0;
                                color: #7c7c7c;
                                cursor: pointer !important;
                                display: inline-block;
                                font-family: "Helvetica Neue",Arial,Verdana,sans-serif;
                                font-size: 12px;
                                font-weight: bold;
                                line-height: 24px;
                                padding: 4px 10px 3px;
                                text-align: center;
                                text-shadow: 0 1px 1px rgba(255, 255, 255, 0.8);
                                vertical-align: middle;
                            }
                            div.flash {
                                display: block;
                                font-weight: bold;
                                line-height: 21px;
                                padding: 10px 30px 10px 10px;
                                position: relative;
                            }
                            .bp-reset-element, body, h1, h2, h3, h4, h5, h6, article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary, blockquote, q, th, td, caption, table, div, span, object, iframe, p, pre, a, abbr, acronym, address, code, del, dfn, em, img, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, caption, tbody, tfoot, thead, tr {
                                border: 0 none;
                                font-family: inherit;
                                font-size: 100%;
                                font-style: inherit;
                                font-weight: inherit;
                                margin: 0;
                                padding: 0;
                                vertical-align: baseline;
                            }
                            .submit{
                                float:right
                            }
                        </style>
                    {/literal}
                    <script type="text/javascript">
                        var Console ={literal} {}{/literal};
                        Console.Host = "{$console.host}";
                        Console.Port = 443;
                        Console.VMID = "{$vpsdetails.identifier}";
                        Console.Pass = "{$console.password}";
                        Console.Key = "{$console.remote_key}";
                    </script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/util.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/webutil.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/base64.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/websock.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/des.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/input.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/display.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/jsunzip.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/rfb.js" type="text/javascript"></script>
                    <script src="{$system_url}includes/types/onappcloud/js/novnc/novnc.init.js" type="text/javascript"></script>

                    <div id='no_vnc_status_bar'>
                        <div id='no_vnc_status'>{$lang.loading}</div>
                        <canvas id='no_vnc_canvas'>{$lang.yourbrowsernotsupported}</canvas>
                        <div style="overflow: hidden; margin: 10px;">
                            <div class='submit'>
                                <button data-confirm='{$lang.aresurewantsendctrlaltdel}' id='send_ctrl_alt_del_button'>Ctrl+Alt+Del</button>
                            </div>
                            <div class="reconnect">
                                <button id="reconnect" data-confirm="Are you sure you want to re-connect?">{$lang.reconnect}</button>
                            </div>
                        </div>
                    </div>
                {else}
                    {$newconsole}
                {/if}
                {* If you want to customize applet size, remove {$newconsole} and replace it with template below.
                {*
                <applet archive="{$console.archive}" codebase="{$console.archive}" code="VncViewer.class" height="560" width="700">
                <param name="PORT" value="{$console.port}" />
                <param name="REMOTEKEY" value="{$console.remote_key}" />
                <param name="REMOTE KEY" value="{$console.remote_key}" />
                <param name="REMOTE_KEY" value="{$console.remote_key}" />
                <param name="PASSWORD" value="{$console.password}" />
                <param name="Scaling factor" VALUE=87 />
                </applet>
                *}
            {else}
                <center>
                    <br><br><br><b>{$lang.consoleunavailable}</b>
                                <br><br><br><br>
                                                </center>
                                            {/if}{if !$popup}
                                                </div>
                                            {else}
                                                </body>
                                                </html>
                                            {/if}