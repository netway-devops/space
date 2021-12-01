<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Show help</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>Welcome to your hardware inventory</h3>
            <span class="fs11">Below you can find list of your inventory items divided into categories. <br/> 
                To get list of items from certain category, expand it using <span class="ui-icon ui-icon-triangle-1-e" style="display:inline-block"></span> <br/>
                Go to <a href="?cmd=inventory_manager&action=settings"><b>settings</b></a>, to install demo data.
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.inventory.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.inventory.nav));
       setjGridHeight();
    });



    </script>{/literal}