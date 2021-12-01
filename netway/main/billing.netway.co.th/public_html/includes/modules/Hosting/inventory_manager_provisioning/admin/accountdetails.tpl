{if $list}


    <div style="margin:10px 0px;">
        <ul class="accor">
            <li>
                <a>Inventory Manager Builds</a>
                <div class="sor">
                    {foreach from=$list item=items key=type}
                        {if $items.rows}

                            {foreach from=$items.rows item=item}
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><a href="?cmd=inventory_manager&action=builds" target="_blank">Build: #{$item.id} - {$item.product}</a> <label class="label label-{if $type=='pending'}danger{else}success{/if}">{$type|ucfirst}</label></div>
                                            <div class="panel-body">
                                                <table class="table table-striped">
                                                    <tr>
                                                        <th>Id</th>
                                                        <th>S/N</th>
                                                        <th>Category</th>
                                                        <th>Item</th>
                                                    </tr>
                                                    {foreach from=$item.items item=i}
                                                    <tr>
                                                        <td><a href="?cmd=inventory_manager#e{$i.id}" target="_blank">#{$i.id}</a></td>
                                                        <td><a href="?cmd=inventory_manager#e{$i.id}" target="_blank">{$i.sn}</a></td>
                                                        <td>{$i.category}</td>
                                                        <td>{$i.name}</td>
                                                    </tr>
                                                    {/foreach}
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        {/if}
                    {/foreach}
                </div>
            </li>
        </ul>
    </div>

{/if}
