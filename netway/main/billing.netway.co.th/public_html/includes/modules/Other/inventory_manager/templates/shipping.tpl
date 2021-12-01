<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Show help</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>Shipping</h3>
            <span class="fs11">
                Define a list of shipping companies that you use for your deliveries.
                <br /> 
                <strong>Tracking URL</strong> - This url will be used in delivery 
                listing to create a link to quickly check shipping status, 
                tracking number is appended at the end of the link.
                <br /> You can also use <code>%number%</code> variable that will be replaced with tracking number if your url requires it.
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.shipping.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.shipping.nav));
        setjGridHeight();
    });
    </script>
{/literal}