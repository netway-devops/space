<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes"/>
    <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
    <link href="{$template_dir}dist/stylesheets/application.css?v={$hb_version}" rel="stylesheet" media="all"/>
    <link href="{$template_dir}dist/stylesheets/font-awesome.min.css?v={$hb_version}" rel="stylesheet" media="all"/>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1>QuickBooks Payments</h1>
    </div>
    {if $success}
        <p class="lead">Connected successfully.</p>
    {else}
        <p class="lead">Connection failed.</p>
        <p><b>Error: </b> {$error}</p>
        <p>We could not get access token for your company, please try again and make sure to grant access
            to this app when prompted by quickbooks
        </p>
    {/if}
    <p>
        <a href="?cmd=managemodules&action=payment&expand=true&id={$moduleid}">Click here</a>
        if you are not automatically redirected to module configuration
    </p>
</div>
{literal}
<script type="text/javascript">
    if (window.opener) {
        window.opener.location.reload(false);

    } else {
        setTimeout(function () {
            window.close()
            {/literal}
            window.location = '?cmd=managemodules&action=payment&expand=true&id={$moduleid}'
            {literal}
        }, 10000);
    }
</script>
{/literal}
</body>
</html>
