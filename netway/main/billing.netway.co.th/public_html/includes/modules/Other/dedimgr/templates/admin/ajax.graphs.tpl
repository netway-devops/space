<div class="graph-item-list">
    {foreach from=$graphs item=graph}
        <div class="graph-item">
            <div class="checkbox">
                <label>
                    {if $graph.rel_type == 'RackItem'}
                        <input type="checkbox" value="{$graph.id}" name="graph_ids[]">
                    {else}
                        <input type="checkbox" disabled title="Assigned trough hosting account" />
                    {/if}
                    {$graph.name}
                </label>
                <div class="pull-right">
                    <a href="#Daily" data-src="?cmd=dedimgr&do=graphsimg&id={$graph.id}&type=daily"
                       class="btn btn-xs btn-primary">Daily</a>
                    <a href="#Weekly" data-src="?cmd=dedimgr&do=graphsimg&id={$graph.id}&type=weekly"
                       class="btn btn-xs btn-primary">Weekly</a>
                    <a href="#Monthly" data-src="?cmd=dedimgr&do=graphsimg&id={$graph.id}&type=monthly"
                       class="btn btn-xs btn-primary">Monthly</a>
                </div>
            </div>
        </div>
    {foreachelse}
        <div class="graph-item">
            No graphs assigned yet
        </div>
    {/foreach}
</div>
{if $graphs}
    <p>
        <a href="#unasign" class="btn btn-danger btn-sm btn-unassign">Unasign Selected</a>
    </p>
{/if}