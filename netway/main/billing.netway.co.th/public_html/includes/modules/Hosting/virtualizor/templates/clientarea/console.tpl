<!DOCTYPE html>
<html>
    <head>
        <title>noVNC</title>
        <meta charset="utf-8">
        <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
                    Remove this if you use the .htaccess -->
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <!-- Apple iOS Safari settings -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <!-- App Start Icon  -->
        <link rel="apple-touch-startup-image" href="images/screen_320x460.png" />
        <!-- For iOS devices set the icon to use if user bookmarks app on their homescreen -->
        <link rel="apple-touch-icon" href="images/screen_57x57.png">
        <!--
        <link rel="apple-touch-icon-precomposed" href="../images/screen_57x57.png" />
        -->
        <!-- Stylesheets -->
        {literal}
            <style>
                /*
             * noVNC base CSS
             * Copyright (C) 2012 Joel Martin
             * Copyright (C) 2013 Samuel Mannehed for Cendio AB
             * noVNC is licensed under the MPL 2.0 (see LICENSE.txt)
             * This file is licensed under the 2-Clause BSD license (see LICENSE.txt).
             */

                body {
                    margin:0;
                    padding:0;
                    font-family: Helvetica;
                    /*Background image with light grey curve.*/
                    background-color:#494949;
                    background-repeat:no-repeat;
                    background-position:right bottom;
                    height:100%;
                }

                html {
                    height:100%;
                }

                #noVNC_controls ul {
                    list-style: none;
                    margin: 0px;
                    padding: 0px;
                }
                #noVNC_controls li {
                    padding-bottom:8px;
                }

                #noVNC_host {
                    width:150px;
                }
                #noVNC_port {
                    width: 80px;
                }
                #noVNC_password {
                    width: 150px;
                }
                #noVNC_encrypt {
                }
                #noVNC_path {
                    width: 100px;
                }
                #noVNC_connect_button {
                    width: 110px;
                    float:right;
                }

                #noVNC_buttons {
                    white-space: nowrap;
                }

                #noVNC_view_drag_button {
                    display: none;
                }
                #sendCtrlAltDelButton {
                    display: none;
                }
                #noVNC_xvp_buttons {
                    display: none;
                }
                #noVNC_mobile_buttons {
                    display: none;
                }

                #noVNC_extra_keys {
                    display: inline;
                    list-style-type: none;
                    padding: 0px;
                    margin: 0px;
                    position: relative;
                }

                .noVNC-buttons-left {
                    float: left;
                    z-index: 1;
                    position: relative;
                }

                .noVNC-buttons-right {
                    float:right;
                    right: 0px;
                    z-index: 2;
                    position: absolute;
                }

                #noVNC_status {
                    font-size: 12px;
                    padding-top: 4px;
                    height:32px;
                    text-align: center;
                    font-weight: bold;
                    color: #fff;
                }

                #noVNC_settings_menu {
                    margin: 3px;
                    text-align: left;
                }
                #noVNC_settings_menu ul {
                    list-style: none;
                    margin: 0px;
                    padding: 0px;
                }

                #noVNC_apply {
                    float:right;
                }

                /* Do not set width/height for VNC_screen or VNC_canvas or incorrect
                 * scaling will occur. Canvas resizes to remote VNC settings */
                #noVNC_screen_pad {
                    margin: 0px;
                    padding: 0px;
                    height: 36px;
                }
                #noVNC_screen {
                    text-align: center;
                    display: table;
                    width:100%;
                    height:100%;
                    background-color:#313131;
                    border-bottom-right-radius: 800px 600px;
                    /*border-top-left-radius: 800px 600px;*/
                }

                #noVNC_container, #noVNC_canvas {
                    margin: 0px;
                    padding: 0px;
                }

                #noVNC_canvas {
                    left: 0px;
                }

                #VNC_clipboard_clear_button {
                    float:right;
                }
                #VNC_clipboard_text {
                    font-size: 11px;
                }

                #noVNC_clipboard_clear_button {
                    float:right;
                }

                /*Bubble contents divs*/
                #noVNC_settings {
                    display:none;
                    margin-top:73px;
                    right:20px;
                    position:fixed;
                }

                #noVNC_controls {
                    display:none;
                    margin-top:73px;
                    right:12px;
                    position:fixed;
                }
                #noVNC_controls.top:after  {
                    right:15px;
                }

                #noVNC_description {
                    display:none;
                    position:fixed;

                    margin-top:73px;
                    right:20px;
                    left:20px;
                    padding:15px;
                    color:#000;
                    background:#eee; /* default background for browsers without gradient support */

                    border:2px solid #E0E0E0;
                    -webkit-border-radius:10px;
                    -moz-border-radius:10px;
                    border-radius:10px;
                }

                #noVNC_popup_status_panel {
                    display:none;
                    position: fixed;
                    z-index: 1;

                    margin:15px;
                    margin-top:60px;
                    padding:15px;
                    width:auto;

                    text-align:center;
                    font-weight:bold;
                    word-wrap:break-word;
                    color:#fff;
                    background:rgba(0,0,0,0.65);

                    -webkit-border-radius:10px;
                    -moz-border-radius:10px;
                    border-radius:10px;
                }

                #noVNC_xvp {
                    display:none;
                    margin-top:73px;
                    right:30px;
                    position:fixed;
                }
                #noVNC_xvp.top:after {
                    right:125px;
                }

                #noVNC_clipboard {
                    display:none;
                    margin-top:73px;
                    right:30px;
                    position:fixed;
                }
                #noVNC_clipboard.top:after {
                    right:85px;
                }

                #keyboardinput {
                    width:1px;
                    height:1px;
                    background-color:#fff;
                    color:#fff;
                    border:0;
                    position: relative;
                    left: -40px;
                    z-index: -1;
                }

                /*
                 * Advanced Styling
                 */

                .noVNC_status_normal {
                    background: #b2bdcd; /* Old browsers */
                    background: -moz-linear-gradient(top, #b2bdcd 0%, #899cb3 49%, #7e93af 51%, #6e84a3 100%); /* FF3.6+ */
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#b2bdcd), color-stop(49%,#899cb3), color-stop(51%,#7e93af), color-stop(100%,#6e84a3)); /* Chrome,Safari4+ */
                    background: -webkit-linear-gradient(top, #b2bdcd 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* Chrome10+,Safari5.1+ */
                    background: -o-linear-gradient(top, #b2bdcd 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* Opera11.10+ */
                    background: -ms-linear-gradient(top, #b2bdcd 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* IE10+ */
                    background: linear-gradient(top, #b2bdcd 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* W3C */
                }
                .noVNC_status_error {
                    background: #f04040; /* Old browsers */
                    background: -moz-linear-gradient(top, #f04040 0%, #899cb3 49%, #7e93af 51%, #6e84a3 100%); /* FF3.6+ */
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f04040), color-stop(49%,#899cb3), color-stop(51%,#7e93af), color-stop(100%,#6e84a3)); /* Chrome,Safari4+ */
                    background: -webkit-linear-gradient(top, #f04040 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* Chrome10+,Safari5.1+ */
                    background: -o-linear-gradient(top, #f04040 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* Opera11.10+ */
                    background: -ms-linear-gradient(top, #f04040 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* IE10+ */
                    background: linear-gradient(top, #f04040 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* W3C */
                }
                .noVNC_status_warn {
                    background: #f0f040; /* Old browsers */
                    background: -moz-linear-gradient(top, #f0f040 0%, #899cb3 49%, #7e93af 51%, #6e84a3 100%); /* FF3.6+ */
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f0f040), color-stop(49%,#899cb3), color-stop(51%,#7e93af), color-stop(100%,#6e84a3)); /* Chrome,Safari4+ */
                    background: -webkit-linear-gradient(top, #f0f040 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* Chrome10+,Safari5.1+ */
                    background: -o-linear-gradient(top, #f0f040 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* Opera11.10+ */
                    background: -ms-linear-gradient(top, #f0f040 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* IE10+ */
                    background: linear-gradient(top, #f0f040 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* W3C */
                }

                /* Control bar */
                #noVNC-control-bar {
                    position:fixed;

                    display:block;
                    height:36px;
                    left:0;
                    top:0;
                    width:100%;
                    z-index:200;
                }

                .noVNC_status_button {
                    padding: 4px 4px;
                    vertical-align: middle;
                    border:1px solid #869dbc;
                    -webkit-border-radius: 6px;
                    -moz-border-radius: 6px;
                    border-radius: 6px;
                    background: #b2bdcd; /* Old browsers */
                    background: -moz-linear-gradient(top, #b2bdcd 0%, #899cb3 49%, #7e93af 51%, #6e84a3 100%); /* FF3.6+ */
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#b2bdcd), color-stop(49%,#899cb3), color-stop(51%,#7e93af), color-stop(100%,#6e84a3)); /* Chrome,Safari4+ */
                    background: -webkit-linear-gradient(top, #b2bdcd 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* Chrome10+,Safari5.1+ */
                    background: -o-linear-gradient(top, #b2bdcd 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* Opera11.10+ */
                    background: -ms-linear-gradient(top, #b2bdcd 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* IE10+ */
                    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#b2bdcd', endColorstr='#6e84a3',GradientType=0 ); /* IE6-9 */
                    background: linear-gradient(top, #b2bdcd 0%,#899cb3 49%,#7e93af 51%,#6e84a3 100%); /* W3C */
                    /*box-shadow:inset 0.4px 0.4px 0.4px #000000;*/
                }

                .noVNC_status_button_selected {
                    padding: 4px 4px;
                    vertical-align: middle;
                    border:1px solid #4366a9;
                    -webkit-border-radius: 6px;
                    -moz-border-radius: 6px;
                    background: #779ced; /* Old browsers */
                    background: -moz-linear-gradient(top, #779ced 0%, #3970e0 49%, #2160dd 51%, #2463df 100%); /* FF3.6+ */
                    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#779ced), color-stop(49%,#3970e0), color-stop(51%,#2160dd), color-stop(100%,#2463df)); /* Chrome,Safari4+ */
                    background: -webkit-linear-gradient(top, #779ced 0%,#3970e0 49%,#2160dd 51%,#2463df 100%); /* Chrome10+,Safari5.1+ */
                    background: -o-linear-gradient(top, #779ced 0%,#3970e0 49%,#2160dd 51%,#2463df 100%); /* Opera11.10+ */
                    background: -ms-linear-gradient(top, #779ced 0%,#3970e0 49%,#2160dd 51%,#2463df 100%); /* IE10+ */
                    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#779ced', endColorstr='#2463df',GradientType=0 ); /* IE6-9 */
                    background: linear-gradient(top, #779ced 0%,#3970e0 49%,#2160dd 51%,#2463df 100%); /* W3C */
                    /*box-shadow:inset 0.4px 0.4px 0.4px #000000;*/
                }


                /*Settings Bubble*/
                .triangle-right {
                    position:relative;
                    padding:15px;
                    margin:1em 0 3em;
                    color:#fff;
                    background:#fff; /* default background for browsers without gradient support */
                    /* css3 */
                    /*background:-webkit-gradient(linear, 0 0, 0 100%, from(#2e88c4), to(#075698));
                    background:-moz-linear-gradient(#2e88c4, #075698);
                    background:-o-linear-gradient(#2e88c4, #075698);
                    background:linear-gradient(#2e88c4, #075698);*/
                    -webkit-border-radius:10px;
                    -moz-border-radius:10px;
                    border-radius:10px;
                    color:#000;
                    border:2px solid #E0E0E0;
                }

                .triangle-right.top:after {
                    border-color: transparent #E0E0E0;
                    border-width: 20px 20px 0 0;
                    bottom: auto;
                    left: auto;
                    right: 50px;
                    top: -20px;
                }

                .triangle-right:after {
                    content:"";
                    position:absolute;
                    bottom:-20px; /* value = - border-top-width - border-bottom-width */
                    left:50px; /* controls horizontal position */
                    border-width:20px 0 0 20px; /* vary these values to change the angle of the vertex */
                    border-style:solid;
                    border-color:#E0E0E0 transparent;
                    /* reduce the damage in FF3.0 */
                    display:block;
                    width:0;
                }

                .triangle-right.top:after {
                    top:-40px; /* value = - border-top-width - border-bottom-width */
                    right:50px; /* controls horizontal position */
                    bottom:auto;
                    left:auto;
                    border-width:40px 40px 0 0; /* vary these values to change the angle of the vertex */
                    border-color:transparent #E0E0E0;
                }

                /*Default noVNC logo.*/
                /* From: http://fonts.googleapis.com/css?family=Orbitron:700 */
                @font-face {
                    font-family: 'Orbitron';
                    font-style: normal;
                    font-weight: 700;
                    src: local('?'), url('Orbitron700.woff') format('woff'),
                        url('Orbitron700.ttf') format('truetype');
                }

                #noVNC_logo {
                    margin-top: 170px;
                    margin-left: 10px;
                    color:yellow;
                    text-align:left;
                    font-family: 'Orbitron', 'OrbitronTTF', sans-serif;
                    line-height:90%;
                    text-shadow:
                        5px 5px 0 #000,
                        -1px -1px 0 #000,
                        1px -1px 0 #000,
                        -1px 1px 0 #000,
                        1px 1px 0 #000;
                }


                #noVNC_logo span{
                    color:green;
                }

                /* ----------------------------------------
                 * Media sizing
                 * ----------------------------------------
                 */


                .noVNC_status_button {
                    font-size: 12px;
                }

                #noVNC_clipboard_text {
                    width: 500px;
                }

                #noVNC_logo {
                    font-size: 180px;
                }

                .noVNC-buttons-left {
                    padding-left: 10px;
                }

                .noVNC-buttons-right {
                    padding-right: 10px;
                }

                #noVNC_status {
                    z-index: 0;
                    position: absolute;
                    width: 100%;
                    margin-left: 0px;
                }

                #showExtraKeysButton { display: none; }
                #toggleCtrlButton { display: inline; }
                #toggleAltButton {  display: inline; }
                #sendTabButton { display: inline; }
                #sendEscButton { display: inline; }

                /* left-align the status text on lower resolutions */
                @media screen and (max-width: 800px){
                    #noVNC_status {
                        z-index: 1;
                        position: relative;
                        width: auto;
                        float: left;
                        margin-left: 4px;
                    }
                }

                @media screen and (max-width: 640px){
                    #noVNC_clipboard_text {
                        width: 410px;
                    }
                    #noVNC_logo {
                        font-size: 150px;
                    }
                    .noVNC_status_button {
                        font-size: 10px;
                    }
                    .noVNC-buttons-left {
                        padding-left: 0px;
                    }
                    .noVNC-buttons-right {
                        padding-right: 0px;
                    }
                    /* collapse the extra keys on lower resolutions */
                    #showExtraKeysButton {
                        display: inline;
                    }
                    #toggleCtrlButton {
                        display: none;
                        position: absolute;
                        top: 30px;
                        left: 0px;
                    }
                    #toggleAltButton {
                        display: none;
                        position: absolute;
                        top: 65px;
                        left: 0px;
                    }
                    #sendTabButton {
                        display: none;
                        position: absolute;
                        top: 100px;
                        left: 0px;
                    }
                    #sendEscButton {
                        display: none;
                        position: absolute;
                        top: 135px;
                        left: 0px;
                    }
                }

                @media screen and (min-width: 321px) and (max-width: 480px) {
                    #noVNC_clipboard_text {
                        width: 250px;
                    }
                    #noVNC_logo {
                        font-size: 110px;
                    }
                }

                @media screen and (max-width: 320px) {
                    .noVNC_status_button {
                        font-size: 9px;
                    }
                    #noVNC_clipboard_text {
                        width: 220px;
                    }
                    #noVNC_logo {
                        font-size: 90px;
                    }
                }
            </style>
        {/literal}
    </head>
    <body>
        <div id="noVNC_screen">
            <div id="noVNC_status_bar" class="noVNC_status_bar" style="margin-top: 0px;">
                <table border=0 width="100%">
                    <tr>
                        <td>
                            <div id="noVNC_status" style="position: relative; height: auto;">
                                Loading
                            </div>
                        </td>
                        <td width="1%">
                            <div id="noVNC_buttons">
                                <input type=button value="Send CtrlAltDel"
                                       id="sendCtrlAltDelButton">
                                <span id="noVNC_xvp_buttons">
                                    <input type=button value="Shutdown"
                                           id="xvpShutdownButton">
                                    <input type=button value="Reboot"
                                           id="xvpRebootButton">
                                    <input type=button value="Reset"
                                           id="xvpResetButton">
                                </span>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <canvas id="noVNC_canvas" width="640px" height="20px">
                Canvas not supported.
            </canvas>
        </div>
        <script src="{$moduledir_url}novnc/util.js" type="text/javascript"></script>
        {literal}
            <script type="text/javascript">
                // Load supporting scripts
                var INCLUDE_URI = {/literal}'{$moduledir_url}novnc/'{literal};
                Util.load_scripts(["webutil.js", "base64.js", "websock.js", "des.js",
                    "keysym.js", "keysymdef.js", "keyboard.js", "input.js", "display.js",
                    "jsunzip.js", "rfb.js"]);

                var rfb;
                var resizeTimeout;
                function UIresize() {
                    if (WebUtil.getQueryVar('resize', false)) {
                        var innerW = window.innerWidth;
                        var innerH = window.innerHeight;
                        var controlbarH = $D('noVNC_status_bar').offsetHeight;
                        var padding = 5;
                        if (innerW !== undefined && innerH !== undefined)
                            rfb.setDesktopSize(innerW, innerH - controlbarH - padding);
                    }
                }
                function FBUComplete(rfb, fbu) {
                    UIresize();
                    rfb.set_onFBUComplete(function () {
                    });
                }

                function passwordRequired(rfb) {
                    var msg;
                    msg = '<form onsubmit="return setPassword();"';
                    msg += '  style="margin-bottom: 0px">';
                    msg += 'Password Required: ';
                    msg += '<input type=password size=10 id="password_input" class="noVNC_status">';
                    msg += '<\/form>';
                    $D('noVNC_status_bar').setAttribute("class", "noVNC_status_warn");
                    $D('noVNC_status').innerHTML = msg;
                }
                function setPassword() {
                    rfb.sendPassword($D('password_input').value);
                    return false;
                }
                function sendCtrlAltDel() {
                    rfb.sendCtrlAltDel();
                    return false;
                }
                function xvpShutdown() {
                    rfb.xvpShutdown();
                    return false;
                }
                function xvpReboot() {
                    rfb.xvpReboot();
                    return false;
                }
                function xvpReset() {
                    rfb.xvpReset();
                    return false;
                }
                function updateState(rfb, state, oldstate, msg) {
                    var s, sb, cad, level;

                    if (window.location.protocol === "https:" && oldstate == "connect" && state == "failed") {
                        window.location = window.location.href.replace('https', 'http');
                        state = 'normal';
                        msg = "Reconnecting..";
                    }

                    s = $D('noVNC_status');
                    sb = $D('noVNC_status_bar');
                    cad = $D('sendCtrlAltDelButton');

                    switch (state) {
                        case 'failed':
                            level = "error";
                            break;
                        case 'fatal':
                            level = "error";
                            break;
                        case 'normal':
                            level = "normal";
                            break;
                        case 'disconnected':
                            level = "normal";
                            break;
                        case 'loaded':
                            level = "normal";
                            break;
                        default:
                            level = "warn";
                            break;
                    }

                    if (state === "normal") {
                        cad.disabled = false;
                    } else {
                        cad.disabled = true;
                        xvpInit(0);
                    }

                    if (typeof (msg) !== 'undefined') {
                        sb.setAttribute("class", "noVNC_status_" + level);
                        s.innerHTML = msg;
                    }
                }

                function xvpInit(ver) {
                    var xvpbuttons;
                    xvpbuttons = $D('noVNC_xvp_buttons');
                    if (ver >= 1) {
                        xvpbuttons.style.display = 'inline';
                    } else {
                        xvpbuttons.style.display = 'none';
                    }
                }

                window.onresize = function () {
                    // When the window has been resized, wait until the size remains
                    // the same for 0.5 seconds before sending the request for changing
                    // the resolution of the session
                    clearTimeout(resizeTimeout);
                    resizeTimeout = setTimeout(function () {
                        UIresize();
                    }, 500);
                };

                window.onscriptsload = function () {                  
                    var connect = {
            {/literal}
                        'target': $D('noVNC_canvas'),
                        'encrypt': window.location.protocol === "https:",
                        //'repeaterID': WebUtil.getQueryVar('repeaterID', ''),
                        'true_color': true,
                        'local_cursor': true,
                        'shared': true,
                        'view_only': false,
                        'onUpdateState': updateState,
                        'onXvpInit': xvpInit,
                        'onPasswordRequired': passwordRequired
            {literal}
                    };

                    $D('sendCtrlAltDelButton').style.display = "inline";
                    $D('sendCtrlAltDelButton').onclick = sendCtrlAltDel;
                    $D('xvpShutdownButton').onclick = xvpShutdown;
                    $D('xvpRebootButton').onclick = xvpReboot;
                    $D('xvpResetButton').onclick = xvpReset;

                    rfb = new RFB(connect);
                    rfb.connect({/literal}'{$vnc.host}', '{$vnc.port}', '{$vnc.password}', '{$vnc.websocket}?virttoken={$vnc.token}'{literal});
                };

            </script>
        {/literal}
    </body>
</html>