<div id="modal-editIp" class="modal fade fade2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post" action="{if $custom_post}{$custom_post}{else}{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widget.name}{if $widget.id}&wid={$widget.id}{/if}&ip={$ip.id}&section=ip{/if}">
                <div class="modal-header">
                    <h4 class="modal-title font-weight-bold mt-2">{$lang.edit_ip}: {$ip.ipaddress}</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="{$lang.close}">
                        <i class="material-icons">cancel</i>
                    </button>
                </div>
                <div class="modal-body">
                    <label class="form-label d-block font-weight-bold" for="subdomain">{$lang.Description}</label>
                    {if $ip.status == 'reserved'}
                        {$ip.client_description|escape}
                    {else}
                        <textarea class="form-control" id="ip_description" name="description">{$ip.client_description}</textarea>
                    {/if}
                    {if $ip.ptrzone && $rdns_ok}
                        <label class="form-label d-block font-weight-bold mt-3" for="rdns">{$lang.reverse_dns}</label>
                        <input class="form-control" value="{$ip.ptrcontent}" type="text" id="ip_rdns" name="rdns[{$ip.ipaddress}][ptrcontent]"/>
                        <input type="hidden" name="rdns[{$ip.ipaddress}][oldptrcontent]" value="{$ip.ptrcontent}" />
                        <input type="hidden" name="rdns[{$ip.ipaddress}][ptrhash]" value="{$ip.ptrhash}" />
                        <input type="hidden" name="rdns[{$ip.ipaddress}][ptrid]" value="{$ip.ptrid}" />
                        <input type="hidden" name="rdns[{$ip.ipaddress}][ptrzone]" value="{$ip.ptrzone}" />
                        <input type="hidden" name="rdns[{$ip.ipaddress}][sid]" value="{$ip.server_id}" />
                    {/if}
                    {securitytoken}
                    <input type="hidden" name="make" value="update">
                    <input type="hidden" class="ipid" value="{$ip.id}">
                    <div class="w-100  mt-4">
                        <button type="submit" name="make" value="update_mfd" class="btn btn-primary w-100">{$lang.submit}</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            var sanitizeHTML = function (str) {
                var temp = document.createElement('div');
                temp.textContent = str;
                return temp.innerHTML;
            };

            $('#modal-editIp form').on("submit", function(e) {
                e.preventDefault();
                var mod = $('#modal-editIp');
                mod.modal("hide");
                $.ajax({
                    type: 'POST',
                    url: $(this).attr('action'),
                    data: $(this).serialize(),
                    success: function(data) {
                        parse_response(data);
                        var desc = mod.find('textarea#ip_description').val();
                        var rdns = mod.find('input#ip_rdns').val();
                        var ipid = mod.find('.ipid').val();
                        $(".row-editIp_" + ipid).find('td.ip_desc').html(sanitizeHTML(desc));
                        $(".row-editIp_" + ipid).find('td.ip_rdns').html(sanitizeHTML(rdns));
                    }
                });
            });
        });
    </script>
{/literal}