{counter start=0 skip=1 assign=even}
{if $act=='usermanage'}
	{if $listentrys}
		{foreach from=$listentrys item=entry key=index} 
		<tr {counter}{if $even % 2 !=0}class="even"{/if}>
			<td align="right">{$entry.user}</td>
			<td align="center" class="management_links"> 
				<a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}#{$entry.user}">{$widget_lang.permissions}</a> | 
				<a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&password={$entry.user}">{$lang.password}</a> |
				<a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&deluser={$entry.user}" onclick="return confirm('{$widget_lang.confirm_delusr}')">{$lang.delete}</a>
			</td>
		</tr>
		<tr {if $even % 2 !=0}class="even"{/if} style="display:none">
			<td align="center" class="management_del" colspan="2">
			{$widget_lang.db_list}:<ul style="list-style:outside none; text-align:right; margin:0 20%">
			{if $entry.dblist}
            {foreach from=$widgets item=wig}
                {if $widget.name == $wig.name}
                    {assign value=$wig.location var=widgeturl}
                {/if}
            {/foreach}
			{foreach from=$entry.dblist item=dblist} 
                
				<li><span>{$dblist.db}</span> <img width="10" height="10" src="{$widgeturl}{if $dblist.acces == 1}/trash.gif" title="{$lang.remove}" alt="{$lang.remove}"{else}/more_info.gif" title="Grant Acces" alt="Grant Acces"{/if} style="cursor:pointer"></li>
			{/foreach}
			{else}
			{$widget_lang.nodatabase}
			{/if}
			</ul>
		</tr>
		<tr {if $even % 2 !=0}class="even"{/if} style="display:none">
			<td align="center" colspan="2"><input type="hidden" name="passchange[{$index}][user]" value="{$entry.user}">
				<div style="display:table-cell; padding:0 3px">{$lang.password}: <br>
				<input autocomplete="off" type="password" name="passchange[{$index}][passmain]"></div>
				<div style="display:table-cell; padding:0 3px">{$lang.confirmpassword}:<br> <input autocomplete="off" type="password" name="passchange[{$index}][passcheck]">
				</div> 
			</td>
		</tr>
		{/foreach}
		{else}
		<tr {counter}{if $even % 2 !=0}class="even"{/if}>
			<td align="center" colspan="2">{$widget_lang.nousers}</td> 
		</tr>
	{/if}
{elseif $act=='hostmanage'}
	{if $listentrys}
		{foreach from=$listentrys item=entry} 
		<tr {counter}{if $even % 2 !=0}class="even"{/if}>
			<td align="right">{$entry.host}</td>
			<td align="center"><a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&delhost={$entry.host}" onclick="return confirm('{$widget_lang.confirm_delhost}')">{$lang.delete}</a></td>
		</tr>
		{/foreach}
		{else}
		<tr {counter}{if $even % 2 !=0}class="even"{/if}>
			<td align="center" colspan="2">{$widget_lang.nohosts}</td>
		</tr>
	{/if}
{else}	
	{if $listentrys}
		{foreach from=$listentrys item=entry} 
		<tr {counter}{if $even % 2 !=0}class="even"{/if}>
			<td align="right">{$entry.db}</td>
			<td align="center">MySQL</td>
			<td align="center">
				<a href="#" onClick="return dologin()">{$widget_lang.db_admin}</a> | 
				<a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&deldb={$entry.db}" onclick="return confirm('{$widget_lang.confirm_deldb}')">{$lang.delete}</a>
			</td>
		</tr>
		{/foreach}
		{else}
		<tr {counter}{if $even % 2 ==0}class="even"{/if}>
			<td align="center" colspan="4">{$widget_lang.nodatabase}</td>
		</tr>
	{/if}
{/if}