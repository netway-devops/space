<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.logs}</h3>

    <div class="clear"></div>
</div>
<div class="content-bar" >
    <table width="100%" cellspacing="0" class="data-table backups-list">
        <thead>
            <tr>
                <td>Ref</td>
                <td>{$lang.date}</td>
                <td>Action</td>
                <td width="120">{$lang.status}</td>
            </tr>
        </thead>
        <tbody>
            {foreach from=$logs item=log}
            <tr>
                <td>{$log.id}</td>
                <td>{$log.created_at|dateformat:$date_format}</td>
                <td>{$log.action}</td>
                <td>{$log.status}</td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="4">{$lang.nothing}</td>
            </tr>
            {/foreach}
        </tbody></table>
</div>