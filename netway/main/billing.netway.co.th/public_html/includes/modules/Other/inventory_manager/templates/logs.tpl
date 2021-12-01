<div class="row logs">
    {if $logs}
    <table class="table table-striped">
        <thead>
            <tr>
                <th class="col-sm-1 text-center">#</th>
                <th class="col-sm-1 text-center">Admin Id</th>
                <th class="col-sm-1 text-center">Admin Name</th>
                <th class="col-sm-1 text-center">Admin Email</th>
                <th class="col-sm-1 text-center">Entity Id</th>
                <th class="col-sm-1 text-center">Entity Name</th>
                <th class="col-sm-1 text-center">Entity Type</th>
                <th class="col-sm-3 text-center">Action</th>
                <th class="col-sm-2 text-center">Date</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$logs item=log}
            <tr>
                <td class="text-center">{$log.id}</td>
                <td class="text-center">{$log.admin_id}</td>
                <td class="text-center">{$log.admin_name}</td>
                <td class="text-center">{$log.admin_email}</td>
                <td class="text-center">{$log.entity_id}</td>
                <td class="text-center">{$log.entity_name}</td>
                <td class="text-center">{$log.entity_type}</td>
                <td class="text-center">
                    <strong>{$log.action}</strong>
                    {foreach from=$log.change item=value key=key}
                        {if $value|is_array}
                            <br>{$key}:(
                            {foreach from=$value item=item key=key2}
                                <br>{$key2}:(
                                    {foreach from=$item item=i key=k}
                                        <br><span style="padding-left: 5em">{$k} ({$i}),</span>
                                    {/foreach})
                            {/foreach})
                        {else}
                            {if $key == '0'}
                                <br>{$value}
                            {else}
                                <br>{$key} ({$value}),
                            {/if}

                        {/if}
                    {/foreach}
                </td>
                <td class="text-center">{$log.date}</td>
            </tr>
            {/foreach}
        </tbody>
    </table>
    {else}
        <h2 class="text-center">No logs to display</h2>
    {/if}


</div>
{literal}
<style>
    .logs{
        padding: 15px;
    }
    .logs table tbody td{
        font-size: 12px;
    }
</style>
{/literal}
{include file='ajax.logs.tpl'}