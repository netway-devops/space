<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
<div class="colocationmanager">
    {if $do}
        <div class="row">
            <div class="col-sm-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb my-3 container-breadcrumb inside-breadcrumb">
                        <li class="breadcrumb-item ">
                            <a href="{$widget_url}">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</a>
                            {if !$tpl_name|strstr:'2019'}<span class="divider">/</span>{/if}
                        </li>
                        {if $do == 'show_rack'}
                            <li class="breadcrumb-item active">
                                <span style="cursor: pointer">{$rack.name}</span>
                            </li>
                        {elseif $do == 'show_item'}
                            <li class="breadcrumb-item">
                                <a href="{$widget_url}&do=show_rack&rack_id={$dedi_item.rack_id}">{$dedi_item.rack_name}</a>
                                {if !$tpl_name|strstr:'2019'}<span class="divider">/</span>{/if}
                            </li>
                            <li class="breadcrumb-item active">
                                <span style="cursor: pointer">{if $dedi_item.name }{$dedi_item.name}{else}{$dedi_item.category_name}{/if}</span>
                            </li>
                        {/if}
                    </ol>
                </nav>
            </div>
        </div>
        {if $do == 'show_rack'}
            <div class="row" id="rack_view">
                <div class="col-lg-12">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                        <tr>
                            <td colspan="2"></td>
                            <td colspan="3" class="rack-header" style="background: #5b5b5b;">
                                <span style="padding: 10px;">&nbsp;</span>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td valign="top" width="30">
                                <table class="rack-table" id="statuscol" cellpadding="0" cellspacing="0" width="20">
                                    <tbody>
                                    {foreach from=$rack.positions.Front item=i key=k}
                                        <tr>
                                            <td pos="{$k}"></td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </td>
                            <td valign="top" width="30">
                                <table class="rack-table rack-u-legend" id="rowcols" cellpadding="0" cellspacing="0" width="28">
                                    <tbody>
                                    {foreach from=$rack.positions.Front item=i key=k}
                                        <tr><td style="box-shadow: inset 0 -1px 0 0;">{math equation="x + 1" x=$k}U</td></tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </td>
                            <td valign="top" width="10"  style="background: #5b5b5b;">
                                <div class="rack-mount">
                                    <div class="rack-side rack-side-l">
                                        {foreach from=$rack.positions.Lside item=i key=k name=cols}
                                            {if $smarty.foreach.cols.index % $rack.units ==0}{if !$smarty.foreach.cols.first}</div>{/if}<div class="col-group">{/if}
                                            {if $i}
                                                <div style="width: 50px;">
                                                    <div class="lbl rackitem" data-id="{$i.id}" data-type="side" data-units="{$i.units}" style="padding:1px; z-index: 2; position: absolute; font-size: 9px; background: #000; color: #fff; opacity: 0.7; overflow: hidden; cursor: pointer;">
                                                        {if $i.label}{$i.label}{else}{if $i.name}{$i.name}{else}{$i.category_name}{/if}{/if}
                                                    </div>
                                                </div>
                                            {else}
                                                <div class="newitem" style="height: 24px;"></div>
                                            {/if}
                                        {/foreach}
                                    </div>
                                </div>
                            </td>
                            <td valign="top" width="200" style="background: #f6f8f9;">
                                <table class="rack-front" cellpadding="0" cellspacing="0">
                                    <tbody class="sortable" data-location="Front">
                                    {foreach from=$rack.positions.Front item=i key=k}
                                        {if $i}
                                            <tr class="have_items dragdrop" data-position="{$k}" data-units="{$i.units}" data-id="{$i.id}" data-depth="{$i.depth}" label="{$i.hash}">
                                                <td class="rack_{$i.units}u contains rack-row" id="item_{$i.id}" style="width:200px; position: absolute;">
                                                    <div class="rackitem server{$i.units}u default_1u"
                                                         data-position="{$i.position}"
                                                         data-units="{$i.units}"
                                                         data-id="{$i.id}"
                                                         data-depth="{$i.depth}"
                                                         style="z-index: 1; width: 200px; position: absolute; background-image: url({$moduledir}images/hardware/{$i.css[0]}); background-repeat: no-repeat; cursor: pointer;">
                                                        <div class="lbl" style="z-index: 2; position: absolute; font-size: 10px; background: #000; color: #fff; opacity: 0.7; padding: 1px;">
                                                            {if $i.label}{$i.label}{else}{if $i.name}{$i.name}{else}{$i.category_name}{/if}{/if}
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        {else}
                                            <tr data-position="{$k}" class="dragdrop" data-units="1">
                                                <td class="rack_1u canadd" style="min-width: 200px;">
                                                    <span>&nbsp;</span>
                                                </td>
                                            </tr>
                                        {/if}
                                    {/foreach}
                                    </tbody>
                                </table>
                            </td>
                            <td valign="top" width="10"  style="background: #5b5b5b;">
                                <div class="rack-mount">
                                    <div class="rack-side rack-side-r">
                                        {foreach from=$rack.positions.Rside item=i key=k name=cols}
                                            {if $smarty.foreach.cols.index % $rack.units ==0}{if !$smarty.foreach.cols.first}</div>{/if}<div class="col-group">{/if}
                                            {if $i}
                                                <div style="width: 50px;">
                                                    <div class="lbl rackitem" data-id="{$i.id}" data-type="side" data-units="{$i.units}" style="padding: 1px; z-index: 2; position: absolute; font-size: 9px; background: #000; color: #fff; opacity: 0.7; overflow: hidden; cursor: pointer;">
                                                        {if $i.label}{$i.label}{else}{if $i.name}{$i.name}{else}{$i.category_name}{/if}{/if}
                                                    </div>
                                                </div>
                                            {else}
                                                <div class="newitem"></div>
                                            {/if}
                                        {/foreach}
                                    </div>
                                </div>
                            </td>
                            <td valign="top" id="former" style="padding-left:10px">
                                <b>{$lang.dedimgr_0U_devices}:</b>
                                <div style="width:200px; margin-bottom:10px; background: #f6f8f9;">
                                    <table class="rack-front" cellpadding="0" cellspacing="0">
                                        <tbody data-location="Zero">
                                        {foreach from=$rack.positions.Zero item=i key=k}
                                            {if $i}
                                                <tr class="have_items dragdrop" data-position="{$k}" data-units="{$i.units}" data-id="{$i.id}" data-depth="{$i.depth}" label="{$i.hash}">
                                                    <td class="rack_{$i.units}u contains rack-row" id="item_{$i.id}" style="position: absolute;">
                                                        <div class="rackitem server{$i.units}u default_1u"
                                                             data-position="{$i.position}"
                                                             data-units="{$i.units}"
                                                             data-id="{$i.id}"
                                                             data-depth="{$i.depth}"
                                                             style="z-index: 1; width: 200px; position: absolute; background-image: url({$moduledir}images/hardware/{$i.css[0]}); background-repeat: no-repeat; cursor: pointer;">
                                                            <div class="lbl" style="padding:1px; z-index: 2; position: absolute; font-size: 10px; background: #000; color: #fff; opacity: 0.7;">{if $i.label}{$i.label}{else}{if $i.name}{$i.name}{else}{$i.category_name}{/if}{/if}</div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            {else}
                                                <tr data-position="{$k}" class="dragdrop" data-units="1">
                                                    <td class="rack_1u canadd" style="min-width: 200px; box-shadow: inset 0 -1px 0 0;">
                                                        <span style="padding: 10px;">&nbsp;</span>
                                                    </td>
                                                </tr>
                                            {/if}
                                        {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                            <td class="rack-floor" colspan="3" align="center" style="background: none repeat scroll 0 0 #5b5b5b;">
                                <h3 style="color: #ffffff; padding: 10px;">{$lang.dedimgr_rack}: {$rack.name}</h3>
                            </td>
                            <td style="padding-left:20px" valign="top"><a href="{$widget_url}" class="btn btn-primary">{$lang.back}</a></td>
                        </tr>
                    </table>
                </div>
            </div>
        {elseif $do == 'show_item'}
            <div class="wbox">
                <div class="wbox_header">{$dedi_item.category_name}{if $dedi_item.name} - {$dedi_item.name}{/if}</div>
                <div  class="wbox_content">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped">
                        <tbody>
                        <tr>
                            <td width="250">{$lang.dedimgr_position}:</td>
                            <td>
                                <strong>
                                    {if $dedi_item.units > 1}{math equation="x + 2 - y" x=$dedi_item.position y=$dedi_item.units} U - {/if}
                                    {math equation="x + 1" x=$dedi_item.position} U
                                </strong>
                            </td>
                        </tr>
                        <tr>
                            <td width="250">{$lang.dedimgr_mount}:</td>
                            <td><strong>{if $lang[$dedi_item.location]}{$lang[$dedi_item.location]}{else}{$dedi_item.location}{/if}</strong></td>
                        </tr>
                        <tr>
                            <td width="250">{$lang.dedimgr_hostname}:</td>
                            <td><strong>{if $dedi_item.label}{$dedi_item.label}{else}-{/if}</strong></td>
                        </tr>
                        <tr>
                            <td width="250">{$lang.dedimgr_vendor}:</td>
                            <td><strong>{if $dedi_item.vendor_name}{$dedi_item.vendor_name}{else}-{/if}</strong></td>
                        </tr>
                        {if $dedi_item.account_id && $relatedacc}
                            <tr>
                                <td width="250">{$lang.relatedservice}:</td>
                                <td><strong>{$relatedacc}</strong></td>
                            </tr>
                        {/if}
                        {if $dedi_item.pool_id && $pool}
                            <tr>
                                <td width="250">{$lang.dedimgr_server_pool}:</td>
                                <td><strong>{$pool.name}</strong></td>
                            </tr>
                        {/if}
                        {foreach from=$dedi_item.fields item=field}
                            {if $field.options & 4}
                                <tr>
                                    <td width="250">{if $lang[$field.name]}{$lang[$field.name]}{else}{$field.name}{/if}:</td>
                                    <td><strong>{if $field.value}{$field.value}{else}-{/if}</strong></td>
                                </tr>
                            {/if}
                        {/foreach}
                        </tbody>
                    </table>
                    <div style="float: right;"><a href="{$widget_url}&do=show_rack&rack_id={$dedi_item.rack_id}" class="btn btn-primary">{$lang.back}</a></div>
                    <div style="clear: both;"></div>
                </div>
            </div>
        {/if}
    {else}
        <div class="table-responsive table-borders table-radius">
            <table class="table table-bordered stackable table-hover">
                <thead>
                <tr>
                    <th>{$lang.dedimgr_rack}</th>
                    <th>{$lang.dedimgr_room}</th>
                    <th>{$lang.dedimgr_floor}</th>
                    <th>{$lang.dedimgr_colocation}</th>
                </tr>
                </thead>
                <tbody>
                {if $racks}
                    {foreach from=$racks item=rack}
                        <tr>
                            <td><a href="{$widget_url}&do=show_rack&rack_id={$rack.id}">{$rack.name} {$rack.units}U</a></td>
                            <td>{$rack.room}</td>
                            <td>{$rack.floorname}</td>
                            <td>{$rack.coloname}</td>
                        </tr>
                    {/foreach}
                {else}
                    <tr>
                        <td colspan="4" class="text-center">{$lang.nothing}</td>
                    </tr>
                {/if}
                </tbody>
            </table>
        </div>
    {/if}
</div>
{literal}
<script>
    $(function () {
        $('.colocationmanager').closest('.account-content').css('width', '100%').removeClass('account-content');

        $('.rackitem').each(function () {
            var unit = $(this).data('units'),
                h = $('#rowcols tr').last().height(),
                w = $('.rack-front').width(),
                n = (unit * h);

            if ($(this).data('type') === 'side') {
                w = $('.rack-side').width();
            }

            $(this).css('height', n + 'px')
                .css('width', w + 'px')
                .css('background-size', w + 'px ' + n +'px');
            $(this).parents('tr').first()
                .height(h)
                .width(w);

            $(this).on('click', function () {
                var id = $(this).data('id');
                window.location.replace("{/literal}{$widget_url}&do=show_item&item_id={literal}" + id);
            });
        });

        $('.rack-front tr, .newitem').each(function () {
            var h = $('#rowcols tr').last().height();
            $(this).css('height', h);
        })
    });
</script>
{/literal}