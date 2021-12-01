<script type="text/javascript" src="{$moduledir}js/chosen.js"></script>
<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;"> <form action="?cmd=dedimgr&do=rackedit&rack_id={$rack.id}" method="post" id="addcolocation">

            <div class="tabb colo_newrack">
                <h3 style="margin:0px;">Update Rack {$rack.name}</h3>

                <div class="form" style="margin:10px 0px">
                    <div class="form-group">
                        <label class="nodescr">Name</label>
                        <input name="name" type="text" value="{$rack.name}"/>
                    </div>

                    <div class="form-group">
                        <label class="nodescr">Room</label>
                        <input name="room" type="text" value="{$rack.room}"/>
                    </div>

                    <div class="form-group">
                        <label class="nodescr">Owner</label>
                        <select class="w250" name="client_id" default="{$rack.client_id}">
                            <option value="0">None</option>

                            {if $rack.client_id}
                                <option value="{$rack.client_id}" selected>{$client|@profilelink:false:false:false}</option>
                            {/if}
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="nodescr">Units [U]</label>
                        <input name="units" type="text" size="4" value="{$rack.units}"/>
                    </div>


                    <div class="form-group">
                        <label class="nodescr">Weight (empty) [lbs]</label>
                        <input name="empty_weight" size="4" value="{$rack.empty_weight}" type="text" />
                    </div>

                    <div class="form-group">
                        <label class="nodescr">Connector speed [MBps]</label>
                        <input name="networkspeed" size="6" type="text" value="{$rack.networkspeed}" />
                    </div>

                    {foreach from=$rack.fields item=f}
                        <div class="form-group">
                            <label class="nodescr">{$f.name}</label>
                            <input name="fields[{$f.id}]" class="w250" type="text" value="{$f.value}" />
                        </div>

                    {/foreach}
                    <div class="form-group">
                        <label class="nodescr">Sort order</label>
                        <input name="sort_order" class="w250" type="number" value="{$rack.sort_order}" />
                    </div>


                </div>

                <div class="clear"></div>
            </div>


        </form></div>

    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#addcolocation').submit(); return false"><span><b>Update rack details</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>