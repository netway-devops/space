{if $section === 'subnet'}
    <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widget.name}{if $widget.id}&wid={$widget.id}{/if}&subnet={$subnet.id}&section=subnet" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table position-relative">
            <thead>
            <tr>
                <td>{$lang.ip}</td>
                <td>{$lang.Description}</td>
                <td>{$lang.reverse_dns}</td>
                <td width="120"></td>
            </tr>
            </thead>
            <tbody id="updater">
                {include file="`$widget_path`/ajax.ips.tpl"}
            </tbody>
        </table>
    </div>
    {include file="`$template_path`components/pagination.tpl"}
    <div class="subnet-modal"></div>
    <script>
        var editIPUrl = '{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widget.name}{if $widget.id}&wid={$widget.id}{/if}&ip={$ip.id}&section=ip';
    </script>
{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $(document).on("click", ".btn-editIp", function(e) {
                e.preventDefault();
                $('.subnet-modal').html('');
                $('.btn-editIp').addClass('disabled');
                $.ajax({
                    type: 'POST',
                    url: editIPUrl + '&ip=' + $(this).attr('data-ip'),
                    success: function(data) {
                        $('.btn-editIp').removeClass('disabled');
                        $('.subnet-modal').html(parse_response(data));
                        $('.subnet-modal').find("#modal-editIp").modal("show");
                    }
                });
            });
        });
    </script>
{/literal}
{else}
    {if !$subnets.servers}
        {$lang.ip_management_not_available}
    {else}
        <div class="table-responsive table-borders table-radius">
            <table class="table position-relative">
                <thead>
                <tr>
                    <td>{$lang.subnet}</td>
                    <td>{$lang.type}</td>
                    <td>{$lang.vlan}</td>
                    <td>{$lang.total_ips}</td>
                    <td width="120"></td>
                </tr>
                </thead>
                <tbody>
                {foreach from=$subnets.servers item=serv}
                    <tr>
                        <td>
                            <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widget.name}{if $widget.id}&wid={$widget.id}{/if}&subnet={$serv.server.id}&section=subnet">{$serv.server.name}</a>
                        </td>
                        <td>{if $serv.server.private}{$lang.private|ucfirst}{else}{$lang.public|ucfirst}{/if}</td>
                        <td>{if $serv.server.vlan_name}{$serv.server.vlan_name}{else}-{/if}</td>
                        <td>{$serv.ips_total}</td>
                        <td width="120">
                            <a class="btn btn-primary" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widget.name}{if $widget.id}&wid={$widget.id}{/if}&subnet={$serv.server.id}&section=subnet">{$lang.show_ips}</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    {/if}
{/if}