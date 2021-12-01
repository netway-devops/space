<table border="0" cellpadding="0" cellspacing="0" width="100%" id="rack_view">
    <tr>
        <td colspan="2"></td>
        <td colspan="3" class="text-center"><label style="font-size: 15px;">{$name}</label></td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td colspan="3" height="32" class="rack-header"></td>
        <td></td>
    </tr>
    <tr>
        <td valign="top" width="30">
            <table class="rack-table" id="" cellpadding="0" cellspacing="0" width="20">
                <tbody>
                {foreach from=$rack.positions[$loc] item=i key=k}
                    <tr>
                        <td pos="{$k}"></td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="30">
            <table class="rack-table rack-u-legend" id="rowcols_{$locclass}" cellpadding="0" cellspacing="0" width="28">
                <tbody>
                {foreach from=$rack.positions[$loc] item=i key=k}
                    <tr><td>{math equation="x + 1" x=$k}U</td></tr>
                {/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="1" ></td>
        <td valign="top" width="200" style="background: linear-gradient(-45deg, #f6f8f9 0%, #e5ebee 50%, #d7dee3 51%, #f5f7f9 100%);">
            <table class="rack-{$locclass}" cellpadding="0" cellspacing="0" width="200">
                <tbody class="sortable" data-location="{$loc}">
                {foreach from=$rack.positions[$loc] item=i key=k}
                    {assign var=front value=$rack.positions.Front[$k]}
                    {if $i}
                        <tr class="have_items dragdrop" data-position="{$k}" data-units="{$i.units}" data-id="{$i.id}" label="{$i.hash}">
                            <td class="rack_{$i.units}u contains rack-row" id="item_{$i.id}" >
                                {include file="rack_item.tpl" orientation=0}
                            </td>
                        </tr>
                    {elseif $front.depth == '1' && $front.css[1] && $loc == 'Back'}
                        <tr class="have_items static dragdrop" data-position="{$k}" data-units="{$front.units}" data-id="{$front.id}" data-front="{$front.id}" label="{$front.hash}">
                            <td class="rack_{$front.units}u contains rack-row" id="item_{$front.id}" >
                                {assign var=i value=$front}
                                {include file="rack_item.tpl" orientation=1}
                            </td>
                        </tr>
                    {elseif is_null($i)}
                        {if !$front.units}
                            {assign var=block value=$rack.positions.Side[$k]}
                        {else}
                            {assign var=block value=$front}
                        {/if}
                        <tr data-position="{$k}" class="dragdrop static" data-units="{$block.units}" data-id="{$block.id}" data-original="{$k}">
                            <td class="rack_{$block.units}u rack-row" height="20" style="background: none">
                                <div class="rackitem server{$block.units}u" data-units="{$block.units}"></div>
                            </td>
                        </tr>
                    {else}
                        <tr data-position="{$k}" class="dragdrop" data-units="1">
                            <td class="rack_1u canadd" height="20">
                                <a class="newitem" href="#" style="height: 15px;">Add new item</a>
                            </td>
                        </tr>
                    {/if}
                {/foreach}
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2"></td>
        <td class="rack-floor" colspan="3" align="center">
            <h3>Rack: {$rack.name}</h3>
        </td>
        <td style="padding-left:20px" valign="top"></td>
    </tr>
</table>

