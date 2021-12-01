<form action="" method="post" id="serverform">
    <div class="lighterblue" style="padding: 10px;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">DNS Service package</h3>
            </div>
            <div class="panel-body">
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
                <b>DNS package</b><br/>
                <div class="col-md-6">
                    <select name="package" class="form-control">
                        {if $pacakages}
                            {foreach from=$pacakages item=package}
                                <option {if $submit.package == $package.id}selected="selected"{/if}
                                        value="{$package.id}">&nbsp;{$package.name}&nbsp;
                                </option>
                            {/foreach}
                        {else}
                            <option>No DNS management packages available</option>
                        {/if}
                    </select>
                </div>

                <div class="col-md-2">
                    {if $pacakages}
                        <a href="?cmd=services&amp;action=product&amp;id={$submit.package}" target="_blank"
                           id="link_to_product" class="btn btn-default left"><i class="fa fa-external-link"></i></a>
                    {else}
                        <a href="?cmd=services&action=addcategory" target="_blank"
                           id="link_to_product" class="btn btn-default left"><i class="fa fa-plus"></i> Create DNS package</a>
                    {/if}
                </div>

            </div>
        </div>


        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Create DNS Zone - <strong>On domain registration / transfer</strong></h3>
            </div>
            <div class="panel-body">
                <ul class="treeview eventtree left" style="padding-left:3px;">
                    <li style="padding-top:1px">
                        <label>
                            <input type="radio" name="onregister" {if $submit.onregister == '1'}checked="checked"{/if}
                                   value="1"/>
                            Yes, before domain registration / transfer
                        </label>
                    </li>
                    <li style="padding-top:1px">
                        <label>
                            <input type="radio" name="onregister" {if $submit.onregister == '2'}checked="checked"{/if}
                                   value="2"/>
                            Yes, after successful domain registration / transfer
                        </label>
                    </li>
                    <li class="last" style="padding-top:1px">
                        <label>
                            <input type="radio" name="onregister" value="0"
                                   {if !$submit.onregister}checked="checked"{/if} />
                            No, do not create zones automatically
                        </label>
                    </li>
                </ul>
                <div class="clear">
                    <strong>Optionally:</strong><br/>
                    <label>
                        <input type="checkbox" name="hostingorder" value="1" {if $submit.hostingorder == 1}checked="checked"{/if} />
                        Do not create zone if domain was ordered with hosting in one order
                    </label>
                </div>


            </div>
        </div>


        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Create DNS Zone - <strong>On name server change</strong></h3>
            </div>
            <div class="panel-body">
                <ul class="treeview left" style="padding-left:3px; }">
                    <li style="padding-top:1px">
                        <label>
                            <input type="radio" name="onmatch" {if $submit.onmatch == '1'}checked="checked"{/if}
                                   value="1"/>
                            Yes, create zones for client that use our name servers
                        </label>
                    </li>
                    <li class="last" style="padding-top:1px">
                        <label>
                            <input type="radio" name="onmatch" {if $submit.onmatch == '0'}checked="checked"{/if}
                                   value="2"/>
                            No, do not create zones automatically
                        </label>
                    </li>
                </ul>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Remove DNS Zone - <strong>On name server change</strong></h3>
            </div>
            <div class="panel-body">
                <ul class="treeview left" style="padding-left:3px; }">
                    <li style="padding-top:1px">
                        <label>
                            <input type="radio" name="onmismatch" {if $submit.onmismatch == '1'}checked="checked"{/if}
                                   value="1"/>
                            Yes, remove zone when domain name servers change
                        </label>
                    </li>
                    <li class="last" style="padding-top:1px">
                        <label>
                            <input type="radio" name="onmismatch" {if $submit.onmismatch == '0'}checked="checked"{/if}
                                   value="2"/>
                            No, keep zone details
                        </label>
                    </li>
                </ul>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Create DNS Zone - <strong>On account/hosting creation</strong></h3>
            </div>
            <div class="panel-body">
                <ul class="treeview left" style="padding-left:3px; }">
                    <li style="padding-top:1px">
                        <label>
                            <input type="checkbox" name="owndomain" value="1"
                                   {if $submit.owndomain == 1}checked="checked"{/if} />
                            Create zone for clients who choose hosting with their own domain
                        </label>
                    </li>
                    <li class="last" style="padding-top:1px">
                        <label>
                            <input type="checkbox" name="subdomain" value="1"
                                   {if $submit.subdomain == 1}checked="checked"{/if} />
                            Create zone for clients who choose hosting with free subdomain
                        </label>
                    </li>
                </ul>

            </div>
        </div>


    </div>
    <div class="blu">
        <input type="submit" name="save" value="{$lang.savechanges}" class="btn btn-primary"/>
        <a class="btn btn-default"
           href="https://hostbill.atlassian.net/wiki/display/DOCS/Domain+DNS+automated+zone+creation" target="_blank">Learn
            more</a>
    </div>
</form>
<script type="text/javascript">
    {literal}
    function testConfiguration() {
        $('#testing_result').html('<img style="height: 16px" src="ajax-loading.gif" />');
        ajax_update('?cmd=module&module={/literal}{$module_id}{literal}&act=test&' + $('#serverform').serialize(), {}, '#testing_result');
    }

    $(document).ready(function () {
        $('.leftNav a:not(:contains("DNS"))').remove();
        $(".chosen").chosen({
            disable_search_threshold: 5,
            allow_single_deselect: true
        });
    });
    {/literal}
</script>
