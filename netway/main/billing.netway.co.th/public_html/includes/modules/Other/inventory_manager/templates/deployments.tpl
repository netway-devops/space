<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Show help</span></a> 
    <a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=inventory_manager&action=newproduct')"><span class="addsth">Add New Product</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>Create product offerings</h3>
            <span class="fs11">Compose your product offerings based on your hardware inventory. <br/> Create product, assign hardware item types to it.
                <br/>Once you've defined product you can add it to your Settings->Products & Services by using <b>inventory manager provisioning</b> module - this way it can be automatically provisioned. <br/>
                <br/>
                <h3>How provisioning works</h3>
                Once you've configured your offering here and connected to your HostBill product with provisioning module you're ready for automated provisioning.<br/>
                When your customer purchases related package, and account will be created (automatically after payment or manually, depending on settings), HostBill will reserve free items from your hardware inventory with specification of product defined below.
            </span>
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
        var grid = jQuery("#list2").jqGrid(GridTemplates.deployments.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.deployments.nav));
        setjGridHeight();
    });



    </script>{/literal}