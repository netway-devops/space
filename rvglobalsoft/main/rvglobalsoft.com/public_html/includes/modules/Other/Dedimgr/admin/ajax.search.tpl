{if $results}


{if $results.Items}
	<li class="choices-header choices-Items">Rack items</li>
	{foreach from=$results.Items item=r}
		<li class="result"><a href="?cmd=module&module=dedimgr&do=rack&rack_id={$r.rack_id}&expand={$r.id}">{$r.typename} - {$r.label}
                        <span class="second">Colo: {$r.coloname}, floor: {$r.floorname}, rack: {$r.rackname}</span></a>
		</li>
	{/foreach}
{/if}

{if $results.Racks}
<li class="choices-header choices-Box">Racks</li>
	{foreach from=$results.Racks item=r}
		<li class="result"><a href="?cmd=module&module=dedimgr&do=rack&rack_id={$r.id}">{$r.name} ({$r.units})
                        <span class="second">Colo: {$r.coloname}, floor: {$r.floorname}</span></a>
		</li>
	{/foreach}
{/if}

{if $results.Ports}
<li class="choices-header choices-Items">Item Ports</li>
	{foreach from=$results.Ports item=r}
		<li class="result"><a href="?cmd=module&module=dedimgr&do=rack&rack_id={$r.rack_id}&expand={$r.id}">{$r.typename} - {$r.label}, port: {$r.number}
                        <span class="second">Colo: {$r.coloname}, floor: {$r.floorname}, rack: {$r.rackname}</span></a>
		</li>
	{/foreach}
{/if}
{else}

<li class="choices-header choices-List2"><em>Nothing found</em></li>
{/if}