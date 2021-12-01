<div class="box box-primary">
    <div class="box-header">
        <h3 class="box-title">Client Gateways <i class="fa fa-paypal pull-left"></i></h3>
    </div>
    <div class="box-body">
        <div id="customer-gateways">
            <div class="radio">
                <label>
                    <input type="radio" name="selectall" value="1" onclick="$('#gateway-picker').toggle(false);" {if $selectall}checked="checked"{/if}>
                    Customer have access to <strong>all active gateways</strong>
                </label>
            </div>
            <div class="radio">
                <label>
                    <input type="radio" name="selectall" value="0" onclick="$('#gateway-picker').toggle(true);" {if !$selectall}checked="checked"{/if}>
                    Customer have access only to <strong>subset of gateways</strong>
                </label>
            </div>
            <div class="form-group" {if $selectall}style="display: none;" {/if} id="gateway-picker">
                <hr>
                {foreach from=$allgateways item=gtw key=gtwid}
                    <div class="col-md-4">
                        <input type="checkbox" value="{$gtwid}" name="customergateways[{$gtwid}]" {if $selected[$gtwid]}checked="checked"{/if}>
                        {$translated[$gtw]}
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
    {if !$forbidAccess.editClients}
        <div class="box-footer">
            <button class="btn btn-success btn-sm" onclick="return saveGatewayList();">Save gateway settings</button>
        </div>
    {/if}
</div>
{literal}
    <script>
        function saveGatewayList() {
            var gateways = $('#customer-gateways input').serialize();
            ajax_update('?cmd=gatewayperclient&action=update&' + gateways, {client_id: $('#client_id').val()});
            return false;
        }
    </script>
{/literal}