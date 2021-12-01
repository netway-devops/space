<div id="newshelfnav" class="newhorizontalnav" >
    <div class="list-1">
        <ul>
            <li class="active last">
                <a href="?cmd={$modulename}"><span>Setup</span></a>
            </li>

            <li class="">
                <a href="?cmd=logs&action=logfiles&logfile=pleskdns.log" target="_blank"><span>Synch Logs</span></a>
            </li>
            <li class="last">
                <a href="https://hostbill.atlassian.net/wiki/spaces/DOCS/pages/464814081/Plesk+DNS+Helper" target="_blank"><span>Documentation</span></a>
            </li>
        </ul>
    </div>

</div>
<form action="?cmd=pleskdnstool&action=saveconfig" method="post">
    <input type="hidden" name="make" value="submit"/>
<div class="container-fluid clear" style="padding-top:14px;">
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="hostUrl">Target DNS</label>
                <select id="" name="pleskdns_app" class="form-control chosen">

                    <option value="0" {if !$config.pleskdns_app}selected="selected"{/if}>None, disable synchronization for now</option>
                    {foreach from=$servers item=s}
                        <option value="{$s.id}" {if $config.pleskdns_app == $s.id}selected="selected"{/if}>{$s.gname} - {$s.name}</option>
                    {/foreach}
                </select>
                <p class="help-block">Zones coming from Plesk installations with configured extension will be pushed to this DNS server.</p>
            </div>

            <div class="form-group">

                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="pleskdns_assign" value="1" {if $config.pleskdns_assign}checked="checked"{/if} >
                        Try to assign imported zone to existing HostBill DNS management account <i class="vtip_description" title="When enabled tool will look for active DNS management service using target DNS & belonging to customer who owns synchornized zone."></i>
                    </label>
                </div>

                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="pleskdns_nolocal" value="1" {if $config.pleskdns_nolocal}checked="checked"{/if} >
                        Sync DNS only if HostBill domain exist <i class="vtip_description" title="When enabled, zone will be created/updated/deleted on target DNS only if active domain with matching name exists in HostBill"></i>
                    </label>
                </div>

                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="plesk_skipexisting" value="1" {if $config.plesk_skipexisting}checked="checked"{/if} >
                        Check if zone exist in target DNS before attempting to creating it <i class="vtip_description" title="When enabled, and zone already exists in target DNS, tool will not attempt to create it again"></i>
                    </label>
                </div>

                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="plesk_freesubdomains" value="1" {if $config.plesk_freesubdomains}checked="checked"{/if} >
                        Transfer A/CNAME  only for free subdomains <i class="vtip_description" title="In HostBill product configuration you can offer free subdomain to product. If such subdomain is used to create plesk account, with this option enabled new zone will not be created in target DNS, instead main domain zone will be updated with related A/CNAME records"></i>
                    </label>
                </div>

                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="plesk_dontsynch" value="1" {if $config.plesk_dontsynch}checked="checked"{/if} >
                        Do not synch/import zones that already exists in target DNS server
                    </label>
                </div>

                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="plesk_replacens" value="1" {if $config.plesk_replacens}checked="checked"{/if} >
                        Replace/set NS records for zone using target DNS App settings
                    </label>
                </div>
            </div>
        </div>

        <div class="col-md-6">



            <div class="well">
                1. Refer to <a href="https://hostbill.atlassian.net/wiki/spaces/DOCS/pages/464814081/Plesk+DNS+Helper" target="_blank">documentation</a><br/>
                2.  <a href="{$system_url}includes/modules/Hosting/plesk12/pleskmodule/dist/hostbill-dns-1.0.1-0.zip" class="btn btn-sm btn-info"><i class="fa fa-download"></i> Download & install Plesk Extension</a><br/>
                3. In Plesk extension use following HostBill API endpoint URL:<br>
            <h4>{$system_url}?cmd=pleskdnstool</h4></div>
        </div>
    </div>
</div>
    <div class="clearfix" style="padding: 10px 10px;">
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </div>
    {securitytoken}
</form>
{literal}

<link href="templates/default/js/chosen/chosen.css" rel="stylesheet" type="text/css"/>
<script src="templates/default/js/chosen/chosen.min.js" type="text/javascript"></script>
<script>
    $( document ).ready(function() {
        $('.leftNav a:not(:contains("DNS"))').remove();
        $(".chosen").chosen({
            disable_search_threshold: 5,
            allow_single_deselect: true
        });
    });
</script>{/literal}