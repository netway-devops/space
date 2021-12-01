<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.Console}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar">
    {if $newconsole}
   <center> {$newconsole} </center>
    {else}
    <center><br><br><br><b>{$lang.consoleunavailable}</b><br><br><br><br></center>

    {/if}
</div>