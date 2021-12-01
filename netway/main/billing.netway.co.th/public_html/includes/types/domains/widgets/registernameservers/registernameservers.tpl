 <div class="wbox">
    <div class="wbox_header">{$lang.registernstitle}<span style="float: right;">
             <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/" class="fs11">{$lang.cancel}</a>
        </span></div>
    <div  class="wbox_content">
         <form action="" method="post">
         <input type="hidden" name="submit" value="1" />
         <input type="hidden" name="widgetdo" value="RegisterNameServers" />
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped">
            {if $getRegisterNameServers}
                <tr class="even"><td width="40%"><strong>{$lang.hostname}</strong></td><td width="25%"><strong>{$lang.ipadd}</strong></td><td width="25%"></td><td width="10%"></td></tr>
                {if $RegisterNameServers}
                    {foreach from=$RegisterNameServers item=ips key=name}
                        {foreach from=$ips item=ip name=ip_list}
                            <tr height="30">
                                <td {if !$smarty.foreach.ip_list.last}style="border-bottom: 0px"{/if}>
									{if $smarty.foreach.ip_list.iteration == "1"}{$name}.{$details.name}{/if}
									<input name="modifyNameServer[NameServer]" value="{$name}" type="hidden" />
									<input name="deleteNameServer[NameServer]" value="{$name}" type="hidden" />
								</td>
                                <td {if !$smarty.foreach.ip_list.last}style="border-bottom: 0px"{/if}>
									<input type="hidden" value="{$ip}"  name="deleteNameServer[NameServerDeleteIP]" />
									<input type="hidden" value="{$ip}"  name="modifyNameServer[NameServerOldIP]" />
									<input class="ip_edit" value="{$ip}" name="modifyNameServer[NameServerNewIP]" style="display: none;" size="15" />
									<span class="ip_notedit">{$ip}</span>
								</td>
                                <td  style="{if !$smarty.foreach.ip_list.last}border-bottom: 0px;{/if} text-align: center">
									<input type="submit" value="{$lang.shortsave}" class="ip_edit" style="display: none;" onclick="update_regns(this, 'modifyNameServer'); return false;" />
									<input type="submit" onclick="$('.ip_edit').hide(); $('.ip_notedit').show(); return false;" value="{$lang.cancel}" class="ip_edit" style="display: none;"/>
									<a href="" onclick="show_nsedit(this); return false;" class="ip_notedit btn btn-primary">{$lang.edit}</a>
								</td>
                                <td {if !$smarty.foreach.ip_list.last}style="border-bottom: 0px"{/if}>
									<a href="" onclick="if(confirm('{$lang.deleteregnsconfirm}')) update_regns(this, 'deleteNameServer'); return false;" class="editbtn btn btn-danger">{$lang.delete}</a>
								</td>
                            </tr>
                        {/foreach}
                    {/foreach}
                {else}
                    <tr><td colspan="4" style="text-align: center">{$lang.no_regservers}</td></tr>
                {/if}

                <tr class="even">
                <td colspan="4">
                        <strong>{$lang.registerns}</strong>
                </td></tr>
                <tr>
                        <td>{$lang.nameserver}</td><td colspan="2"><input type="text" class="styled" name="registerNameServer[NameServer]"/> .{$details.name}</td><td></td>
                </tr>
                <tr>
                        <td>{$lang.ipadd}</td><td colspan="2"><input type="text" class="styled"name="registerNameServer[NameServerIP]"/></td>
                        <td><input type="submit" name="widgetaction[registerNameServer]" value="{$lang.savechanges}" class=" btn btn-primary"/></td>
                </tr>
                <script type="text/javascript">
                 {literal}
                     function show_nsedit(elem) {$('.ip_edit').hide();$('.ip_notedit').show();$(elem).parent().parent().find('.ip_edit').show(); $(elem).parent().parent().find('.ip_notedit').hide();}
                     function update_regns(el, func) {
                        var form = ''; 
						if($('#updatens_form').length > 0) {
							form = $('#updatens_form');
							$('#updatens_form').html('');
						} else 
							form = $('<form id="updatens_form" action="" method="post"></form>').appendTo('body');
                        $(form).append('<input type="hidden" name="widgetaction['+func+']" /><input type="hidden" name="widgetdo" value="RegisterNameServers" />');	
                        $(el).parents('tr').find('input[name^="'+func+'"]').each( function() {
							$(form).append('<input type="hidden" name="'+$(this).attr('name')+'" value="'+$(this).val()+'" />');
						});
                        $('#updatens_form').submit(); return false;
                    }
                 {/literal}
                 </script>
            {else}
                        <tr class="even">
                                <td colspan="4">
                                        <strong>{$lang.registerns}</strong>
                                </td></tr>
                                <tr>
                                        <td>{$lang.nameserver}</td><td colspan="2"><input type="text" class="styled" name="registerNameServer[NameServer]"/> .{$details.name}</td><td></td>
                                </tr>
                                <tr>
                                        <td>{$lang.ipadd}</td><td colspan="2"><input type="text" class="styled" name="registerNameServer[NameServerIP]"/></td>
                                        <td><input type="submit" name="widgetaction[registerNameServer]" value="{$lang.savechanges}" class=" btn btn-primary" /></td>
                                </tr>
                                <tr class="even">
                                <td colspan="4" >
                                        <strong>{$lang.modifynsip}</strong>
                                </td></tr>
                                <tr>
                                        <td>{$lang.nameserver}</td><td colspan="2"><input type="text" class="styled" name="modifyNameServer[NameServer]"/> .{$details.name}</td><td></td>
                                </tr>
                                <tr>
                                        <td>{$lang.currentipadd}</td><td colspan="2"><input type="text" class="styled" name="modifyNameServer[NameServerOldIP]"/></td><td></td>
                                </tr>
                                <tr>
                                        <td>{$lang.newipadd}</td><td colspan="2"><input type="text" class="styled"name="modifyNameServer[NameServerNewIP]"/></td>
                                        <td>  <input type="submit" name="widgetaction[modifyNameServer]" value="{$lang.savechanges}" class=" btn btn-primary" /></td>
                                </tr>
                                <tr class="even">
                                <td colspan="4"  >
                                        <strong>{$lang.delnameserver}</strong>
                                </td></tr>
                                <tr>
                                        <td>{$lang.nameserver}</td><td colspan="2"> <input type="text" class="styled" name="deleteNameServer[NameServer]"/> .{$details.name}</td>
                                        <td> <input type="submit" name="widgetaction[deleteNameServer]" value="{$lang.delete}" class=" btn btn-danger" /></td>
                                </tr>

           {/if}
	</table>
         </form></div></div>