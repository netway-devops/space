{if $action == 'getstatus'}
    {if $status}
        <td data-label="Server name">
            <strong>
                {$status.name}
            </strong>
        </td>
        {if $fields.FTP}
            <td data-label="{$lang.FTP}">
                {if $status.status.FTP=='1'}
                    <i class="material-icons text-success">done</i>
                {else}
                    <i class="material-icons text-danger">report</i>
                {/if}
            </td>
        {/if}
        {if $fields.SSH}
            <td data-label="{$lang.SSH}">
                {if $status.status.SSH=='1'}
                    <i class="material-icons text-success">done</i>
                {else}
                    <i class="material-icons text-danger">report</i>
                {/if}
            </td>
        {/if}
        {if $fields.HTTP}
            <td data-label="{$lang.HTTP}">
                {if $status.status.HTTP=='1'}
                    <i class="material-icons text-success">done</i>
                {else}
                    <i class="material-icons text-danger">report</i>
                {/if}
            </td>
        {/if}
        {if $fields.POP3}
            <td data-label="{$lang.POP3}">
                {if $status.status.POP3=='1'}
                    <i class="material-icons text-success">done</i>
                {else}
                    <i class="material-icons text-danger">report</i>
                {/if}
            </td>
        {/if}
        {if $fields.IMAP}
            <td data-label="{$lang.IMAP}">
                {if $status.status.IMAP=='1'}
                    <i class="material-icons text-success">done</i>
                {else}
                    <i class="material-icons text-danger">report</i>
                {/if}
            </td>
        {/if}
        {if $fields.MYSQL}
            <td data-label="{$lang.MYSQL}">
                {if $status.status.MYSQL=='1'}
                    <i class="material-icons text-success">done</i>
                {else}
                    <i class="material-icons text-danger">report</i>
                {/if}
            </td>
        {/if}
        {if $fields.LOAD}
            <td data-label="{$lang.LOAD}">
                {if $status.status.LOAD}
                    {$status.status.LOAD}
                {else}
                    {$lang.Unavailable}
                {/if}
            </td>
        {/if}
        {if $fields.UPTIME}
            <td data-label="{$lang.UPTIME}">
                {if $status.status.UPTIME}
                    {$status.status.UPTIME}
                {else}
                    {$lang.Unavailable}
                {/if}
            </td>
        {/if}
    {/if}
{else}
    {if $servers}
        <div class="table-responsive table-borders table-radius">
            <table class="table stackable">
                <thead>
                    <tr>
                        <th>{$lang.servers}</th>
                        {if $fields.FTP}
                            <th>
                                <span class="text-to-icon">
                                    <i class="material-icons" title="{$lang.FTP}">cloud</i>
                                    <span>{$lang.FTP}</span>
                                </span>
                            </th>
                        {/if}
                        {if $fields.SSH}
                            <th>
                                <span class="text-to-icon">
                                    <i class="material-icons" title="{$lang.SSH}">cast_connected</i>
                                    <span>{$lang.SSH}</span>
                                </span>
                            </th>
                        {/if}
                        {if $fields.HTTP}
                            <th>
                                <span class="text-to-icon">
                                    <i class="material-icons" title="{$lang.HTTP}">http</i>
                                    <span>{$lang.HTTP}</span>
                                </span>
                            </th>
                        {/if}
                        {if $fields.POP3}
                            <th>
                                <span class="text-to-icon">
                                    <i class="material-icons" title="{$lang.POP3}">email</i>
                                    <span>{$lang.POP3}</span>
                                </span>
                            </th>
                        {/if}
                        {if $fields.IMAP}
                            <th>
                                <span class="text-to-icon">
                                    <i class="material-icons" title="{$lang.IMAP}">email</i>
                                    <span>{$lang.IMAP}</span>
                                </span>
                            </th>
                        {/if}
                        {if $fields.MYSQL}
                            <th>
                                <span class="text-to-icon">
                                    <i class="material-icons" title="{$lang.MYSQL}">inbox</i>
                                    <span>{$lang.MYSQL}</span>
                                </span>
                            </th>
                        {/if}
                        {if $fields.LOAD}
                            <th class="hide-md">{$lang.LOAD}</th>
                        {/if}
                        {if $fields.UPTIME}
                            <th class="hide-md">{$lang.UPTIME}</th>
                        {/if}
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$servers item=server}
                        <tr class="toloads" id="{$server.id}">
                            <td>{$server.name}</td>
                            {if $fields.FTP}<td><span class="loader-icon"></span></td>{/if}
                            {if $fields.SSH}<td><span class="loader-icon"></span></td>{/if}
                            {if $fields.HTTP}<td><span class="loader-icon"></span></td>{/if}
                            {if $fields.POP3}<td><span class="loader-icon"></span></td>{/if}
                            {if $fields.IMAP}<td><span class="loader-icon"></span></td>{/if}
                            {if $fields.MYSQL}<td><span class="loader-icon"></span></td>{/if}
                            {if $fields.LOAD}<td class="hide-md">-</td>{/if}
                            {if $fields.UPTIME}<td class="hide-md">-</td>{/if}
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        {literal}
            <script type="text/javascript">
                function loadStatuses() {
                    if ($('.toloads').length < 1)
                        return;
                    var id = $('.toloads').eq(0).attr('id');
                    $.post('?cmd=netstat&action=getstatus', {server_id: id}, function (data) {
                        var resp = parse_response(data);
                        if (resp.length > 4) {
                            $('.toloads').eq(0).html(resp);
                            $('.toloads').eq(0).removeClass('toloads');
                            loadStatuses();
                        }
                    });
                }
                $(function () {
                    loadStatuses();
                })
            </script>
        {/literal}
    {/if}
{/if}