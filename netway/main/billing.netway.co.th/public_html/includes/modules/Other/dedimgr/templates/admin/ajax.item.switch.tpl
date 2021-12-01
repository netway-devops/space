<input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
<input type="hidden" name="id" value="{$item.id}" id="item_id"/>
<input type="hidden" name="id" value="{$item.id}" id="account_id"/>

<div class="row ">
    <div class="col-md-12" >
        <div class="box ">
            <div class="box-header">
                <h3 class="box-title">Control switch outlets</h3>
                <div class="box-tools pull-right">
                    <a href="#" class="btn btn-default btn-sm " onclick="return loadSwitchMgr()" >Refresh</a>
                </div>
            </div>
            <div class="box-body" id="ipameditor">
                <div class="text-center">Loading Switch module...</div><br>
                <div class="text-center"><img src="ajax-loading.gif"/></div>
            </div>
            <div class="box-footer">
                Use Connections tab to manage IN/OUT ports attached to this device.
            </div>
        </div>
    </div>
</div>
{literal}
    <script type="text/javascript">
        function loadSwitchMgr() {
            ajax_update('?cmd=switch_control&action=getAvailableSwitches',{account_id:$('#account_id').val(),type:'rackitem'},'#ipameditor');
        }
        $(document).ready(loadSwitchMgr);
    </script>
{/literal}
