<div class="row no-gutter">
    <div class="col-md-3 mainleftcol">
        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title">Move item</h3>
            </div>
            <div class="box-body">
                <div id="move_item">
                    <div class="form-group">
                        <label class="nodescr">Collocation</label>
                        <select id="move_colocation" class="form-control move_item">
                            <option value=""> - / -</option>
                        </select>
                    </div>
                    <div class="form-group " style="display: none">
                        <label class="nodescr">Floor</label>
                        <select id="move_floor" class="form-control move_item">
                            <option value="">- / -</option>
                        </select>
                    </div>
                    <div class="form-group" style="display: none">
                        <label class="nodescr">Rack</label>
                        <select id="move_rack" class="form-control move_item">
                            <option value="">- / -</option>
                        </select>
                    </div>
                    <div class="form-group" style="display: none">
                        <label class="nodescr">Orientation</label>
                        <select id="move_orientation" class="form-control move_item">
                            <option value="">- / -</option>
                        </select>
                    </div>
                    <div class="form-group" style="display: none">
                        <label class="nodescr">Position</label>
                        <select id="move_position" class="form-control move_item">
                        </select>
                    </div>
                </div>
            </div>
            <div class="box-footer clearfix no-border">
                <a href="#" data-token="{$security_token}" id="move_tolocation" class="btn btn-sm btn-primary disabled right">Move to new location</a>
            </div>
        </div>
    </div>
    <div class="col-md-9 mainrightcol">
        <form id="saveform" class="clearfix" method="post" action="?cmd=dedimgr">
            <input type="hidden" name="do" value="rack" />
            <input type="hidden" name="backview" value="{$backview}" />
            <input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
            {if $item.id!='new'}
                <input type="hidden" name="id" value="{$item.id}" id="item_id"/>
                <input type="hidden" name="make" value="edititem" />
            {else}
                <input type="hidden" name="id" value="new" id="item_id"/>
                <input type="hidden" name="make" value="additem" />
                <input type="hidden" name="item_id" value="{$item.type_id}" />
                <input type="hidden" name="category_id" value="{$item.category_id}" />
                <input type="hidden" name="position" value="{$position}" />
                <input type="hidden" name="location" value="{$location}" />
            {/if}
            {if $itsblade}
                <input type="hidden" name="parent_id" value="{$itsblade}" />
                <input type="hidden" name="location" value="Blade" />
            {/if}
            <input type="hidden" value="{if $item.category_name}{$item.category_name|escape} - {/if}{$item.name|escape} {if $item.label}&raquo; {$item.label|escape}{/if}  #{$item.id}" id="item_name">



            <div class="box  box-solid ">
            <div class="box-header">
                <h3 class="box-title">Basic Details</h3>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-3">

                        <div class="form-group">
                            <label>Hostname / label</label>
                            <input type="text" size="" class="form-control" name="label" value="{$item.label}" id="item_label"/>
                            <input type="hidden" value="{$item.hash}" id="item_hash"/>
                        </div>
                        <dl>
                            <dt>ID</dt>
                            <dd>{$item.id}</dd>
                        </dl>

                    </div>
                    <div class="col-md-3">

                        <div class="form-group">
                            <label class="nodescr">Owner</label>
                            <select class="form-control" name="client_id" default="{$item.client_id}" onchange="reloadServices()">
                                <option value="0">None</option>
                                {if $item.client_id}
                                    <option value="{$item.client_id}" selected>{$client|@profilelink:false:false:false}</option>

                                {/if}
                            </select>
                        </div>
                        <div id="related_service" class="form-group">
                            {if $item.account_id}
                                <label class="nodescr">Related service</label>
                                <input type="text"   size="" value="{$item.account_id}" class="form-control" name="account_id" id="account_id" />

                            {/if}
                        </div>
                    </div>
                    {if !$itsblade}
                    <div class="col-md-3">

                            <div class="form-group">
                                <label>Parent device</label>
                                <select class="form-control" name="parent_id" default="{$item.parent_id}" >
                                    <option value="0" {if $item.parent_id=='0'}selected="selected"{/if}>#0: None</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Server pool</label>
                                <select class="form-control" name="pool_id" default="{$item.pool_id}" >
                                    <option value="0" {if $item.pool_id=='0'}selected="selected"{/if}>#0: None</option>
                                </select>
                            </div>
                    </div>
                    {/if}

                    <div class="col-md-3">

                        <div class="form-group">
                            <label>Admin description</label>
                            <textarea name="notes" style="height: 100px" class="form-control">{$item.notes}</textarea>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="1" {if $item.isblade=='1'}checked="checked"{/if} name="isblade" />
                                Is it BladeSystem?
                            </label>
                            (<em>After enabling save and re-load</em>)
                        </div>
                    </div>
                </div>

            </div>

        </div>
        {if $item.fields}
            <div class="box  box-solid ">
                <div class="box-header">
                    <h3 class="box-title">Hardware details</h3>
                </div>
                <div class="box-body">

                    <div class="row">
                    {foreach from=$item.fields item=f}
                        {if $f.field_type=='clients'}{continue}
                        {/if}

                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="nodescr">{$f.name} </label>
                            {if $f.field_type=='input'}
                                <input name="field[{$f.id}]" value="{$f.value}" class="form-control"  type="text" />
                            {elseif $f.field_type=='text'}
                                <input name="field[{$f.id}]" value="{$f.value}" type="hidden" />
                                {$f.default_value}
                            {elseif $f.field_type=='select'}
                                <select name="field[{$f.id}]" class="form-control">
                                    {foreach from=$f.default_value item=d}
                                        <option {if $f.value==$d}selected="selected"{/if}>{$d}</option>
                                    {/foreach}
                                </select>

                            {elseif $f.field_type=='pdu_app'}
                                <div class="input-group">
                                    <select name="field[{$f.id}]" class="form-control" onchange="changeHardwareApp(this, 'pdu')">
                                        <option value="0" {if $f.value=='0'}selected="selected"{/if}>---</option>
                                        {foreach from=$pdu_apps item=d}
                                            <option value="{$d.id}" {if $f.value==$d.id}selected="selected"{/if}>#{$d.id} {$d.groupname} - {$d.name}</option>
                                        {/foreach}
                                        <option value="new" >Add new connection</option>
                                    </select>
                                    <span class="input-group-btn">
                                <a class="btn btn-default" href="#" onclick="loadports('{$f.id}', 'PDU', this);
                                        return false;"><span class="fa fa-download"></span> Load Ports
                                </a>
                            </span>
                                </div>
                            {elseif $f.field_type=='switch_app'}
                                <div class="input-group">
                                    <select name="field[{$f.id}]" class="form-control" onchange="changeHardwareApp(this, 'switch')">
                                        <option value="0" {if $f.value=='0'}selected="selected"{/if}>---</option>
                                        {foreach from=$switch_apps item=d}
                                            <option value="{$d.id}" {if $f.value==$d.id}selected="selected"{/if}>#{$d.id} {$d.groupname} - {$d.name}</option>
                                        {/foreach}
                                        <option value="new" >Add new connection</option>
                                    </select>
                                    <span class="input-group-btn">
                                <a class="btn btn-default" href="#" onclick="loadports('{$f.id}', 'NIC', this);
                                        return false;"><span class="fa fa-download"></span> Load Ports</a>
                            </span>
                                </div>
                            {/if}
                        </div>

                    </div>
                    {/foreach}

                    </div>
                </div>

                </div>

        {/if}


        <div class="text-center" style="margin-bottom:20px;"><input type="submit" class="btn btn-success text-centered btn-lg" value="Save Changes" /></div>
        {securitytoken}
</form>


        {if $item.isblade=='1'}
            <!-- BLADE -->
            {include file="blade_servers.tpl"}
            <!-- BLADE END -->
        {/if}



        <div class="box box-primary  ">
            <div class="box-header">
                <h3 class="box-title">Admin notes <i class="fa fa-sticky-note-o pull-left"></i></h3>
            </div>
            <div class="box-body">
                <div>

                    {include file="`$template_path`_common/noteseditor.tpl"}

                </div>
            </div>
        </div>


    </div>
</div>

