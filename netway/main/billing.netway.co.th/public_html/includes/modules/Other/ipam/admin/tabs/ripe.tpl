<!-- RIPE -->
<div style="margin: 10px 0">
    <div class="container-fluid clear">
        <div class="row">
            <div class="col-md-5">
                <form action="?cmd=module&module={$moduleid}&action=save_ripe" method="post" id="ripe-form">
                    <div class="form-group">
                        <label for="ripe[maintainer]">Maintainer</label>
                        <input type="text" class="form-control" name="ripe[maintainer]" value="{$ripe.maintainer}">
                        <p class="help-block"></p>
                    </div>
                    <div class="form-group">
                        <label for="ripe[maintainerpass]">Maintainer Password</label>
                        <input type="password" class="form-control" name="ripe[maintainerpass]" value="{$ripe.maintainerpass}">
                    </div>
                    <div class="form-group">
                        <label for="ripe[inetnum_prefix]">Inetnum Prefix</label>
                        <input type="text" class="form-control" name="ripe[inetnum_prefix]" value="{$ripe.inetnum_prefix}">
                    </div>
                    <div class="checkbox">
                        <label><input type="checkbox" value="1" name="ripe[test]" {if $ripe.test}checked{/if}> <b>Test mode</b></label>
                    </div>
                    <div class="checkbox">
                        <label><input type="checkbox" value="1" name="ripe[update_inetnum]" {if $ripe.update_inetnum}checked{/if}> <b>Auto-update inetnum on assignment </b></label>
                    </div>
                    <div class="checkbox">
                        <label><input type="checkbox" value="1" name="ripe[update_role]" {if $ripe.update_role}checked{/if}> <b>Auto-update role/person on client/contact edit</b></label>
                    </div>
                    <div class="checkbox">
                        <label><input type="checkbox" value="1" name="ripe[delete_inetnum]" {if $ripe.delete_inetnum}checked{/if}> <b>Auto-delete inetnum on unassignment</b></label>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary" onclick="$('#ripe-form').submit(); return false;">Save Changes</button>
                        <button type="button" class="btn btn-default" onclick="testRIPE(); return false;"><span class="wizard">Test connection</span></button>
                    </div>
                    {securitytoken}
                </form>
            </div>
            <div class="col-md-7">
                <div class="blank_state_smaller blank_forms" id="blank_pdu">
                    <div class="blank_info">
                        <h1>Adding the necessary registration fields</h1>
                        For RIPE to work properly in IPAM, it is necessary to add registration fields with the variable names:
                        <ul>
                            <li><b>{$ripe_variables.ripetech}</b></li>
                            <li><b>{$ripe_variables.ripeadmin}</b></li>
                            <li><b>{$ripe_variables.ripeperson}</b></li>
                            <li><b>{$ripe_variables.riperole}</b></li>
                        </ul>
                        <br/>
                        <b>To add the mentioned registration fields, follow these steps:</b>
                        <ol>
                            <li>Go to <b>Clients → Registration fields</b> in your HostBill</li>
                            <li>Click <b>Add new field</b></li>
                            <li>Enter <b>Field Name</b></li>
                            <li>Set type to checkbox for <b>{$ripe_variables.ripetech}</b>, <b>{$ripe_variables.ripeadmin}</b> and input for <b>{$ripe_variables.ripeperson}</b>, <b>{$ripe_variables.riperole}</b></li>
                            <li>Under <b>Advanced</b> tab, set field <b>Variable name</b> ({$ripe_variables.ripetech}, {$ripe_variables.ripeadmin}, {$ripe_variables.ripeperson} or {$ripe_variables.riperole})</li>
                            <li>The action should be repeated for each required variable</li>
                        </ol>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{literal}
<script>
    function testRIPE() {
        var dialog = bootbox.dialog({
            message: '<span class="text-center"><i class="fa fa-spin fa-spinner"></i> Loading...</span>',
            backdrop: true,
            onEscape: true
        });
        dialog.init();
        $.post('?cmd=module&module={/literal}{$moduleid}{literal}&action=test_ripe' ,$('#ripe-form').serialize(), function (result) {
            dialog.find('.bootbox-body').html(result);
        });
    }
</script>
{/literal}