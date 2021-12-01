<div id="bandwidth-mgr">
    <script type="text/javascript" src="{$template_dir}js/bandwidth.js"></script>
    <script type="text/javascript">
        var bwModule = {$bwModule|@json_encode};
    </script>

    {literal}
        <style type="text/css">
            .lgraph-container{
                margin: 20px 10px;
            }

            .lgraph {
                min-width: 600px;
                min-height: 150px;
                text-align: center;
            }

            .lgraph-title {
                font-size: 13px;
            }

            .lgraph-period {
                color: #565656;
            }

            #bandwidth_billing .whitetable,
            #bandwidth_billing .loading-biling {
                margin-bottom: 20px;
            }
        </style>
    {/literal}
    <div id="add_bandwidth" style="display:none">

        <div class="bw-port-preload text-center">
            <img src="{$template_dir}img/ajax-loading.gif">
        </div>


        <div hidden>
            <div class="form-group">
                <label>Switch</label>
                <select id="bw-switch" class="form-control">
                </select>
            </div>
            <div class="form-group bw-port-form">
                <label>Port</label>
                <select id="bw-port" class="form-control">
                </select>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" value="1" checked="checked" id="billforit"/>
                    Bill for this port's bandwidth
                </label>
            </div>
            <input class="server-id" type="hidden"
                   value="" name="port_server_id"/>
        </div>
    </div>
    <div id="bandwidth_billing">
        <p class="text-center loading-biling">
            Loading bandwidth/billing data...
            <img src="{$template_dir}img/ajax-loading.gif">
        </p>

    </div>
    {if !$bandwidth_datasources}
        <div class="blank_state_smaller blank_forms" id="blank_bandwidth">
            <div class="blank_info">
                <h3>Connect this account with {$bwModule.modulename} graphs</h3>
                <span class="fs11">
                    With HostBill you can monitor bandwidth utilisation/overages measured by {$bandwidthModule} "Interface - Traffic" graphs. <br/>
                    Additionally using Product->Client functions you can allow access to selected graphs for your customers in client area.<br/>

                </span>
                <div class="clear"></div>
                <br>
                <a class="btn btn-success bandwidth-add-port" href="#">
                    <span class="addsth"><strong>Select switch/ports to connect</strong></span>
                </a>
                <div class="clear"></div>
            </div>
        </div>
    {else}
        <h3>Assigned devices</h3>
        <ul class="list-group">

            {foreach from=$bandwidth_datasources item=itm}
                <li class="bandwidth_row list-group-item">
                    <div class="row">
                        <div class="col-md-4">
                            <a class="btn btn-sm btn-danger bw-unasign"
                               title="Unassign" data-id="{$itm.id}" href="#">
                                <i class="fa fa-times"></i>
                                Unassign
                            </a>
                            <a class="btn btn-sm btn-primary bw-load-graphs"
                               title="Load Ports" href="#"
                               data-device="{$itm.device_id}" data-port="{$itm.port_id}"
                               data-server="{$itm.server_id}">
                                <i class="fa fa-area-chart"></i>
                                Load graphs
                            </a>
                        </div>
                        <div class="col-md-8">
                            {$itm.name} {if !$itm.billed}<em>Not billable</em>{/if}
                        </div>
                    </div>
                    <div class="lgraphs" id="graphs_{$itm.device_id}_{$itm.port_id}" style="display:none">
                        {foreach from=$itm.graphs item=graph key=gperiod}
                            <div class="lgraph-container">
                                <div class="lgraph-title">
                                    <strong>{$lang[$gperiod.lang]}</strong>
                                    <span class="lgraph-period">
                                        ({$graph.period.start} - {$graph.period.end})
                                    </span>
                                </div>
                                <div class="l{$gperiod} lgraph"></div>
                            </div>
                        {/foreach}
                    </div>
                </li>
            {/foreach}
        </ul>
        <a class="btn btn-success bw-load-ports" href="#">
            <i class="fa fa-plus"></i> Select switch/ports to connect
        </a>
    {/if}
</div>