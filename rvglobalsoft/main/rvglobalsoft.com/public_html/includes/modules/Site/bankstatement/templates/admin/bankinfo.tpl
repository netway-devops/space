<script src="{$system_url}includes/modules/Site/bankstatement/templates/js/script.js"></script>
<link href="{$template_dir}css/bootstrap.customize.css?v={$hb_version}" rel="stylesheet" media="all" />
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
<tr>
    <td ><h3>Bank info</h3></td>
    <td  class="searchbox">

    </td>
</tr>
<tr>
    <td class="leftNav">
        {include file="$tplPath/admin/leftmenu.tpl"}
    </td>
    <td valign="top" class="bordered">
    <div id="bodycont"> 
    
    {include file="$tplClientPath/netway/notificationinfo.tpl"}
	
	<div class="sectionhead_ext">Bank info &rarr; {$aBankTransfer[$id]}</div>
	
	<div id="client_tab" class="ticketmsg ticketmain">
        <div class="slide" style="display:block;">
		    
            <div id="tdetail" class="right replybtn tdetail">
            	<strong>
            		<a href="#">
            			<span class="a1" style="display: inline;">Edit details</span>
						<span class="a2" style="display: none;">Hide details</span>
					</a>
				</strong>
			</div>
			
			<div id="detcont">
				
				<div class="tdetails">
	        	{if count($aConfig)}
				<table border="0" cellspacing="2" cellpadding="2" width="100%">
	            <tbody>
	            	{foreach from=$aConfig key=name item=data}
	            	<tr>
	            		<td width="250">{$name}</td>
						<td><span class="livemode">{$data.value}</span></td>
	            	</tr>
					{/foreach}
	            </tbody>
	        	</table>
				{/if}
				</div>
				
				<div class="secondtd" style="display:none">
                {if count($aConfig)}
		        <form id="testform" method="post">
		        {securitytoken}
				<input type="hidden" name="cmd" value="{$cmd}" />
		        <input type="hidden" name="action" value="bankinfoupdate" />
				<input type="hidden" name="id" value="{$id}" />
                <table border="0" cellspacing="2" cellpadding="2" width="100%">
                <tbody>
                    {foreach from=$aConfig key=name item=data}
                    <tr valign="top">
                        <td width="250">{$name}</td>
                        <td>
                        	{if $data.type == 'textarea'}
							<textarea name="data[{$name}]" cols="80" rows="5">{$data.value}</textarea>
							{else}
							<input type="text" name="data[{$name}]" value="{$data.value}" size="80">
							{/if}
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
                </table>
				
				<div style="text-align: center; margin-bottom: 7px; padding: 15px 0px;" class="p6">
				    <a onclick="$('#savechanges').click(); return false;" href="#" class="new_control greenbtn"><span>Save Changes</span></a>
				    <span class="orspace fs11">Or</span> <a onclick="$('#tdetail a').click();return false;" class="editbtn" href="#">Cancel</a>
				    <input type="submit" name="save" style="display:none" id="savechanges" value="Save Changes">
				    <input type="hidden" name="save" value="1">
				</div>
				</form>
                {/if}
				</div>
				
			</div>
			
        </div>
    </div>
	      
    </div>
    </td>
  </tr>
</table>
{literal}
<script language="JavaScript">
$(document).ready(function($){
bankinfoBlind();
});
</script>
{/literal}
