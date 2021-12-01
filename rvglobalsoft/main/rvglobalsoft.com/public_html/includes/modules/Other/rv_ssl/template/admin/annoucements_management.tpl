<script type="text/javascript" src="{$system_url}{$ca_url}templates/netwaybysidepad/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="{$system_url}{$ca_urL}7944web/templates/default/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{$system_url}{$ca_urL}7944web/templates/default/js/ckeditor/config.js"></script>
<link rel="stylesheet" type="text/css" href="{$system_url}{$ca_url}templates/netwaybysidepad/css/jquery.datetimepicker.css"/ >
<style>
    {literal}
    .td-center{
    	text-align: center;
    }
    .td-padding-10{
    	padding: 10px;
    }
    {/literal}
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td><h3>RV SSL Management</h3></td>
            <td class="searchbox"></td>
        </tr>
        <tr>
            <td class="leftNav">
                {if $submenuList}
                    {foreach from=$submenuList item=menu}
                    <a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}" class="tstyled">{$menu.name}</a>
                    {/foreach}
                {/if}
            </td>
            <td  valign="top">
            	<form action="?cmd={$cmd}&module={$module}&action=annoucements_management&security_token={$security_token}" method="post">
	                <div id="bodycont" >
	                    <div class="blu">
	                        <div align="left">
	                        	<h2>Annoucements Management</h2>
	                        	<br />
	                        	<h1>System Annoucements</h1>
	                        	<br />
	                        </div>
	                        <table id="systemTable" width="100%" border="1" style="border-collapse: collapse;">
	                        	<col width="30%" />
	                        	<col width="10%" />
	                        	<col width="60%" />
	                        	<tr>
	                        		<th class="td-center td-padding-10">Title</th>
	                        		<th class="td-center td-padding-10">Date</th>
	                        		<th class="td-center td-padding-10">Content</th>
	                        	</tr>
	                        	{foreach from=$system_annoucements item=eAnn}
	                        	<tr>
	                        		<td class="td-center">
	                        			<table>
	                        				<col width="2%" />
	                        				<col width="98%" />
	                        				<tr>
	                        					<td><input type="checkbox" name="system_ann[]" value="{$eAnn.id}" {if $eAnn.id|in_array:$system_select}checked{/if}/></td>
	                        					<td><a href="?cmd=annoucements&action=edit&id={$eAnn.id}" target="_blank">{$eAnn.title}</a></td>
	                        				</tr>
	                        			</table>
	                        		</td>
	                        		<td class="td-center">{$eAnn.date|date_format:'%d %b %Y'}</td>
	                        		<td class="td-padding-10">{$eAnn.content}</td>
	                        	</tr>
	                        	{/foreach}
	                        </table>
	                        <br /><br />
	                        <div align="left">
	                        	<h1>WHMCS Annoucements</h1>
	                        	<br />
		                        <a href="javascript:void(0);" onclick="addNewAnnoucement();">Add annoucement</a>
		                        <br /><br />
	                        </div>
	                        <table id="whmcsTable" width="100%" border="1" style="border-collapse: collapse; margin-bottom: 30px;">
	                        	<col width="30%" />
	                        	<col width="10%" />
	                        	<col width="55%" />
	                        	<col width="5%" />
	                        	<col width="5%" />
	                        	<tr class="whmcsTr">
	                        		<th class="td-center td-padding-10 whmcsTh" {if $whmcs_annoucements|@count == 0}style="display: none;"{/if}>Title</th>
	                        		<th class="td-center td-padding-10 whmcsTh" {if $whmcs_annoucements|@count == 0}style="display: none;"{/if}>Date</th>
	                        		<th class="td-center td-padding-10 whmcsTh" {if $whmcs_annoucements|@count == 0}style="display: none;"{/if}>Content</th>
	                        		<th class="td-center td-padding-10 whmcsTh" {if $whmcs_annoucements|@count == 0}style="display: none;"{/if}>Action</th>
	                        	</tr>
	                        	{assign var="index" value=0}
	                        	{foreach from=$whmcs_annoucements item=eWhmcs}
	                        	<tr class="whmcsTr">
						            <td class="td-center">
					            	    <input type="text" name="add_whmcs[{$index}][title]" style="width: 90%;" value="{$eWhmcs.title}"/>
					            	</td>
					                <td class="td-center">
					                    <input type="text" name="add_whmcs[{$index}][date]" class="date-pick" style="text-align: center;" value="{$eWhmcs.date}"/>
					                </td>
					                <td class="td-padding-10">
					                    <textarea style="display:none;" id="text-editor{$index}" name="add_whmcs[{$index}][content]" >{$eWhmcs.content}</textarea>
					                    <script type="text/javascript">
					                    {literal}
					                    CKEDITOR.replace('text-editor{/literal}{$index++}{literal}', {toolbar:'Basic', width:'100%', height:'150px'});
					                    {/literal}
					                    </script>
					                </td>
					                <td class="td-padding-10">
					                    <a href="javascript:void(0);" onclick="$(this).parent().parent().remove();">Delete</a>
					                </td>
					            </tr>
	                        	{/foreach}
	                        </table>
<input type="submit" name="submit" value="Save"/>
&nbsp;&nbsp;
<input type="reset" name="reset" onclick='window.location = window.location.href;' value="Reset"/>
	                    </div>
	                </div>
                </form>
            </td>
        </tr>
    </tbody>
</table>

<script type="text/javascript">
{literal}
	var datepickoption = {
		Default: true
		, format: 'd M Y'
	};
	var index = {/literal}{$index}{literal};

	$("document").ready(function(){
		$('body').on('focus', ".date-pick-new", function(){
		    $(this).datetimepicker(datepickoption);
		});

		$('.date-pick-new').click(function(){
			$(this).click();
		});

	});

	$('.date-pick').datetimepicker(datepickoption);

	function addNewAnnoucement()
	{
		$(".whmcsTr").last().after(`
				 <tr class="whmcsTr">
		            <td class="td-center">
	            	    <input type="text" class="text-editor" name="add_whmcs[` + index + `][title]" style="width: 85%;" required/>
	            	</td>
	                <td class="td-center">
	                    <input type="text" class="date-pick-new" name="add_whmcs[` + index + `][date]" required/>
	                </td>
	                <td class="td-padding-10" colspan="2">
	                    <textarea name="add_whmcs[` + index + `][content]" id="text-editor` + index + `" style="width: 100%; height: 100px;" required></textarea>
	                    <script type="text/javascript">
	                    CKEDITOR.replace('text-editor` + index + `', {toolbar:'Basic', width:'100%', height:'150px'});
	                    <\/script>
	                </td>
	            </tr>
		`);
		$(".whmcsTh").show();
		$(".submitTr").show();
		{/literal}{$index++}{literal}
		index++;
	}
{/literal}
</script>