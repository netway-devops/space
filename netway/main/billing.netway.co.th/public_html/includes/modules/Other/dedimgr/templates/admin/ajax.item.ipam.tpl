<input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
<input type="hidden" name="id" value="{$item.id}" id="item_id"/>
<input type="hidden" name="id" value="{$item.id}" id="account_id"/>

<div class="row ">
    <div class="col-md-12" >
        <div class="box ">
            <div class="box-header">
                <h3 class="box-title">IPAM</h3>
                <div class="box-tools pull-right">
                    <button class="btn btn-sm btn-default box-widget-autorefresh" onclick="return loadIpamMGR()" >Refresh</button>
                </div>
            </div>
            <div class="box-body" id="ipameditor">
                <center>Loading IPAM module...</center><br>
                <center><img src="ajax-loading.gif"/></center>
            </div>
        </div>
    </div>
</div>
{literal}
    <script>
        function loadIpamMGR() {
            ajax_update('?cmd=module&module=ipam&action=accountseditor',{account_id:$('#item_id').val(),type:'rackitem'},'#ipameditor');
            return false;
        }
        $(document).ready(loadIpamMGR);
    </script>
{/literal}