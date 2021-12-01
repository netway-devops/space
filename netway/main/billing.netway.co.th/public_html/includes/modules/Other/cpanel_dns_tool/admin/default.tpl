<div id="newshelfnav" class="newhorizontalnav" >
    <div class="list-1">
        <ul>
            <li class="active last">
                <a href="?cmd={$modulename}"><span>Setup</span></a>
            </li>
            <li class="">
                <a href="?cmd=logs&action=logfiles&logfile={$logfile}" target="_blank"><span>Synch Logs</span></a>
            </li>
            {*<li class="last">*}
                {*<a href="https://hostbill.atlassian.net/wiki/spaces/DOCS/pages/464814081/Plesk+DNS+Helper" target="_blank"><span>Documentation</span></a>*}
            {*</li>*}
        </ul>
    </div>
</div>
<form action="?cmd=cpanel_dns_tool&action=save_config" method="post">
    <input type="hidden" name="make" value="submit"/>
    <div class="container-fluid clear" style="padding-top:14px;">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="hostUrl">Target DNS</label>
                    <select id="apps" name="cpaneldns_app[]" class="form-control chosen" multiple>
                        <option value="0" {if !$config.cpaneldns_app || in_array('0', $config.cpaneldns_app)}selected="selected"{/if}>None, disable synchronization for now</option>
                        {foreach from=$servers item=s}
                            <option value="{$s.id}" {if in_array($s.id, $config.cpaneldns_app)}selected="selected"{/if}>{$s.gname} - {$s.name}</option>
                        {/foreach}
                    </select>
                    <p class="help-block">Zones coming from cPanel installations with configured extension will be pushed to this DNS server.</p>
                </div>
                <div class="form-group">
                    <label for="hostUrl">Source servers</label>
                    <select id="apps" name="cpanel_app[]" class="form-control chosen" multiple>
                        <option value="0" {if !$config.cpanel_app || in_array('0', $config.cpanel_app)}selected="selected"{/if}>None, disable synchronization for now</option>
                        {foreach from=$cpanel_apps item=s}
                            <option value="{$s.id}" {if in_array($s.id, $config.cpanel_app)}selected="selected"{/if}>{$s.gname} - {$s.name}</option>
                        {/foreach}
                    </select>
                    <p class="help-block">Servers that will be synchronized.</p>
                </div>

                <div class="form-group">

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="cpaneldns_assign" value="1" {if $config.cpaneldns_assign}checked="checked"{/if} >
                            Try to assign imported zone to existing HostBill DNS management account <i class="vtip_description" title="When enabled tool will look for active DNS management service using target DNS & belonging to customer who owns synchornized zone."></i>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="cpaneldns_nolocal" value="1" {if $config.cpaneldns_nolocal}checked="checked"{/if} >
                            Sync DNS only if HostBill domain exist <i class="vtip_description" title="When enabled, zone will be created/updated/deleted on target DNS only if active domain with matching name exists in HostBill"></i>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="cpaneldns_freesubdomains" value="1" {if $config.cpaneldns_freesubdomains}checked="checked"{/if} >
                            Transfer A/CNAME  only for free subdomains <i class="vtip_description" title="In HostBill product configuration you can offer free subdomain to product. If such subdomain is used to create cPanel account, with this option enabled new zone will not be created in target DNS, instead main domain zone will be updated with related A/CNAME records"></i>
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="cpaneldns_dontsynch" value="1" {if $config.cpaneldns_dontsynch}checked="checked"{/if} >
                            Do not synch/import zones that already exists in target DNS server
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="cpaneldns_replacens" value="1" {if $config.cpaneldns_replacens}checked="checked"{/if} >
                            Replace/set NS records for zone using target DNS App settings
                        </label>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="cpaneldns_dontarpa" value="1" {if $config.cpaneldns_dontarpa}checked="checked"{/if} >
                            Do not synch in-addr.arpa zones
                        </label>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
            </div>
        </div>
    </div>
    <div class="clearfix" style="padding: 10px 10px;">
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </div>
    {securitytoken}
</form>
{literal}
<script>
    $( document ).ready(function() {
        $('.leftNav a:not(:contains("DNS"))').remove();
        $(".chosen").chosenedge({
            disable_search_threshold: 5,
            allow_single_deselect: true
        }).on('change', function (e, data) {
            var select = $(this),
                values = select.val();
            if (!$.isArray(values))
                select.val(["0"]).trigger('chosen:updated');
            else if (values.indexOf("0") >= 0) {
                if (data.selected === "0")
                    select.val(["0"]).trigger('chosen:updated');
                else {
                    values.splice(values.indexOf("0"), 1);
                    select.val(values).trigger('chosen:updated');
                }
            }
        });
    });
</script>
{/literal}