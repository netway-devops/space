{if $action == 'apps'}
        <div class="form-group">
            <label>App</label>
            <select id="gw-app-select" class="form-control">
                <option value="0">Select app</option>
                {foreach from=$servers item=server}
                    <option value="{$server.id}">{$server.gname} - {$server.name}</option>
                {/foreach}
            </select>
        </div>
{elseif $action == 'devices'}
    <div class="form-group">
        <label>Device</label>
        <select id="gw-device-select" class="form-control">
            <option value="0">Select device</option>
            {foreach from=$devices item=server key=serverid}
                <option value="{$serverid}">{$server}</option>
            {/foreach}
        </select>
    </div>
{elseif $action == 'devicegraphs' || $action == 'deviceports'}
    <div class="form-group">
        <label>Assign device graph</label>
        <select id="gw-device-graphs-select" class="form-control">
            <option value="0">Select device graph</option>
            {foreach from=$graphs item=server key=serverid}
                <option value="{$serverid}">{$server}</option>
            {/foreach}
        </select>
    </div>
    {if $ports}
    <div id="gw-ports">

        <div class="form-group">
            <label>Or select port(s) to assign its graph</label>
            <select id="gw-ports-select" class="form-control"  multiple>
                <option value="0">Select port</option>
                {foreach from=$ports item=server key=serverid}
                    <option value="{$serverid}"> {$serverid} {if is_array($server)}{$server.ifName}{else}{$server}{/if}</option>
                {/foreach}
            </select>
        </div>
    </div>
    {/if}
{elseif $action == 'portgraphs'}
    <div class="form-group">
        <label>Assign port graph</label>
        <select id="gw-port-graphs-select" class="form-control">
            {foreach from=$graphs item=server key=serverid}
                <option value="{$serverid}">{$server}</option>
            {/foreach}
        </select>
    </div>

{elseif $action == 'graphoptions'}
    graph options, period, name, resolution

{elseif $action == 'loadassignments'}
    {if $graphs}
       <div class="row no-gutter">

           <div class="col-md-6 col-graph">
           {foreach from=$graphs item=graph name=fr}
               {if $smarty.foreach.fr.iteration%2==0}{continue}{/if}
                   <div class="box box-primary " >
                       <div class="box-header" >
                           <h3 class="box-title">{$graph.name} </h3>
                           <div class="box-tools pull-right">
                               <a href="#" class="btn btn-default btn-sm gw-refresh" data-id="{$graph.id}" >Refresh</a>
                               <a href="#" class="btn btn-default btn-sm gw-pin {if $graph.flags  & 1}active{/if}" data-id="{$graph.id}" title="Set as featured"><i class="fa {if $graph.flags  & 1}fa-star{else}fa-star-o{/if}" aria-hidden="true"></i></a>
                               <a href="#" class="btn btn-danger btn-sm gw-unassign" data-id="{$graph.id}" >Unassign</a>
                           </div>
                       </div>
                       <div class="box-body">
                           <img src="?cmd=graphs&action=show&graph_id={$graph.id}" alt="{$graph.name}" class="img-responsive center-block"/>
                       </div>
                   </div>
           {/foreach}
           </div>

           <div class="col-md-6 col-graph">
               {foreach from=$graphs item=graph name=fr}
                   {if $smarty.foreach.fr.iteration%2!=0}{continue}{/if}
                   <div class="box box-primary " >
                       <div class="box-header" >
                           <h3 class="box-title">{$graph.name} </h3>
                           <div class="box-tools pull-right">
                               <a href="#" class="btn btn-default btn-sm gw-refresh" data-id="{$graph.id}" >Refresh</a>
                               <a href="#" class="btn btn-default btn-sm gw-pin {if $graph.flags  & 1}active{/if}" data-id="{$graph.id}"  title="Set as featured"><i class="fa {if $graph.flags  & 1}fa-star{else}fa-star-o{/if}" aria-hidden="true"></i></a>
                               <a href="#" class="btn btn-danger btn-sm gw-unassign" data-id="{$graph.id}" >Unassign</a>
                           </div>
                       </div>
                       <div class="box-body">
                           <img src="?cmd=graphs&action=show&graph_id={$graph.id}" alt="{$graph.name}" class="img-responsive center-block"/>
                       </div>
                   </div>
               {/foreach}
           </div>
       </div>

    {/if}
{else}

    <script type="text/javascript" src="{$template_dir}js/graphs.js"></script>
    <script type="text/javascript">
        var graph_rel_type = {$rel_type|@json_encode};
        var graph_rel_id = {$rel_id|@json_encode};
    </script>
    <div id="add-graph-window" style="display:none">

        <div class="gw-port-preload text-center">
            <img src="{$template_dir}img/ajax-loading.gif">
        </div>

        <div>
            <div id="gw-app"></div>
            <div id="gw-devices"></div>
            <div id="gw-device-graphs"></div>
            <div id="gw-port-graphs"></div>
            <div id="gw-options" class="well" hidden >
                <div class="row">
                    <div class="col-md-12">

                        <div class="form-group">
                            <label>Graph title</label>
                            <input id="gw-name" class="form-control" type="text" placeholder="Required: Enter graph title" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Period</label>
                            <select name="options[period]" class="form-control" id="gw-period">
                                <option value="5i">5 minutes</option>
                                <option value="1h">1 hour</option>
                                <option value="6h">6 hours</option>
                                <option value="1d">Today</option>
                                <option value="-1d">Yesterday</option>
                                <option value="1w">1 week</option>
                                <option value="1m">This month</option>
                                <option value="-1m">Previous month</option>
                                <option value="1y">This year</option>
                                <option value="-1y">Previous year</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Width</label>
                            <input name="options[width]" class="form-control" type="text" value="600" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Height</label>
                            <input name="options[height]" class="form-control" type="text" value="210" />
                        </div>
                    </div>
                    <div class="col-md-3">

                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input value="1" type="checkbox" id="gw-show-client"> Show in client portal?
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input value="1" type="checkbox" name="options[cache]" checked="checked" > Cache image?
                                </label>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="gw-manager" class="row no-gutter">
        {if !$featured}
            <div class="col-md-12">

            <div class="box box-primary " >
                <div class="box-header" >
                    <h3 class="box-title">Assign graphs</h3>
                </div>
                <div class="box-body">
                   <p>With HostBill you can assign graphs directly from supported graphing/monitoring Apps to display here</p>

                    <a class="btn btn-success btn-add-graph" href="#">
                        <span class="addsth"><strong>Assign new graph</strong></span>
                    </a>
                </div>

            </div>



        </div>{/if}

        <div id="gw-assigned-graphs" {if $featured}data-featured="1"{/if}>
            {if $graphs}
                {include file='ajax.graphs.tpl' action='loadassignments'}
                {else}
                <center>{if $featured}<em>Loading featured graphs</em>{else}<em>Loading assigned graphs</em>{/if}</center>
            {/if}</div>
    </div>

{/if}