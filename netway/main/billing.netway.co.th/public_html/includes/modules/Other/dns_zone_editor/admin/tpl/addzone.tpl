<form action="" method="post">
    <input id="type" type='hidden' name="type" value="{$params.type}" class="form-control" readonly>
    <input type='hidden' name="priority" value="" class="form-control" readonly>
    <input type='hidden' name="server_id" value="{$params.server_id}" class="form-control" readonly>
    <input type='hidden' name="domain_id" value="{$zone_id}" class="form-control" readonly>

    <div class="form-group">
        <label>{$lang.Domain}:</label>
        <input type="text" name="domain" value="" class="form-control" required>
        <span class="help-block">{$lang.newnamedomain}</span>
    </div>

    {include file="tpl/import_options.tpl"}

    <button type="submit" name="submit" value="true" class="btn btn-success">{$lang.submit}</button>

    <a class="button"
       href="?cmd={$modulename}&action=show&server={$params.server_id}&security_token={$security_token}">Cancel</a>

    {securitytoken}
</form>
