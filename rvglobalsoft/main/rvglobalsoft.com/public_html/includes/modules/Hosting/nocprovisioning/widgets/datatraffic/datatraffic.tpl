<h1>Data traffic Graphs</h1> 

{if $ports == 0}
No data traffic information available for this server.
{else}

<h2>Current month</h2>

{foreach from=$currentGraphs item=graph}
<p>
<img width="497" height="249" alt="Current month" src="{$graph}" />
</p>
{/foreach}

{if $lastMonthGraphs|@count}
<h2>Previous month</h2>

{foreach from=$lastMonthGraphs item=graph}
<p>
<img width="497" height="249" alt="Previous month" src="{$graph}" />
</p>
{/foreach}
{/if}

{/if}