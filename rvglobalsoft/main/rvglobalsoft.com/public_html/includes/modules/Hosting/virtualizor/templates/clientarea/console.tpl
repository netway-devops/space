<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.Console}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar">
    {if $console}

        <div class="onapp_console" style="text-align: center;">
            <div  class="onapp_console" style="text-align: center;">
                <div style="margin: 24px">: <strong></strong></div>
                <table class="table table-striped" style="margin: auto; text-align: left; width: 724px;" cellpadding=4>
                    <tr>
                        <td align="right">VNC {$lang.password}:</td> 
                        <td>
                            <strong>{$console.password}</strong> 
                        </td>
                    </tr>
                </table>
                            
                <APPLET ARCHIVE="http://{$service.ip}:4082/themes/default/java/vnc/TightVncViewer.jar" CODE="com.tightvnc.vncviewer.VncViewer" height="428" width="724">
                    <PARAM NAME="HOST" VALUE="{$console.ip}">
                    <PARAM NAME="PORT" VALUE="{$console.port}">
                    <PARAM NAME="PASSWORD" VALUE="{$console.password}">
                    {*<PARAM NAME="Open New Window" VALUE="yes">*}
                </APPLET>
            </div>

        {else}
            <center><br><br><br><b>{$lang.consoleunavailable}</b><br><br><br><br></center>

        {/if}
    </div>