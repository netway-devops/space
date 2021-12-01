<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Show help</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>Inventory Item Categories and items</h3>
            <span class="fs11">Each item in your inventory needs to be assigned to two groups: <br/>
                - item category - like CPUs, HDDs, Memory Sticks, Blanking Panels etc.<br/>
                - item type - filled under item categories, item types are certain item - like 1GB Ram stick, Intel XEON7 CPU etc.
            </span>
            <div class="clear"></div><br/>

            <a class="menuitm" href="#" onclick="return helptoggle()" ><span >Hide help</span></a>
            <div class="clear"></div>

        </div>
    </div>
</div>

<table id="list2"></table>
<div id="pager2"></div>


{literal}<script>
    $(document).ready(function() {
        var grid = jQuery("#list2").jqGrid(GridTemplates.categories.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.categories.nav));
        setjGridHeight();
    });



    </script>{/literal}