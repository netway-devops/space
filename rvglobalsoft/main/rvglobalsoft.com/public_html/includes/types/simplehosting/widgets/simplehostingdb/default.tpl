{if $cperror}
	<div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
		{$lang.couldconectto} <strong>CPanel</strong><br>
		{$lang.checkyourloginpassword}
	</di>
{else}
<div >
    {foreach from=$widgets item=wig}
        {if $widget.name == $wig.name}
            {assign value=$wig.location var=widgeturl}
        {/if}
    {/foreach}
	<div id="billing_info" class="wbox form-inline">
		<div class="wbox_header"> <a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}">{$widget_lang.db_list}</a> | <a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act=usermanage">{$widget_lang.db_users}</a> | <a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act=hostmanage">{$widget_lang.host_list}</a></div>
		<div class="wbox_content">
			{literal}
			<script type="text/javascript"> 
				$(document).ready(function(){
					$('.management_links').each(function (i){
						$(this).children().eq(0).click(function(){$(this).parents('tr').next().toggle();return false;});
						$(this).children().eq(1).click(function(){$(this).parents('tr').next().next().toggle();return false;});
						$(this).parent().next().find('img[title]').click(updateprivs);
					});
				});
				function dologin(){ 
				// 	if($('#myadmin').lenght)
						$('#myadmin').submit();
					return false;
				}
				function updateprivs(){
							$(this).unbind('click');
							var thisvar = $(this);
							var oldimg = $(this).attr('src'); 
							$(this).attr('src', '{/literal}{$template_dir}{literal}img/ajax-loading2.gif'); 
							var command = $(this).attr('title') == "Remove"? 'removeacces' : 'grantacces';
							
							$.ajax({
								type: 'POST',
								url : '{/literal}?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act=usermanage{literal}', 
								data: {dbname : $(this).prev().text(), username:  $(this).parents('tr').prev().children().eq(0).text(), updateprivs : command} ,
								success: function(data) {
									if(!data.event.result) {thisvar.attr('src', oldimg).click(updateprivs); return false; }
									if(thisvar.attr('title') == 'Remove')
									thisvar.attr('src', '{/literal}{$widgeturl}{literal}more_info.gif').attr('title','Grant Acces').attr('alt','Grant Acces');
									else thisvar.attr('src', '{/literal}{$widgeturl}{literal}trash.gif').attr('title','Remove').attr('alt','Remove');
									thisvar.click(updateprivs);
								}, 
								error:  function(data) {
									thisvar.attr('src', oldimg).click(updateprivs);
								},
						   dataType: 'json'});
						   
						}
			</script>
			{/literal}
			{if $myadmin}
			<form action="{$myadmin}/login/" method="post" target="_blank" id="myadmin" >
			<input type="hidden" name="user" value="{$myadmin_user}" />
			<input type="hidden" name="pass" value="{$myadmin_pass}" />
			<input type="hidden" name="login_theme" value="cpanel" />
			<input type="hidden" name="goto_uri" value="frontend/x3/sql/PhpMyAdmin.html" />
			</form>
			{/if}
			<form autocomplete="off" action="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}" method="post">
			<table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
{if $act=='default'}
				<thead>
					<tr>
					<td align="right">{$widget_lang.db_name}</td>
					<td align="center">{$lang.type}</td>
					<td align="center">{$widget_lang.management_functions}</td>
					</tr>
				</thead>
				<tbody id="updater">
				{include file="$widget_dir`$widget.ajaxtpl`"}
				</tbody>
				<tfoot>
					<tr><td style="border:none" colspan="3" align="right"><input type="submit" name="save" value="{$widget_lang.add_new_db}" class="btn"> <input type="text" name="name"></td></tr>
				</tfoot>
			
{elseif $act=='usermanage'}
			
				<thead>
					<tr>
					<td align="right">{$widget_lang.db_username}</td>
					<td align="center">{$widget_lang.management_functions}</td>
					</tr>
				</thead>
				<tbody id="updater">
				{include file="$widget_dir`$widget.ajaxtpl`"}
				</tbody>
				<tfoot>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td colspan="2"  align="left">{$widget_lang.add_new_usr}</td></tr>
					<tr>
						<td style="border:none" colspan="2" align="right">
							<div style="display:table-cell; padding:0 3px">{$widget_lang.db_username}:<br> <input autocomplete="off" type="text" name="name" class="span2" ></div>
							<div style="display:table-cell; padding:0 3px">{$lang.password}: <br><input autocomplete="off" type="password" name="passmain" class="span2"></div>
							<div style="display:table-cell; padding:0 3px">{$lang.confirmpassword}:<br> <input autocomplete="off" type="password" name="passcheck" class="span2"></div>
							<div style="display:table-cell; padding:0 3px;vertical-align:bottom">
								<select name="database" class="span2">
									<option>{$lang.none}</option>
									{if $listdb}
										{foreach from=$listdb item=dbentry}
									<option>{$dbentry.db}</option>
										{/foreach}
									{/if}
								</select>
							</div>		
							<div style="display:table-cell; padding:0 3px;vertical-align:bottom"><input type="submit" name="save" value="{$lang.shortsave}" class="btn"> </div>						
						</td>
					</tr>
				</tfoot>
			
{elseif $act=='hostmanage'}
			
				<thead>
					<tr>
					<td align="right">{$widget_lang.ip_list}</td>
					<td align="center">{$widget_lang.management_functions}</td>
					</tr>
				</thead>
				<tbody>
				{include file="$widget_dir`$widget.ajaxtpl`"}
				</tbody>
				<tfoot>
					<tr><td style="border:none" colspan="3" align="right">Host (% {$lang.wildcardallowed}): <input type="submit" name="save" value="{$widget_lang.add_new_ip}" class="btn"> 
                            <input type="text" name="name"></td></tr>
				</tfoot>
			
{/if}
			</table>
			</form>
		</div>
	</div>
</div>
{/if}