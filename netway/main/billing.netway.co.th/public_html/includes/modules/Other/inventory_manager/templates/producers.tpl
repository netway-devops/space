<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Show help</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>Manufacturers</h3>
            <span class="fs11">Manufacturers categorisation helps in keeping your hardware in order by their producer/manufacturer. Enter most common manufacturers below.<br/>
                - you will be asked to select manufacturer when adding particular delivery item to your inventory
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.producers.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.producers.nav));
        setjGridHeight();
    });



    </script>
{/literal}