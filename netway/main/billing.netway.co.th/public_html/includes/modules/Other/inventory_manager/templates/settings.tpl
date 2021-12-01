<div id="helpcontainer"><a class="menuitm" href="#" onclick="return helptoggle()" ><span >Install Demo Data</span></a>

    <div class="blank_state_smaller blank_forms" style="display:none">
        <div class="blank_info">
            <h3>Install demo data</h3>
            <span >To quickly familiarize yourself with your new Inventory Manager we suggest starting by installing demo data.<br/>
                <strong style="color:red">Warning: Installing demo data will erase all your current inventory manager entries</strong><br/>
                If you wish to continue, please type: <b>"I want to install demo data"</b> in box below, and click "Continue"</span>
            <div class="clear"></div><br/>

            <form action="" method="post" id="demoform">
                <input name="make" value="1" type="hidden"/>
                Confirmation: <input name="confirmation" value="" style="width:300px" />
                <a class="menuitm greenbtn" href="#" onclick="$('#demoform').submit();
        return false;" ><span >Install demo data</span></a>
                <a class="menuitm" href="#" onclick="return helptoggle()" ><span >Hide help</span></a>
                {securitytoken}
            </form>
            <div class="clear"></div>

        </div>
    </div>
</div>

<table id="list2"></table>
<div id="pager2"></div>

<script src="{$moduleliburl}jqgrid/js/grid.inlinedit.js" type="text/javascript"></script>
{literal}
    
    <script>
    $(document).ready(function() {
        var grid = jQuery("#list2").jqGrid(GridTemplates.settings.grid);
        grid.jqGrid.apply(grid, ['navGrid', '#pager2'].concat(GridTemplates.settings.nav));
        setjGridHeight();
    });
    </script>
{/literal}