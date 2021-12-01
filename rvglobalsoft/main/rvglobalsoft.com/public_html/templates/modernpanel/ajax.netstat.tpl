{if $action == 'getstatus'}
    {if $status}
        <td>
            <strong>
                {$status.name}
            </strong>
        </td>
        {if $fields.FTP}
            <td align="center">
                {if $status.status.FTP=='1'}
                    <i class="icon-server-yes"></i>
                {else}
                    <i class="icon-server-no"></i>
                {/if}
            </td>
        {/if}
        {if $fields.SSH}
            <td align="center">
                {if $status.status.SSH=='1'}
                    <i class="icon-server-yes"></i>
                {else}
                    <i class="icon-server-no"></i>
                {/if}
            </td>
        {/if}
        {if $fields.HTTP}
            <td align="center">
                {if $status.status.HTTP=='1'}
                    <i class="icon-server-yes"></i>
                {else}
                    <i class="icon-server-no"></i>
                {/if}
            </td>
        {/if}
        {if $fields.POP3}
            <td align="center"> 
                {if $status.status.POP3=='1'}
                    <i class="icon-server-yes"></i>
                {else}
                    <i class="icon-server-no"></i>
                {/if}
            </td>
        {/if}
        {if $fields.IMAP}
            <td align="center">
                {if $status.status.IMAP=='1'}
                    <i class="icon-server-yes"></i>
                {else}
                    <i class="icon-server-no"></i>
                {/if}
            </td>
        {/if}
        {if $fields.MYSQL}
            <td align="center">
                {if $status.status.MYSQL=='1'}
                    <i class="icon-server-yes"></i>
                {else}
                    <i class="icon-server-no"></i>
                {/if}
            </td>
        {/if}
        {if $fields.LOAD}
            <td align="center">
                {if $status.status.LOAD}{$status.status.LOAD}
                {else}{$lang.Unavailable}
                {/if}
            </td>
        {/if}
        {if $fields.UPTIME}
            <td align="center">
                {if $status.status.UPTIME}{$status.status.UPTIME}
                {else}{$lang.Unavailable}
                {/if}
            </td>
        {/if}
    {/if}
{else}
    {if $servers}
        <div class="table-box overflow-h">
            <div class="table-header"></div>
            <table class="table table-header-fix p-td">
                <tr>	
                    <th>{$lang.servers}</th>
                    {if $fields.FTP}<th>{$lang.FTP}</th>
                        {/if}
                        {if $fields.SSH}<th>{$lang.SSH}</th>
                        {/if}
                        {if $fields.HTTP}<th>{$lang.HTTP}</th>
                        {/if}
                        {if $fields.POP3}<th>{$lang.POP3}</th>
                        {/if}
                        {if $fields.IMAP}<th>{$lang.IMAP}</th>
                        {/if}
                        {if $fields.MYSQL}<th>{$lang.MYSQL}</th>
                        {/if}
                        {if $fields.LOAD}<th>{$lang.LOAD}</th>
                        {/if}
                        {if $fields.UPTIME}<th>{$lang.UPTIME}</th>
                        {/if}
                </tr>
                {foreach from=$servers item=server}
                    <tr class="toloads" id="{$server.id}">
                        <td>{$server.name}</td>
                        {if $fields.FTP}<td><img src="{$template_dir}img/bullet_white.gif" /></td>
                            {/if}
                            {if $fields.SSH}<td><img src="{$template_dir}img/bullet_white.gif" /></td>
                            {/if}
                            {if $fields.HTTP}<td><img src="{$template_dir}img/bullet_white.gif" /></td>
                            {/if}
                            {if $fields.POP3}<td><img src="{$template_dir}img/bullet_white.gif" /></td>
                            {/if}
                            {if $fields.IMAP}<td><img src="{$template_dir}img/bullet_white.gif" /></td>
                            {/if}
                            {if $fields.MYSQL}<td><img src="{$template_dir}img/bullet_white.gif" /></td>
                            {/if}
                            {if $fields.LOAD}<td>-</td>
                        {/if}
                        {if $fields.UPTIME}<td>-</td>
                        {/if}
                    </tr>
                {/foreach}
            </table>
        </div>
        {literal}
            <script type="text/javascript">
                function loadStatuses() {
                    if ($('.toloads').length < 1)
                        return;
                    var id = $('.toloads').eq(0).attr('id');
                    $.post('?cmd=netstat&action=getstatus', {server_id: id}, function(data) {
                        var resp = parse_response(data);
                        if (resp.length > 4) {
                            $('.toloads').eq(0).html(resp);
                            $('.toloads').eq(0).removeClass('toloads');
                            loadStatuses();
                        }

                    });
                }
                $(function(){
                    loadStatuses();
                })
            </script>
        {/literal}
    {/if}
{/if}