<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.Console}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar">
    {if $newconsole}
        {if $console.html5}
            <script type="text/javascript">
            var Console ={literal}{}{/literal};
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
            <div id='no_vnc_status'>Loading</div>
            <canvas id='no_vnc_canvas'>Your browser is not supported</canvas>
            <div class='submit'>
                <button data-confirm='Are you sure you want to send Ctrl+Alt+Del?' id='send_ctrl_alt_del_button'>Ctrl+Alt+Del</button>
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
    {/if}
</div>