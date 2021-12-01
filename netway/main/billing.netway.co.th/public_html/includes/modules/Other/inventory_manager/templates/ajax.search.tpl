<span class="glyphicon glyphicon-remove-sign" aria-hidden="true" style="float: right; font-size: 25px; padding-right: 10px; cursor: pointer;" onclick="$('.smartres').hide();"></span>
{if $results}
	<li class="choices-header choices-Items">Inventory</li>
	{foreach from=$results item=result}
		<li class="result">
			<a href="#" onclick="showFacebox('?cmd=inventory_manager&action=entity&id={$result.id}')">
				S/N: {$result.sn} - {$result.name} (MAC / ID:{if $result.mac}{$result.mac}{else}none{/if}, Location: {$result.localisation}, Status: {$result.status})
			</a>
		</li>
	{/foreach}
{else}
<li class="choices-header choices-List2"><em>Nothing found</em></li>
{/if}