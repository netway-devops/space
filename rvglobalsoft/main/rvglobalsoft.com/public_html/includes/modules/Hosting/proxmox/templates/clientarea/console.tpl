<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.Console}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar">
    {if $newconsole}

    {literal}
    <script type="text/javascript">
        PVE_vnc_console_event = function(appletid, action, err) {
    //console.log("TESTINIT param1 " + appletid + " action " + action);

    if (action === "error") {
	
    }

    return;
   

};

    </script>
    {/literal}
    {$newconsole}
    {else}
    <center><br><br><br><b>{$lang.consoleunavailable}</b><br><br><br><br></center>

    {/if}
</div>