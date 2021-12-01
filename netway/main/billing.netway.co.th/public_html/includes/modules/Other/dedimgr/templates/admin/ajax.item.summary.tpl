<input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
<input type="hidden" name="id" value="{$item.id}" id="item_id"/>
<div class="row no-gutter">
    <div class="col-md-3 mainleftcol">

        <div class="box ">
            <div class="box-header">
                <h3 class="box-title">Location</h3>

            </div>
            <div class="box-body">
                <table cellspacing="5" cellpadding="5" width="100%" class="table table-striped" >
                    <tbody>
                    <tr>
                        <td width="150">Position:</td>
                        <td><strong>{$item.position} U</strong></td>
                    </tr>
                    <tr>
                        <td width="150">Mount:</td>
                        <td><strong>{if $item.location == "Zero"}0 U{elseif $item.location == 'Rside'}Right{elseif $item.location == 'Lside'}Left{else}{$item.location}{/if}</strong></td>
                    </tr>
                    <tr>
                        <td width="150">Rack:</td>
                        <td><strong>{if $item.rack_id}<a href="?cmd=dedimgr&do=rack&rack_id={$item.rack_id}">{$item.rack_name}</a>{else}-{/if}</strong></td>
                    </tr>
                    <tr>
                        <td width="150">Floor:</td>
                        <td><strong>{if $item.floor_id}<a href="?cmd=dedimgr&do=floor&floor_id={$item.floor_id}">{$item.floor_name}</a>{else}-{/if}</strong></td>
                    </tr>
                    <tr>
                        <td width="150">Colocation:</td>
                        <td><strong>{if $item.colo_id}<a href="?cmd=dedimgr&do=floors&colo_id={$item.colo_id}">{$item.colo_name}</a>{else}-{/if}</strong></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>


        <div class="box  box-solid no-padding">
            <div class="box-header">
                <h3 class="box-title">Item Info</h3>

            </div>
            <div class="box-body">

                <table cellspacing="5" cellpadding="5" width="100%" class="table table-striped" >
                    <tbody>
                    <tr>
                        <td width="150">Category:</td>
                        <td><strong>{$item.category_name}</strong></td>
                    </tr>
                    <tr>
                        <td>Name:</td>
                        <td><strong>{$item.name}</strong></td>
                    </tr>
                    <tr>
                        <td>Size (H / D):</td>
                        <td>{$item.units} U <span style="margin: 3px;">/</span> {if $item.depth == '1'}1/1{else}{$item.depth}{/if}</td>
                    </tr>
                    <tr>
                        <td>Current:</td>
                        <td>{$item.current} Amps</td>
                    </tr>
                    <tr>
                        <td>Power:</td>
                        <td>{$item.power} W</td>
                    </tr>
                    <tr>
                        <td>Weight: </td>
                        <td>{$item.weight} lbs</td>
                    </tr>
                    <tr>
                        <td>Monthly price:</td>
                        <td>{$item.monthly_price} {$currency.code}</td>
                    </tr>
                    <tr>
                        <td>Vendor:</td>
                        <td>{$item.vendor_name}</td>
                    </tr>

                    </tbody>
                </table>
            </div>
            <div class="box-footer clearfix no-border">
                <a class="btn btn-success btn-xs pull-right" id="addnote" href="?cmd=dedimgr&do=inventory&subdo=category&category_id={$item.category_id}&item_id={$item.item_id}"
                   target="_blank" >Edit this item type</a>
            </div>
        </div>


        <div class="box ">
            <div class="box-header">
                <h3 class="box-title">QR Code</h3>

            </div>
            <div class="box-body text-center">

                <img src="?cmd=dedimgr&do=qr&id={$item.id}" />
            </div>
            <div class="box-footer clearfix no-border">
                <a class="btn btn-primary btn-xs pull-right" id="addnote" href="?cmd=dedimgr&do=qr&id={$item.id}" target="_blank" >Print</a>
            </div>
        </div>

    </div>


    <div class="col-md-9 mainrightcol">
        <div class="box  box-solid ">
            <div class="box-header">
                <h3 class="box-title">Basic Details</h3>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-3">

                        <dl>
                            <dt>Hostname / label</dt>
                            <dd>{if $item.label}{$item.label}{else}<em>None</em>{/if}</dd>
                        </dl>
                        <dl>
                            <dt>ID</dt>
                            <dd>{$item.id}</dd>
                        </dl>

                    </div>
                    <div class="col-md-3">


                        <dl>
                            <dt>Owner</dt>
                            <dd>{if $item.client_id}{linkto rel_type='Client' rel_id=$item.client_id}{else}<em>None</em>{/if}</dd>
                        </dl>


                        <dl>
                            <dt>Related service</dt>
                            <dd>{if $item.account_id}{linkto rel_type='Hosting' rel_id=$item.account_id}{else}<em>None</em>{/if}</dd>
                        </dl>

                    </div>
                    {if !$itsblade}
                    <div class="col-md-3">

                            <dl>
                                <dt>Parent device</dt>
                                <dd>{if $item.parent_id}<a href="?cmd=dedimgr&do=itemeditor&item_id={$item.parent_id}">#{$item.parent_id} {$parent.name} {$parent.label}</a>{else}<em>None</em>{/if}</dd>
                            </dl>
                            <dl>
                                <dt>Server pool</dt>
                                <dd>{if $item.pool_id}#{$item.pool_id} {$pool.name}{else}<em>None</em>{/if}</dd>
                            </dl>

                    </div>
                    {/if}

                    <div class="col-md-3">

                        <dl>
                            <dt>Admin description</dt>
                            <dd>{if $item.notes}{$item.notes}{else}<em>None</em>{/if}</dd>
                        </dl>
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
                        <dl >
                            <dt class="nodescr">{$f.name} </dt>
                            <dd>
                            {if $f.field_type=='input'}
                                {if $f.value}{$f.value}{else}<em>None</em>{/if}
                            {elseif $f.field_type=='text'}
                                {$f.value}
                            {elseif $f.field_type=='select'}
                                {foreach from=$f.default_value item=d}{if $f.value==$d}{$d}{/if}{/foreach}
                            {elseif $f.field_type=='pdu_app'}
                                {if $f.value=='0'}<em>None</em>{else}
                                    {foreach from=$pdu_apps item=d}{if $f.value==$d.id}<a href="?cmd=servers&action=edit&id={$d.id}" target="_blank" class="external">#{$d.id} {$d.groupname} - {$d.name}</a>{/if}{/foreach}
                                {/if}
                            {elseif $f.field_type=='switch_app'}
                                {if $f.value=='0'}<em>None</em>{else}
                                    {foreach from=$switch_apps item=d}{if $f.value==$d.id}<a href="?cmd=servers&action=edit&id={$d.id}" target="_blank" class="external">#{$d.id} {$d.groupname} - {$d.name}</a>{/if}{/foreach}
                                {/if}

                            {/if}
                            </dd>
                        </dl>

                    </div>
                    {/foreach}

                    </div>
                </div>

                </div>

        {/if}

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


        {graphs rel_id=$item.id rel_type='RackItem' featured=1}
    </div>
</div>
