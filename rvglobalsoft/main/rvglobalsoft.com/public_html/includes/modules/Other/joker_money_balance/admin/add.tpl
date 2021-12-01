{include file="menu.tpl"}

<form id="connection_form" action="" method="post" >
    <div class="container-fluid" style="padding-top:14px;padding-bottom:14px;">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" value="{$connect.name}" name="connect[name]" class="form-control" required>
                </div>
            </div>
            <div class="col-md-6">
                <div id="testing_result">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>API Key</label>
                    <input type="text" value="{$connect.api_key}" name="connect[api_key]" class="form-control" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>OTE Environment</label>
                    <input type="checkbox" style="margin: 0 5px;" name="connect[ote]" {if $connect.ote}checked{/if}>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>Status</label>
                    <span id="status_enable" class="label label-success" style="cursor: pointer" onclick="changeStatus(0);">Enabled</span>
                    <span id="status_disable" class="label label-danger" style="cursor: pointer" onclick="changeStatus(1);">Disabled</span>
                    <input id="status" type="hidden" style="margin: 0 5px;" name="connect[display]" value="{if !$connect.id}1{else}{$connect.display}{/if}">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <button type="submit" class="btn btn-success btn-sm">Submit</button>
                    <a class="new_control" href="#" id="testing_button" onclick="testConfiguration(this);
                return false;"><span class="wizard">Test Configuration</span></a>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" name="connect[id]" value="{$connect.id}">
    {securitytoken}
</form>
{literal}
<script>
    var enable = $('#status_enable'),
        disable = $('#status_disable');

    $(function () {
        if ($('#status').val() == 1) {
            disable.hide();
        } else {
            enable.hide();
        }
    });

    function changeStatus(val) {
        $('#status').val(val);
        enable.toggle();
        disable.toggle();
    }
</script>
{/literal}