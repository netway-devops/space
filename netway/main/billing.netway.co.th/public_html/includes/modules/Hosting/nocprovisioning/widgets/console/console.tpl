{*
 * NOC-PS Hostbill module
 * Console template
 *
 * Copyright (C) Maxnet 2013-2014
 *
 * May be distributed under the terms of the LGPL license.
 * In plain English: feel free to use and modify this file to fit your needs,
 * however do NOT ioncube encode it.
 * The source code must be available to anyone you distribute this module to.
 *}

<div class="wbox"><div class="wbox_header">Console</div><div class="wbox_content">

{if $errormsg}
<b>{$errormsg}</b>
{else}

<form name="ajaxform" method="post" action="" onsubmit="this.elements['submit'].disabled=true"{if $consoletype == 'html5'} target="_blank"{/if}>
    <input type="hidden" name="nps_nonce" value="{$nonce}">
    <input type="hidden" name="action" value="getconsoleurl">
    
{if $powered_off}
        <input type="checkbox" name="powerup" checked> Power up server<br>
{/if}
{if $ask_ipmi_password}
        IPMI password: <input type="password" name="ipmipassword"><br>
{/if}
    <input type="submit" name="submit" value="Activate console">
</form>

{if $consoletype == 'html5'}

Press the 'activate console' button to open the console in a new window.<br>
The console feature requires a modern browser such as Firefox or Google Chrome supporting HTML 5 canvas and websockets.<br>
In addition a SSL certificate must have been installed on the NOC-PS managament server by your provider.

{else}

Press the 'activate console' button to open the console.<br>
The console feature uses Java Webstart technology and requires that JAVA is installed on your computer.<br>
If you have problems accessing the console, try resetting the BMC.<br><br>

<form method="post" action="" onsubmit="this.elements['submit'].disabled=true">
    <input type="hidden" name="nps_nonce" value="{$nonce}">
    <input type="hidden" name="resetbmc" value="1">
    
{if $ask_ipmi_password}
    IPMI password: <input type="password" name="ipmipassword"><br>
{/if}
    <input type="submit" name="submit" value="Reset BMC">
</form>
{/if}
{/if}

</div>
</div>