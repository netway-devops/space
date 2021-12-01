<table id="list2"></table>
<div id="pager2"></div>
{literal}
    <script>
        $(document).ready(function() {
            var grid = jQuery("#list2").jqGrid(GridTemplates.fields.grid);
            grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.fields.nav));
            setjGridHeight();
        });
    </script>
{/literal}