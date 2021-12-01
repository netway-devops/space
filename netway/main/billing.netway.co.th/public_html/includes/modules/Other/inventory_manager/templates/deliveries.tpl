<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Show help</span></a>
    <a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=inventory_manager&action=newdelivery')"><span class="addsth">Add New Delivery</span></a>
    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>Want to put new item on stock? Use delivery</h3>
            <span class="fs11">Below you can find list of deliveries of your hardware / software. Add new delivery to add new items on stock. <br/> 
                To get list of items from given delivert use <span class="ui-icon ui-icon-triangle-1-e" style="display:inline-block"></span>
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.deliveries.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.deliveries.nav));
        setjGridHeight();
    });



    </script>{/literal}