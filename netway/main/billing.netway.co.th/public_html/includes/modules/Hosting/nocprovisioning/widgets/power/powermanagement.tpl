{*
 * NOC-PS Hostbill module
 * Power management template
 *
 * Copyright (C) Maxnet 2010-2012
 *
 * You are free to modify this module to fit your needs
 * However be aware that you need a NOC-PS license to actually provision servers
 *}

<div class="wbox"><div class="wbox_header">Power management</div><div class="wbox_content">

{if $errormsg}
<p>
  <b>Error:</b> {$errormsg}
</p>
{elseif !$ip}
Your order has not been assigned to a server yet!
{else}

<form name="ajaxform" method="post" action="" onsubmit="this.elements['performbutton'].disabled=true">
  <input type="hidden" name="nps_nonce" value="{$nonce}" />

  <table width="100%" cellpadding="10" cellspacing="10">
          <tr>
            <td width="150" class="fieldarea">Main server IP-address</td>
            <td>{$ip}</td>
          </tr>

		  {if $result}
		  <tr>
			<td width="150" class="fieldarea"><b>Result of last action</b></td>
		    <td><font color="green">{$result|escape}</font></td>
		  </tr>
		  {/if}

          <tr>
            <td width="150" class="fieldarea">Power status</td>
            <td>{$status|escape}</td>
          </tr>
		  
{if $ask_ipmi_password}
          <tr>
            <td width="150" class="fieldarea">Your server's IPMI password</td>
            <td><input type="password" name="ipmipassword" style="width: 350px;"></td>
          </tr>
{/if}
          <tr>
            <td width="150" class="fieldarea">Power action</td>
            <td>
{if $supportsOn}			  
			  <input type="radio" name="poweraction" value="on"> Power on<br>
{/if}{if $supportsOff}			  
			  <input type="radio" name="poweraction" value="off"> Power off<br>
{/if}{if $supportsReset}			  
			  <input type="radio" name="poweraction" value="reset" checked="true"> Reset<br>
{/if}{if $supportsCycle}			  
			  <input type="radio" name="poweraction" value="cycle" {if !$supportsReset}checked="true"{/if}> Cycle power<br>
{/if}{if $supportsCtrlAltDel}
			  <input type="radio" name="poweraction" value="ctrlaltdel"> Send CTRL-ALT-DEL<br>
{/if}
			</td>
          </tr>

		  <tr>
			<td>&nbsp;
			<td><input type="submit" name="performbutton" value="Perform action">
		  </tr>
  </table>
</form>
{/if}

</div></div></div>