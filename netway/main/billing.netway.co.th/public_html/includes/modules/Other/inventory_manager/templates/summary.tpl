<a class="btn btn-sm btn-success" style="margin-bottom: 10px;" href="?cmd=inventory_manager&action=summary&make=export">Export</a>
<table id="list2"></table>
<div id="pager2"></div>
{literal}
    <script>
        $(document).ready(function() {
            var gridjs = $.extend({}, DefaultGRID, {
                url: 'index.php?cmd=inventory_manager&action=summary',
                editurl: 'index.php?cmd=inventory_manager&action=summary',
                colNames: [' ', 'ID'],
                colModel: [
                    {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                    {name: 'id', index: 'id', hidden: true, search: false}
                ],
                sortorder: "asc",
                gridComplete: function () {
                    var ids = $(this).jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var cl = ids[i];
                        be = "<div title='Edit selected row' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                        $(this).jqGrid('setRowData', ids[i], {myac: be});
                    }
                }
            });
            {/literal}
            {foreach from=$columns item=column key=id}
                {if in_array($id, $used_columns)}
                    {if $id == 'tested'}
                        gridjs.colModel.push({ldelim}name: 'tested', index: 'tested', align: 'center',
                            width: 40, formatter: function (cellvalue, options, rowObject) {ldelim}
                            return '<span ' + (cellvalue == 1 ? 'class="fa fa-lg fa-check-circle" title="Tested / Wroking"' : 'class="fa fa-lg fa-exclamation-circle" title="Not Tested / Broken"') + '></span>'
                        {rdelim}{rdelim});
                    {elseif $id == 'price' || $id == 'retail_price'}
                        gridjs.colModel.push({ldelim}name: '{$id}', index: '{$id}', width: 80, formatter: 'currency', formatoptions: currencySettings{rdelim});
                    {else}
                         gridjs.colModel.push({ldelim}name: '{$id}', index: '{$id}', width: 80{rdelim});
                    {/if}
                    gridjs.colNames.push('{$column}');
                {/if}
            {/foreach}
            {literal}

            var nav = [
                {edit: false, del: false, search: false, add: false}, //options
                {}, // edit options
                {}, // add options
                {reloadAfterSubmit: true}, // del options
                {} // search options
            ];
//            console.log(gridjs.colModel);
            var grid = jQuery("#list2").jqGrid(gridjs);
            grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(nav));
            setjGridHeight();
        });
    </script>
{/literal}