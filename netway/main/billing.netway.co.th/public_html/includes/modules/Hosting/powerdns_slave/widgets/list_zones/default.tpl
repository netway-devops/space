
<div class="wbox">
    <div class="wbox_header">
        List of zones
    </div>
    <div class="wbox_content">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Zone</th>
                <th>Master IP</th>
                <th>Created at</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$zones item=zone}
                <tr>
                    <td>{$zone.domain}</td>
                    <td>{$zone.ip}</td>
                    <td>{$zone.created}</td>
                    <td>{if $allowremoval}
                        <form action="" method="POST">
                            <input type="hidden" name="zone" value="{$zone.domain}">
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure?');"><i class="icon icon-ban-circle"></i></button>
                            {securitytoken}
                        </form>{/if}
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
