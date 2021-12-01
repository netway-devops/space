{include file='dedicated/cart_header.tpl'}


<div id="tableH">
	<span class="l"></span>
	<ul id="menuT">
		<li class="i1">{$lang.server}</li>
		{if $opconfig.header1}<li class="i2">{$opconfig.header1}</li>{/if}
		{if $opconfig.header2}<li class="i3">{$opconfig.header2}</li>{/if}
		{if $opconfig.header3}<li class="i4">{$opconfig.header3}</li>{/if}
		<li class="i5">{$lang.startingat}</li>
	</ul>
	<span class="r"></span>
</div>
<div id="tables">
	<table>
		<thead>
			<tr>
				<td colspan="6">{foreach from=$categories item=i name=categories name=cats}{if $i.id == $current_cat}{$i.name}{/if}{/foreach}</td>
			</tr>
		</thead>
		<tbody>
			{foreach from=$products item=i name=ploop key=k}
				<tr {if $smarty.foreach.ploop.iteration%2==0}class="odd"{/if}>
					<td class="d1">
						<span class="s1"></span>
						<span class="s2"><a href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}">{$i.name}</a></span>
					</td>
					{specs var="awords" string=$i.description}
					{if count($awords[$k].specs)==3}
						<td class="d2">{$awords[$k].specs[0][1]}</td>
						<td class="d3">{$awords[$k].specs[1][1]}</td>
						<td class="d4">{$awords[$k].specs[2][1]}</td>
					{else}
						<td class="d2"> </td>
						<td class="d3"> </td>
						<td class="d4"> </td>
					{/if}
					<td class="d5"><a href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}">
							{if $i.paytype=='Free'}{$lang.Free}
							{elseif $i.paytype=='Once'}{$i.m|price:$currency}
							{else}<!--
								{if $i.d!=0}
									-->{$i.d|price:$currency}<!--
								{elseif $i.w!=0}
									-->{$i.w|price:$currency}<!--
								{elseif $i.m!=0}
									-->{$i.m|price:$currency}<!--
								{elseif $i.q!=0}
									-->{$i.q|price:$currency}<!--
								{elseif $i.s!=0}
									-->{$i.s|price:$currency}<!--
								{elseif $i.a!=0}
									-->{$i.a|price:$currency}<!--
								{elseif $i.b!=0}
									-->{$i.b|price:$currency}<!--
								{elseif $i.t!=0}
									-->{$i.t|price:$currency}<!--
								{elseif $i.p4!=0}
									-->{$i.p4|price:$currency:false}<!--
								{elseif $i.p5!=0}
									-->{$i.p5|price:$currency:false}<!--
								{/if}
								-->
					{/if}{if $i.paytype=='Free'}{elseif $i.paytype=='Once'}/{$lang.once}{else}/
						{if $i.d!=0}{$lang.d} 
						{elseif $i.w!=0}{$lang.w} 
						{elseif $i.m!=0}{$lang.m}
						{elseif $i.q!=0}{$lang.q}
						{elseif $i.s!=0}{$lang.s}
						{elseif $i.a!=0}{$lang.a}
						{elseif $i.b!=0}{$lang.b}
						{elseif $i.t!=0}{$lang.t}
						{elseif $i.p4!=0}{$lang.p4}
						{elseif $i.p5!=0}{$lang.p5}
						{/if}
					{/if}</a></td>
			<td class="d6"><a href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}">{$lang.order}</a></td>
		</tr>
	{/foreach}

</tbody>
</table>

</div>
{include file='dedicated/cart_footer.tpl'}