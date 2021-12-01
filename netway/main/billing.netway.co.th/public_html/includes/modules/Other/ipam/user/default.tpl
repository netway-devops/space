<section class="section-account-header mb-5">
    <h1 class="mb-3">{$modname}</h1>
    {if $action === 'subnet'}
        <a href="{$ca_url}ipam/" class="">{$lang.goback|default:"Go back"}</a>
    {/if}
</section>

{if $action === 'subnet'}
    <table class="border-0 mb-4">
        <tr>
            <td class="p-0 pr-2 py-1"><b>{$lang.ip_subnet}:</b></td>
            <td class="p-0 pr-2 py-1">{$subnet.name} <span class="text-muted">({$subnet.subnet})</span></td>
        </tr>
        <tr>
            <td class="p-0 pr-2 py-1"><b>{$lang.ip_gateway}:</b> </td>
            <td class="p-0 pr-2 py-1">{$subnet.gateway}</td>
        </tr>
    </table>
    <a href="{$ca_url}ipam/&action=subnet&subnet={$subnet.id}" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table position-relative">
            <thead>
            <tr>
                <td>{$lang.ip}</td>
                <td>{$lang.service}</td>
                <td>{$lang.description}</td>
                <td>{$lang.reverse_dns}</td>
                <td width="120"></td>
            </tr>
            </thead>
            <tbody id="updater">
                {include file="ajax.ips.tpl"}
            </tbody>
        </table>
    </div>
    {if $totalpages > 1}
        <div class="pagination clearfix d-flex flex-row mt-4">
            <ul class="pagination" rel="{$totalpages}">
                <li class="pull-left page-item page-item-left"><a class="page-link" href="#{$lang.previous}">{$lang.previous}</a></li>
                <li class="pull-right page-item page-item-right"><a class="page-link" href="#{$lang.next}">{$lang.next}</a></li>
            </ul>
        </div>
    {/if}
    <div class="subnet-modal"></div>
    <script>
        var editIPUrl = '{$ca_url}ipam&action=ip';
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
                            <a href="{$ca_url}ipam&action=subnet&subnet={$serv.server.id}">{$serv.server.name}</a>
                        </td>
                        <td>{if $serv.server.private}{$lang.private|ucfirst}{else}{$lang.public|ucfirst}{/if}</td>
                        <td>{if $serv.server.vlan_name}{$serv.server.vlan_name}{else}-{/if}</td>
                        <td>{$serv.ips_total}</td>
                        <td width="120">
                            <a class="btn btn-primary" href="{$ca_url}ipam&action=subnet&subnet={$serv.server.id}">{$lang.show_ips}</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    {/if}
{/if}