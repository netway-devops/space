{if $metered}
<tr>
			<td align="right" class="title">Statistics since:</td>
                        <td colspan="3">{$service.previous_invoice|dateformat:$date_format}</td>
</tr>
{foreach from=$metered item=m}{if $m.charge>0}
        <tr>
			<td align="right" class="title">{$m.name}</td>
			<td colspan="3">{$m.usage} {$m.unit_name}: {$m.charge|price:$currency} <span class="fs11">updated hourly</span></td>
		</tr>{/if}{/foreach}

{/if}