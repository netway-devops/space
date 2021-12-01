<input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
<input type="hidden" name="id" value="{$item.id}" id="item_id"/>
<input type="hidden" name="id" value="{$item.id}" id="account_id"/>

<div class="row ">
    <div class="col-md-12" >
        <div class="box ">
            <div class="box-header">
                <h3 class="box-title">Control power outlets</h3>
                <div class="box-tools pull-right">
                    <a href="#" class="btn btn-default btn-sm " onclick="return loadPDUMgr()" >Refresh</a>
                </div>
            </div>
            <div class="box-body" id="ipameditor">
                <div class="text-center">Loading PDU module...</div><br>
                <div class="text-center"><img src="ajax-loading.gif"/></div>
            </div>
            <div class="box-footer">
                Use Connections tab to manage IN/OUT sockets attached to this device.
            </div>
        </div>
    </div>
</div>
{literal}
    <script>
        function loadPDUMgr() {
            ajax_update('?cmd=pdu_snmp&action=getAvailablePDUs',{account_id:$('#item_id').val(),type:'rackitem'},'#ipameditor');
            return false;
        }
        $(document).ready(loadPDUMgr);
    </script>
{/literal}