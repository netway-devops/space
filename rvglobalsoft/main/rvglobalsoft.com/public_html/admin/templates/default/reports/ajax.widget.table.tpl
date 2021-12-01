{foreach from=$series item=data key=name}
    <table class="table table-striped" id="datatable_{$widget.id|replace:".":""}" >
        <thead>
        <tr>
            {foreach from=$data.columns item=column}
                <th>{$column}</th>
            {/foreach}
        </tr>
        </thead>
        <tbody class="loading">
            <tr>
                <td colspan="{$data.columns|@count}">
                    <div class="text-center" style="line-height: 200px">
                        <img src="templates/default/img/ajax-loading.gif" />
                    </div>
                </td>
            </tr>
        </tbody>
        <tbody class="ready" style="display: none;">
        {foreach from=$data.data item=r}
            <tr>
                {foreach from=$r item=col}
                    <td>{$col}</td>
                {/foreach}
            </tr>
        {/foreach}
        </tbody>
    </table>
{/foreach}

<script>

    var pie_{$widget.id|replace:".":""} = function(){literal} {
        var table = $('#datatable_{/literal}{$widget.id|replace:".":""}{literal}')
        table.find('tbody.loading').remove();
        table.find('tbody.ready').show();
        table.dataTable({
            "order": []
        });

     };
    {/literal}
        {if $ajax}
        pie_{$widget.id|replace:".":""}();
        {else}
        appendLoader('pie_{$widget.id|replace:".":""}');
    {/if}

</script>