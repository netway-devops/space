
<!-- reverse DNS -->


<div style="margin: 10px 0">
    <div class="container-fluid clear">
        <div class="row">
            <div class="col-md-5" id="add_pdu" {if !$rdnsid}style="display:none"{/if}>
                <form action="?cmd=module&module={$moduleid}&rdns=save" method="post" id="optform2">



                    <div class="form-group">
                        <label for="rdnsid">DNS App to use:</label>


                        <select name="rdnsid" class="form-control">
                            <option value="0">None - disable rDNS</option>
                            {foreach from=$rdnsapps item=app}

                                <option value="{$app.id}" {if $app.id==$rdnsid}selected="selected"{/if}>{$app.groupname} - {$app.name}</option>
                            {/foreach}
                        </select>

                        <p class="help-block"></p>
                    </div>

                    <div class="checkbox">
                        <label><input class="rdns_auto_clear" type="checkbox" value="1" name="rdns_config[auto_clear]" {if $rdns_config.auto_clear}checked{/if}> <b>Auto-clear related PTR record on IP unassign</b></label>
                    </div>

                    <div class="form-group">
                        <label>Default PTR template</label>
                        <input type="text" class="form-control" name="rdns_config[ptr_template]" value="{$rdns_config.ptr_template}">
                    </div>

                    <div class="checkbox">
                        <label><input class="rdns_set_ptr" type="checkbox" value="1" name="rdns_config[set_ptr]" {if $rdns_config.set_ptr}checked{/if}> <b>Set default PTR record on IP unassign</b></label>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary" onclick="$('#optform2').submit(); return false;">Save Changes</button>
                    </div>

                    {securitytoken}
                </form>

                <div class="panel panel-default">
                    <div class="panel-heading" id="status">
                        <h3 class="panel-title">Synchronize rDNS entries</h3>
                    </div>
                    <div class="panel-body" >
                        IPAM data, especially when imported may not be in sync with your DNS server's reverse DNS entries.
                        You can use this tool to start synchronization process.<br/>
                        <b>Note: </b> When synchronization starts rDNS entries in IPAM will be overwritten with those coming from DNS.<br/><br/>

                        <center>
                            <button type="button" class="btn btn-info" onclick="return startRDNSSync(this);">Start Synchronization</button>
                        </center>

                        <div id="taskprogress">

                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading" id="status">
                        <h3 class="panel-title">Auto-set default PTR</h3>
                    </div>
                    <div class="panel-body" >
                        Use this tool to automatically set default PTR record for all unused/unassigned IP addresses.<br/><br>
                        <center>
                            <button type="button" class="btn btn-info" onclick="return startAutoSetPTR(this);">Auto-set default PTR</button>
                        </center>

                        <div id="taskprogressptr">

                        </div>
                    </div>
                </div>


            </div>





            <div class="col-md-7">
                <div class="blank_state_smaller blank_forms" id="blank_pdu">
                    <div class="blank_info">
                        <h1>Enable automatic rDNS management for your customers</h1>
                        IPAM module can work with ClouDNS, PowerDNS or cPanelDNS module, allowing your colocation/dedicated customers to manage their PTR records directly from clientarea.
                        <br/><br/>
                        <b>To enable rDNS management in HostBill</b>
                        <ol>
                            <li>Go to Settings->Modules and enable ClouDNS, PowerDNS or cPanelDNS module</li>
                            <li>Configure connection to your DNS server in Settings->Apps</li>
                            <li>Enable Reverse DNS in Product->Client functions for your Colo/Dedi packages</li>
                            <li>Refresh this section to select App you will be using</li>
                            <li>Under your dedicated servers/colocation products enable Reverse DNS client function in product configuration</li>
                            <li>Create general DNS zone for <b>in-addr.arpa</b> or /24 subnet specific (like 3.2.1.in-addr.arpa for 1.2.3.0/24)</li>
                            <li>Clients that have packages with IPs assigned in (Account details)->IPAM tab will now be able to manage their rDNS records</li>
                            <li>Additionally, anytime you'll edit rDNS column in IPAM plugin, it will send updated record to DNS module</li>
                        </ol>
                        <br/>
                        <b>PTR template</b>
                        <ul>
                            <li>Available variables
                                <ul>
                                    <li><b>{ldelim}ip{rdelim}</b> - the IP address we use</li>
                                    <li><b>{ldelim}rip{rdelim}</b> - reversed octets IP address</li>
                                    <li><b>{ldelim}ip-dash{rdelim}</b> - ip address in dash notation</li>
                                    <li><b>{ldelim}rip-dash{rdelim}</b> - reversed octets IPs in dash notation</li>
                                </ul>
                            </li>
                            <li>Example:
                                <ul>
                                    <li>Template: <b><i>static-{ldelim}rip{rdelim}.hostbillapp.com</i></b></li>
                                    <li>PTR generated for address 1.2.3.4: <b><i>static-4.3.2.1.hostbillapp.com</i></b></li>
                                </ul>
                            </li>
                            <li>Example 2:
                                <ul>
                                    <li>Template: <b><i>static-{ldelim}rip-dash{rdelim}.hostbillapp.com</i></b></li>
                                    <li>PTR generated for address 1.2.3.4: <b><i>static-4-3-2-1.hostbillapp.com</i></b></li>
                                </ul>
                            </li>
                        </ul>

                        <div class="clear"></div>
                        {if !$rdnsid}
                            {if  $rdnsapps}<br>
                                <a onclick="
                    $('#add_pdu').show();
                    return false;" class="new_control" href="#"><span class="addsth"><strong>Select DNS App to use with rDNS</strong></span></a>
                            {/if}
                            <div class="clear"></div>
                        {/if}

                    </div>
                </div>
            </div>
        </div>


    </div>

</div>
{literal}
<script>
    var startRDNSSync = function(btn){
        if(!confirm("Are you sure?")) {
            return false;
        }
        $(btn).parent().hide();
        ajax_update('?cmd=ipam&action=rdnssync',{},'#taskprogress',true);
        return false;
    };

    var startAutoSetPTR = function (btn) {
        if(!confirm("Are you sure?")) {
            return false;
        }

        $(btn).parent().hide();
        ajax_update('?cmd=ipam&action=autosetptr',{},'#taskprogressptr',true);
        return false;
    }
</script>
{/literal}