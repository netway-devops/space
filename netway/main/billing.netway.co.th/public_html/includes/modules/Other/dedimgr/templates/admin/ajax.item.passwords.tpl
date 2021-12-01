
<input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
<input type="hidden" name="id" value="{$item.id}" id="item_id"/>
<input type="hidden" name="id" value="{$item.id}" id="account_id"/>
<div class="row ">
    <div class="col-md-12" >
        <div class="box pmBox">
            <div class="box-header">
                <h3 class="box-title">Passwords</h3>
                <div class="box-tools pull-right">
                    <button class="btn btn-sm btn-default box-widget-autorefresh" onclick="return loadPassMGR()" >Refresh</button>
                </div>
            </div>
            <div class="box-body" id="passeditor">
                <div class="text-center">Loading Password Manager module...</div><br>
                <div class="text-center"><img src="ajax-loading.gif"/></div>
            </div>
        </div>
    </div>
</div>

{literal}
    <script>
        function loadPassMGR() {
            ajax_update('?cmd=module&module=password_manager&action=accountseditor',{account_id:$('#item_id').val(),type:'rackitem'},'#passeditor');
            return false;
        }
        $(document).ready(loadPassMGR);
    </script>
{/literal}