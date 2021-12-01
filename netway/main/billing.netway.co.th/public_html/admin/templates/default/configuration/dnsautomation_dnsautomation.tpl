<div class="container-fluid clear tabs tab-dnsautomation" style="padding: 0;">
    <div class="row tab-automation tab-domain-dnsautomation" style="padding: 0 15px;">
        <div class="col-md-12">
            <table style="margin-bottom: 20px;" width="100%" cellspacing="0" cellpadding="10">
                <tbody>
                <tr >
                    <td colspan="2"></td>
                    {foreach from=$dns_config.package item=dns_package key=id}
                        <div class="row dns-package" style="padding: 20px;">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>DNS Service package</label>
                                            <select name="configuration[package][{$id}]" class="form-control">
                                                {if $packages}
                                                    {foreach from=$packages item=package}
                                                        <option {if $dns_package == $package.id}selected="selected"{/if}
                                                                value="{$package.id}">&nbsp;{$package.name}&nbsp;
                                                        </option>
                                                    {/foreach}
                                                {else}
                                                    <option>No DNS management packages available</option>
                                                {/if}
                                            </select>
                                        </div>
                                        <div class="col-md-7">
                                            <label>Domain Apps</label>
                                            <select name="configuration[domain_apps][{$id}][]" class="form-control chosen-app" multiple>
                                                {if $domain_apps}
                                                    <option {if in_array('all', $dns_config.domain_apps[$id]) || !$dns_config.domain_apps[$id]}selected{/if} value="all">All</option>
                                                    {foreach from=$domain_apps item=app}
                                                        <option {if in_array($app.id, $dns_config.domain_apps[$id])}selected="selected"{/if}
                                                                value="{$app.id}">&nbsp;{$app.gname} - {$app.name}&nbsp;
                                                        </option>
                                                    {/foreach}
                                                {else}
                                                    <option>No Domain Apps available</option>
                                                {/if}
                                            </select>
                                        </div>
                                        {if $id != 0}
                                            <div class="col-md-1" style="margin-top: 25px;">
                                                <button type="button" class="btn btn-sm btn-danger" onclick="remove_package(this);">Remove</button>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" class="count_package" value="{$id}">
                        </div>
                        <div class="next-dns-package"></div>
                    {/foreach}
                </tr>
                <tr class="bordme">
                    <td colspan="2"> <div class="alert alert-info">
                            Package set here will be used for:
                            <ul>
                                <li><b>Matching nameservers.</b><br/> NS set in this product's configuration will be compared to
                                    domain nameservers. If nameservers match, DNS zone can be autocreated by this plugin.
                                </li>
                                <li><b>Creating DNS management package.</b> <br/> Once customer visits DNS management section in his
                                    domain, and its nameservers are set to your servers, he will be redirected to account with DNS
                                    management feature for this package
                                </li>
                            </ul>
                        </div></td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Mismatched nameservers</strong></td>
                    <td>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="configuration[mismatchns]" value="1" {if $dns_config.mismatchns == 1}checked="checked"{/if} />
                                Create DNS zone even if the nameservers do not match
                            </label>
                        </div>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Create Zone on: Register / Transfer</strong></td>
                    <td>
                        <div class="radio">
                            <label>
                                <input type="radio" name="configuration[onregister]" {if $dns_config.onregister == '1'}checked="checked"{/if}
                                       value="1"/>
                                <strong>Yes</strong>, before domain registration / transfer
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="configuration[onregister]" {if $dns_config.onregister == '2'}checked="checked"{/if}
                                       value="2"/>
                                <strong>Yes</strong>, after successful domain registration / transfer
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="configuration[onregister]" value="0"
                                       {if !$dns_config.onregister}checked="checked"{/if} />
                                <strong>No</strong>, do not create zones automatically
                            </label>
                        </div>
                        <strong>Optionally:</strong>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="configuration[hostingorder]" value="1" {if $dns_config.hostingorder == 1}checked="checked"{/if} />
                                Do not create zone if domain was ordered with hosting in one order
                            </label>
                        </div>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Create Zone on: NS Change</strong></td>
                    <td>
                        <div class="radio">
                            <label>
                                <input type="radio" name="configuration[onmatch]" {if $dns_config.onmatch == '1'}checked="checked"{/if}
                                       value="1"/>
                                <strong>Yes</strong>, create zones for client that use our name servers
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="configuration[onmatch]" {if $dns_config.onmatch == '0'}checked="checked"{/if}
                                       value="2"/>
                                <strong>No</strong>, do not create zones automatically
                            </label>
                        </div>
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Remove DNS Zone</strong></td>
                    <td>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="configuration[onmismatch][nameserver]" {if $dns_config.onmismatch.nameserver}checked="checked"{/if}
                                       value="1"/>
                                On name server change
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="configuration[onmismatch][deletion]" {if $dns_config.onmismatch.deletion}checked="checked"{/if}
                                       value="1"/>
                                On domain deletion
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="configuration[onmismatch][cancelation]" {if $dns_config.onmismatch.cancelation}checked="checked"{/if}
                                       value="1"/>
                                On domain cancelation (past grace period)
                            </label>
                        </div>
                    </td>
                </tr>

                </tbody>
            </table>


        </div>
    </div>
    <div class="nicerblu" style="text-align:center; margin-bottom: 15px;">
        <input type="submit" value="Save Changes" name="save[dnsautomation]" style="font-weight:bold" class="btn btn-primary">
    </div>
</div>
{literal}
<script>
    $('.chosen-app').chosenedge({
        enable_split_word_search: true,
        search_contains: true,
    }).on('change', function (e, data) {
        var select = $(this),
            values = select.val();

        if (values.indexOf('all') >= 0) {
            if (data.selected == 'all')
                select.val(['all']).trigger('chosen:updated')
            else {
                values.splice(values.indexOf('all'), 1);
                select.val(values).trigger('chosen:updated');
            }
        }
    });

    function remove_package(self) {
        $(self).closest('.dns-package').remove();
    }
</script>
{/literal}