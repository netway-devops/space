<h3 class="left">Items in this delivery</h3>
<a style="margin-bottom: 10px;" onclick="$('#porteditor').show();
        return false;" class=" menuitm right greenbtn" href="#"><span><b>Add item(s)</b></span></a>
<div class="clear"></div>
<div style="min-height:400px">

    <table id="list4"></table>

</div>
<div id="porteditor">
    <h3 style="margin-bottom:10px;" class="left">
        Add multiple items at once:
    </h3>
    <a onclick="$('#porteditor').hide();
            return false;" class=" menuitm right" href="#"><span><b>Close</b></span></a>
    <div class="clear"></div>

    <label >Count <small>items QTY with specifications below in delivery</small></label>
    <input type="text" size="3" class="w250" name="p_count" value="1" id="p_count">
    <div class="clear"></div>

    <label class="nodescr">Item Price</label>
    <input type="text" size="3" class="w250" name="p_price" value="0.00" id="p_price">
    <div class="clear"></div>

    <label class="nodescr">Item Status</label>
    <select name="p_status" class="w250" id="p_status"><option value="In Stock" selected="selected">In Stock (Item can be used)</option><option value="Reserved">Reserved (Item is reserved for deployment)</option><option value="In Use">In Use (Item is in use/deployed)</option><option value="Expired">Expired (Item passed support date)</option><option value="Not Usable">Not Usable (Item not usable)</option><option value="In Order">In Order by the vendor</option></select>
    <div class="clear"></div>

    <label class="nodescr">Guarantee ends on</label>
    <input type="text" style="width:100px" class="w250 haspicker" name="p_guarantee" value="" id="p_guarantee">
    <div class="clear"></div>
    <label class="nodescr">Support ends on</label>
    <input type="text" style="width:100px" class="w250 haspicker" name="p_support" value="" id="p_support">
    <div class="clear"></div>

    <label class="nodescr">Manufacturer</label>
    <select class="w250" name="p_manufacturer"  id="p_manufacturer" >
        {foreach from=$manufacturers item=m key=l}
            <option value="{$l}">{$m}</option>
        {/foreach}
    </select>
    <div class="clear"></div>


    <label class="nodescr">Item Category</label>
    <select class="w250" name="p_ictype" id="p_ictype" onchange="loadIhtypes($(this).val());">
        <option value="0">---Select category---</option>
        {foreach from=$categories item=m key=l}
            <option value="{$l}">{$m}</option>
        {/foreach}
    </select>
    <div class="clear"></div>

    <div id="ihtype_container" style="display:none">
    </div>

    <a onclick="addItem();
            return false;" class=" menuitm right greenbtn" href="#"><span><b>Add item(s)</b></span></a>
    <div class="clear"></div>
</div>
<input type="hidden" name="tabledata" value="" id="tabledata" />
{literal}
    <script>
        $('#porteditor').insertAfter($('.tabb:last'));
        function loadIhtypes(id) {
            if (id == "0") {
                $('#ihtype_container').hide().html('');
            } else {
                $('#ihtype_container').html('').show();
                ajax_update('?cmd=inventory_manager&action=loadihtypes&ictype_id=' + id, {}, '#ihtype_container');
            }
        }

        $(document).on('before.ivtmn.submit', function () {
            var data = JSON.stringify(jQuery("#list4").jqGrid('getGridParam', 'data'));
            $('#tabledata').val(data);
        });

        function addItem() {
            if (!$('#p_ihtype').val()) {
                return false;
            }
            var struct = {
                id: 'new',
                iproducer_id: $('#p_manufacturer').val(),
                ihtype_id: $('#p_ihtype').val(),
                localisation: 'Stock',
                price: $('#p_price').val(),
                sn: '',
                name: $('#p_ihtype option').eq($('#p_ihtype')[0].selectedIndex).text(),
                status: $('#p_status').val() ? $('#p_status').val() : 'In Stock',
                guarantee: $('#p_guarantee').val(),
                support: $('#p_support').val(),
                manufacturer: $('#p_manufacturer option').eq($('#p_manufacturer')[0].selectedIndex).text()
            };
            $('#porteditor').hide();
            var j = jQuery("#list4").jqGrid('getGridParam', 'data').length;
            var z = parseInt($('#p_count').val());
            for (var i = 0; i < z; i++) {
                j++;
                jQuery("#list4").jqGrid('addRowData', 'new' + j, struct);
            }
            $('#porteditor').hide();
        }


        var grid = jQuery("#list4");

        myDelOptions = {
            onclickSubmit: function (rp_ge, rowid) {
                grid.delRowData(rowid);
                var grid_id = grid[0].id;
                $.jgrid.hideModal("#delmod" + grid_id, {gb: "#gbox_" + grid_id});

                return true;
            },
            processing: true
        };



        jQuery("#list4").jqGrid({
            datatype: "local",
            height: 350,
            editurl: 'clientArray',
            cellEdit: true,
            cellsubmit: 'clientArray',
            autowidth: true,
            colNames: ['', '', '', '', 'Item Location', 'Name', 'Price', 'SN', 'Status', 'Guarantee', 'Support', 'Manufacturer'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions',
                    formatoptions: {keys: false, delOptions: myDelOptions
                    }},
                {name: 'row_id', index: 'row_id', hidden: true, editable: false},
                {name: 'iproducer_id', index: 'iproducer_id', hidden: true, editable: false},
                {name: 'ihtype_id', index: 'ihtype_id', hidden: true, editable: false},
                {name: 'localisation', index: 'localisation', hidden: true, editable: false},
                {name: 'name', index: 'name', width: 100, editable: false},
                {name: 'price', index: 'price', width: 90, formatter: 'currency', formatoptions: currencySettings, editable: true},
                {name: 'sn', index: 'sn', width: 100, editable: true},
                {name: 'status', index: 'status', width: 100},
                {name: 'guarantee', index: 'guarantee', width: 100, editable: true},
                {name: 'support', index: 'support', width: 100, editable: true},
                {name: 'manufacturer', index: 'manufacturer', width: 150, editable: false}
            ]
        });
        var mydata = {/literal}{$delivery.items}{literal};
        for (var i = 0; i <= mydata.length; i++)
            jQuery("#list4").jqGrid('addRowData', i + 1, mydata[i]);

    </script>
{/literal}

