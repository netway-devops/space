{include file="$tplPath/admin/header.tpl"}

<h1>Setting URL</h1>
<form method="POST">

<div class="panel panel-default">
    <div class="panel-body">
        {foreach from=$aWebhooksList item="aValue" key="index"}
        <div class="form-group">
            <label>{$aValue.method} URL to be {$aValue.name}</label>
            <input type="text" name="urlconfigs[{$aValue.id}]" value="{$aValue.url}" class="form-control" placeholder="https://example.com">
        </div>
        {/foreach}

    </div>
    <div class="panel-footer">
        <button class="btn btn-primary" type="submit" name="save" value="1">Save</button>
        or
        <a href="?cmd=module&module={$moduleid}">Cancel</a>
</div>
</div>

</form>

{include file="$tplPath/admin/footer.tpl"}