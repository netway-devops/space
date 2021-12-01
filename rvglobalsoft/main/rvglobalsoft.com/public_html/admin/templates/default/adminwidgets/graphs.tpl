{foreach from=$graphs item=graph}
    <h4><a href="?cmd=accounts&action=edit&id={$graph.rel_id}" target="_blank">{$graph.name}</a></h4>
    <img src="?cmd=graphs&action=show&graph_id={$graph.id}{if $refresh}&refresh=true{/if}" alt="{$graph.name}" class="img-responsive center-block"/>
    {foreachelse}
    No featured graphs assigned to account found
{/foreach}
