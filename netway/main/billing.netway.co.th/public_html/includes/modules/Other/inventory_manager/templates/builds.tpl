{if $finished}
    <div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Show help</span></a> 

        <div class="blank_state_smaller blank_forms" style="display:none">
            <div class="blank_info">
                <h3>Finished Server builds</h3>
                <span class="fs11">Once server is marked as delivered in <b>Pending Builds</b> section it will appear here. 
                    You can remove build (this will mark all its items as "In stock" again), or remove certain items from particular build<br/><br/>

                </span>
                </span>
                <div class="clear"></div><br/>

                <a class="menuitm" href="#" onclick="return helptoggle()" ><span >Hide help</span></a>
                <div class="clear"></div>

            </div>
        </div>
    </div>

{else}
    <div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Show help</span></a> 
        <a class="menuitm" href="#" style="margin-left: 30px;font-weight:bold;" onclick="return showFacebox('?cmd=inventory_manager&action=newbuild')"><span class="addsth">Create new server</span></a>

        <div class="blank_state_smaller blank_forms" style="display:none">
            <div class="blank_info">
                <h3>Pending Server builds</h3>
                <span class="fs11">After customer purchased server and <b>Inventory manager Provisioning</b> invokes account create 
                    (manually in account details section or automatically after payment, depending on product config), inventory manager will prepare server build:<br/>
                    - it will reserve all required components for build, and list them here<br/><br/>
                    Click on Tick icon to edit/approve server built & manage its items. You can also view items required for built by expanding build row
                </span>
                </span>
                <div class="clear"></div><br/>

                <a class="menuitm" href="#" onclick="return helptoggle()" ><span >Hide help</span></a>
                <div class="clear"></div>

            </div>
        </div>
    </div>


{/if}


<table id="list2"></table>
<div id="pager2"></div>




{literal}
    <script>
        {/literal}
        {if $finished}
//            GridTemplates.builds.grid.colModel.splice(0, 1);
//            GridTemplates.builds.grid.colNames.splice(0, 1);
            GridTemplates.builds.grid.colModel.push({literal}{name:'buildby', index:'buildby', width:120}{/literal});
            GridTemplates.builds.grid.colNames.push('Built by')
            GridTemplates.builds.grid.url = "index.php?cmd=inventory_manager&action=builds&finished=true";
            GridTemplates.builds.grid.editurl = "index.php?cmd=inventory_manager&action=builds&finished=true";
        {/if}
        {literal}
        $(document).ready(function() {
            var grid = jQuery("#list2").jqGrid(GridTemplates.builds.grid);
            grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.builds.nav));
            setjGridHeight();
        });
    </script>
{/literal}


