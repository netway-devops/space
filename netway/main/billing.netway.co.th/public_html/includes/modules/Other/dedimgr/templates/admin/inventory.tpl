{if $part=='itemconfig'}
    <div>
        <b>{$item.name}</b>
    </div>
    <br>
    <form action="" method="post" class="table-vtop">
        <table cellspacing="0" cellpadding="3">
            <tbody>
                <tr>
                    <td colspan="2" width="70%"><h3>General attributes</h3></td>
                    <td rowspan="9"><img src="../includes/modules/Other/dedimgr/templates/admin/images/server1u_3d.png" style="margin: 0 10px"/></td>
                    <td width="30%"><h3>Additional attributes</h3></td>
                </tr>
                <tr>
                    <td width="10%"> Item name: </td>
                    <td width="60%"><input type="text" value="{if $item.name}{$item.name}{else}{/if}" name="name" class="inp"  size="50" /></td>
                    <td rowspan="8" >
                        {if $ftypes}
                            <select name="x" class="inp" id="new_additional_{$item.id}_select">
                                {if $ftypes}
                                    <optgroup label="Fields" id="new_additional_{$item.id}_group">
                                        {foreach from=$ftypes item=field}
                                            <option value="{$field.id}">{$field.name}</option>
                                        {/foreach}
                                    </optgroup>
                                {/if}
                                {if $ftypescat}
                                    <optgroup label="Categories">
                                        {foreach from=$ftypescat item=field}
                                            <option value="{foreach from=$field.fields item=name}{$name};{/foreach}" data="">{$field.name}</option>
                                        {/foreach}
                                    </optgroup>
                                {/if}
                            </select>
                            <input type="button" value="Assign" onclick="assignnew('#new_additional_{$item.id}');
                                    return false;" />
                        {/if}

                        <div id="new_additional_{$item.id}" class="additional-fields">
                            {if $item}
                                {foreach from=$item.fields item=f}
                                    <div class="additional-field">
                                        <span>
                                            <a href='#' class="menuitm menu-auto sort-handle" ><span class="movesth"></span> </a>
                                            <a href='#' class="menuitm menu-auto" onclick='return remaddopt(this);'><span class="delsth"></span></a>
                                        </span>
                                        <input type='hidden' name='fields[]' value='{$f.id}'/>

                                        {$f.name} 

                                    </div>
                                {/foreach}
                            {/if}
                        </div>

                    </td>
                </tr>
                <tr>
                    <td> Size:</td>
                    <td> 
                        <input type="number" step="1" value="{if $item.units}{$item.units}{else}1{/if}" name="units" class="inp u-size" size="4" />
                        <span class="mount_ mount_Front" {if $item.orientation!='Front'}style="display:none"{/if}>U</span> 
                        <span class="mount_ mount_Side" {if $item.orientation!='Side'}style="display:none"{/if}>U span</span>
                    </td>
                </tr>
                <tr>
                    <td> Orientation:</td>
                    <td> 
                        <select name="orientation" class="inp mount_type">
                            <option {if $item.orientation=='Front'}selected="selected"{/if}>Front</option>
                            <option {if $item.orientation=='Side'}selected="selected"{/if}>Side</option>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td> Current:</td>
                    <td> <input type="text" value="{if $item.current}{$item.current}{else}0.00{/if}" name="current" class="inp" size="4" /> Amps </td>
                </tr>
                <tr>
                    <td> Power:</td>
                    <td> <input type="text" value="{if $item.power}{$item.power}{else}0.00{/if}" name="power" class="inp" size="4" /> W</td>
                </tr>
                <tr>
                    <td> Weight: </td>
                    <td><input type="text" value="{if $item.weight}{$item.weight}{else}1.00{/if}" name="weight" class="inp" size="4" /> lbs</td>
                </tr>
                <tr>
                    <td> Monthly price:</td>
                    <td> <input type="text" value="{if $item.monthly_price}{$item.monthly_price|price:$currency:false}{else}{0.00|price:$currency:false}{/if}" name="monthly_price" class="inp" size="4" /> {$currency.code}</td>
                </tr>
                <tr>
                    <td> Vendor:</td>
                    <td> 
                        <select class="inp" name="vendor_id">
                            {foreach from=$vendors item=v}
                                <option value="{$v.id}" {if $item.vendor_id==$v.id}selected="selected"{/if}>{$v.name}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td> Depth:</td>
                    <td>
                        <select name="depth" class="inp">
                            <option {if $item.depth=='1'}selected="selected"{/if}>1</option>
                            <option {if $item.depth=='1/2'}selected="selected"{/if}>1/2</option>
                            <option {if $item.depth=='1/4'}selected="selected"{/if}>1/4</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td> Ports:</td>
                    <td>
                        <table>
                            <tr>
                                <td> Network ports:</td>
                                <td>
                                    <input type="number" min="0" max="64" step="1" value="{if $item.ports.nic_in}{$item.ports.nic_in}{else}0{/if}" name="ports[nic_in]" class="inp" size="2" />
                                </td>
                            </tr>
                            <tr>
                                <td> Uplink ports:</td>
                                <td>
                                    <input type="number" min="0" max="4" step="1" value="{if $item.ports.nic_out}{$item.ports.nic_out}{else}0{/if}" name="ports[nic_out]" class="inp" size="2" />
                                </td>
                            </tr>
                            <tr>
                                <td> In power sockets:</td>
                                <td>
                                    <input type="number" min="0" max="4" step="1" value="{if $item.ports.pdu_in}{$item.ports.pdu_in}{else}0{/if}" name="ports[pdu_in]" class="inp" size="2" />
                                </td>
                            </tr>
                            <tr>
                                <td> Out power sockets (for PDU devices):</td>
                                <td>
                                    <input type="number" min="0" max="64" step="1" value="{if $item.ports.pdu_out}{$item.ports.pdu_out}{else}0{/if}" name="ports[pdu_out]" class="inp" size="2" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        Icon Front :
                        <br>
                        <a href="#" class="" onclick="$('.vtip_item_size_front').fadeToggle('fast', 'linear');return false;">How-to</a>
                    </td>
                    <td colspan="3">
                        <span style="display: none;" class="vtip_item_size_front">
                            <span class="vtip_item_size ">
                                You can set any icons for this item
                                <br>
                                <b>Path:</b> {$moduledir}images/hardware/{$item.css[0]}
                                <br>
                                <b>Recommended size:</b> <span>200px</span> * <span class="vtip_height">20px</span>
                            </span>
                            <br>
                            <br>
                        </span>
                        {include file='class_selector.tpl' css=$item.css[0]}
                        <div class="preview">
                            <table cellspacing="0" cellpadding="0">
                                <tr  class="have_items dragdrop">
                                    <td  class=" contains">
                                        <div class="im_del"></div>
                                        <div class="rackitem server{$item.units}u default_1u" {if $item.css[0]}style="background-image: url({$moduledir}images/hardware/{$item.css[0]})"{/if}>
                                            <div class="lbl">Preview</div>
                                        </div>
                                        <div class="im_edit"></div>
                                        <div class="im_sorthandle"></div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        Icon Rear:
                        <br>
                        <a href="#" class="" onclick="$('.vtip_item_size_rear').fadeToggle('fast', 'linear');return false;">How-to</a>
                    </td>
                    <td colspan="3">
                        <span style="display: none;" class="vtip_item_size_rear">
                            <span class="vtip_item_size ">
                                You can set any icons for this item
                                <br>
                                <b>Path:</b> {$moduledir}images/hardware/{$item.css[1]}
                                    <br>
                                <b>Recommended size:</b> <span>200px</span> * <span class="vtip_height">20px</span>
                            </span>
                            <br>
                            <br>
                        </span>
                        {include file='class_selector.tpl' css=$item.css[1]}
                        <div class="preview">
                            <table cellspacing="0" cellpadding="0">
                                <tr  class="have_items dragdrop">
                                    <td  class=" contains">
                                        <div class="im_del"></div>
                                        <div class="rackitem server{$item.units}u default_1u" {if $item.css[1]}style="background-image: url({$moduledir}images/hardware/{$item.css[1]})"{/if}>
                                            <div class="lbl">Preview</div>
                                        </div>
                                        <div class="im_edit"></div>
                                        <div class="im_sorthandle"></div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        {if $item.id}
                            <input type="hidden" name="make" value="edititem">
                            <input type="hidden" name="id" value="{$item.id}">
                            <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Save Changes">
                        {else}
                            <input type="hidden" name="make" value="additem">
                            <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Add this item">
                        {/if}
                        <span class="orspace">Or</span> 
                        <a class="editbtn" onclick="return toggleTypeEdit('{$item.id}');" href="#">Cancel</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
{elseif !$subdo}
    {if $categories}
        <div id="listform">
            <div id="serializeit">
                <table class="inventory-list" id="grab-sorter" >
                    <tbody>
                        {foreach from=$categories item=category}
                            <tr>
                                <td>
                                    <a title="Edit" class="menuitm menu-auto" href="#" onclick="return editCategory('{$category.id}')"><span class="editsth"></span></a>
                                    <a onclick="return confirm('Are you sure you want to remove this category? This will remove all items from it')" title="delete" class="menuitm menu-auto"
                                       href="?cmd=dedimgr&do=inventory&make=removecat&id={$category.id}"><span class="delsth"></span></a>
                                </td>
                                <td>
                                    <a href="?cmd=dedimgr&do=inventory&subdo=category&category_id={$category.id}"><b>{$category.name}</b></a>
                                </td>

                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {else}
        No item categories found
    {/if}
    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();
                return false;" class="new_control" href="#">
            <span class="addsth"><strong>Add new category</strong></span>
        </a>
    </div>
    <div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory"><form action="" method="post">
            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                <tbody>
                    <tr>
                        <td>
                            Category name: <input type="text" value="" name="name" class="inp"/>
                        </td>
                        <td>
                            <input type="hidden" name="make" value="addcat">
                            <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Add category">
                            <span class="orspace">Or</span> 
                            <a class="editbtn" onclick="$('#addcategory').hide();
                                    return false;" href="#">Cancel</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
{elseif $subdo=='rackfields'}
    {include file='rackfields.tpl'}
{elseif $subdo=='category'}
    <script type="text/javascript">
        var hardwareurl = '{$moduledir}images/hardware/';
    </script>
    <script src="{$template_dir}js/fileupload/vendor/jquery.ui.widget.js"></script>
    <script src="{$template_dir}js/fileupload/jquery.iframe-transport.js"></script>
    <script src="{$template_dir}js/fileupload/jquery.fileupload.js"></script>
    <script src="{$moduledir}js/inventory.js"></script>
    <h3>Category: {$category.name}</h3><br />

    {if $items}
        <div id="listform">
            <div id="serializeit">
                <table class="inventory-list inventory-list-tdetails" id="grab-sorter" >
                    <tbody>
                        {foreach from=$items item=item}
                            <tr>
                                <td>
                                    <a onclick="return toggleTypeEdit('{$item.id}', this);" title="Edit" class="menuitm menu-auto" href="#"><span class="editsth"></span></a>
                                    <a title="Duplicate" class="menuitm menu-auto"
                                       href="?cmd=dedimgr&do=inventory&subdo=category&category_id={$category.id}&make=duplicate&id={$item.id}">
                                        <span class="duplicatesth"></span>
                                    </a>
                                    <a onclick="return confirm('Are you sure you want to remove this item? It will be also removed from all racks!.')" title="delete" class="menuitm  menu-auto"
                                       href="?cmd=dedimgr&do=inventory&subdo=category&category_id={$category.id}&make=removeitem&id={$item.id}"><span class="delsth"></span></a>
                                </td>
                                <td>
                                    <div id="fname_{$item.id}"><b>{$item.name}</b></div>
                                    <div id="fform_{$item.id}" {if $expand_id!=$item.id}style="display:none"{/if}>
                                        {include file="inventory.tpl" part='itemconfig'}
                                    </div>
                                </td>
                                {if $item.css}
                                    {foreach from=$item.css item=img key=id}
                                        <td>
                                            <b>{if $id == 0}Front{else}Back{/if}:</b> <img src="{$moduledir}images/hardware/{$img}" width="200">
                                        </td>
                                    {/foreach}
                                {/if}
                                <td>
                                    Size:  {$item.units} U<br/>
                                    Current:   {$item.current} Amps<br/>
                                    Power:   {$item.power} W<br/>
                                    Weight:   {$item.weight} lbs
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {else}
        No items has been added yet.
    {/if}
    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" onclick="return toggleTypeEdit('');" class="new_control" href="#">
            <span class="addsth"><strong>Define new item in {$category.name}</strong></span>
        </a>
    </div>
    <div class="p6" style="margin-bottom: 15px;display:none;" id="fform_">
        {include file="inventory.tpl" part='itemconfig' item=''}
    </div>
{elseif $subdo=='fieldtypes'}
    <script src="{$moduledir}js/inventory.js"></script>
    {if $ftypes}
        <div id="listform">
            <div id="serializeit">
                <table class="inventory-list inventory-list-tdetails" id="grab-sorter" >
                    <tbody>
                        {foreach from=$ftypes item=field}
                            {*check if it is Switch_app or PDU_app*}
                            {if $field.id == 12 || $field.id == 13}
                                <tr>
                                    <td>
                                        <a onclick="return toggleTypeEdit('{$field.id}', this)" title="Edit" class="menuitm menu-auto" href="#"><span class="editsth"></span></a>
                                    </td>
                                    <td>
                                        <div id="fname_{$field.id}">{$field.name}</div>
                                        <div id="fform_{$field.id}" style="display:none" class="fform_labels">
                                            <form action="" method="post">
                                                <label>
                                                    <span class="l">Field name:</span><input type="text" value="{$field.name}" name="name" class="inp"/>
                                                </label>
                                                <input type="hidden" name="make" value="editfield">
                                                <input type="hidden" name="id" value="{$field.id}">

                                                <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Save">
                                                <span class="orspace">Or</span>
                                                <a class="editbtn" onclick="return toggleTypeEdit('{$field.id}')" href="#">Cancel</a>
                                            </form>
                                        </div>
                                    </td>
                                    <td>
                                        Type: {$ftt[$field.field_type]}
                                    </td>
                                </tr>
                            {else}
                                <tr>
                                    <td>
                                        <a onclick="return toggleTypeEdit('{$field.id}', this)" title="Edit" class="menuitm menu-auto" href="#"><span class="editsth"></span></a>
                                        <a onclick="return confirm('Are you sure you want to remove this field type? It will be removed from all items that uses it.')"
                                           title="delete" class="menuitm  menu-auto" href="?cmd=dedimgr&do=inventory&subdo=fieldtypes&make=removefield&id={$field.id}">
                                            <span class="delsth"></span>
                                        </a>

                                    </td>
                                    <td>
                                        <div id="fname_{$field.id}">{$field.name}</div>
                                        <div id="fform_{$field.id}" style="display:none" class="fform_labels">
                                            <form action="" method="post">
                                                <label>
                                                    <span class="l">Field name:</span><input type="text" value="{$field.name}" name="name" class="inp"/>
                                                </label>
                                                <label>
                                                    <span class="l">Type:</span> <select name="field_type" class="inp">
                                                        <option value="input" {if $field.field_type=='input'}selected="selected"{/if}>Text input</option>
                                                        <option value="text" {if $field.field_type=='text'}selected="selected"{/if}>Non-editable text</option>
                                                        <option value="select" {if $field.field_type=='select'}selected="selected"{/if}>Dropdown box</option>
                                                        <option value="switch_app" {if $field.field_type=='switch_app'}selected="selected"{/if}>Switch App</option>
                                                        <option value="pdu_app" {if $field.field_type=='pdu_app'}selected="selected"{/if}>PDU App</option>
                                                    </select>
                                                </label>
                                                <label>
                                                    <span class="l">Default value:</span> <input type="text" value="{$field.default_value}" name="default_value" class="inp" size="40" />
                                                </label>
                                                <label>
                                                    <span class="l">Searchable: </span>
                                                    <a href="#" class=" vtip_description" title="Enables you to search items by this field"></a>
                                                    <input type="checkbox" value="1" name="options[1]" {if $field.options & 1}checked="checked"{/if} style="vertical-align: middle;" />
                                                </label>
                                                <label>
                                                    <span class="l">Encrypted:</span>
                                                    <a href="#" class=" vtip_description" title="Encrypts entered data in database"></a>
                                                    <input type="checkbox" value="2" name="options[2]" {if $field.options & 2}checked="checked"{/if} style="vertical-align: middle;" />
                                                </label>
                                                <label>
                                                    <span class="l">Visible in client portal:</span>
                                                    <a href="#" class=" vtip_description" title="After checking, the client will be able to see this field in the item view in clientarea"></a>
                                                    <input type="checkbox" value="4" name="options[4]" {if $field.options & 4}checked="checked"{/if} style="vertical-align: middle;" />
                                                </label>
                                                <input type="hidden" name="make" value="editfield">
                                                <input type="hidden" name="id" value="{$field.id}">

                                                <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Save">
                                                <span class="orspace">Or</span>
                                                <a class="editbtn" onclick="return toggleTypeEdit('{$field.id}')" href="#">Cancel</a>
                                            </form>
                                        </div>
                                    </td>
                                    <td>
                                        Type: {$ftt[$field.field_type]}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {else}
        No fields found
    {/if}
    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();
                return false;" class="new_control" href="#"><span class="addsth"><strong>Define new field</strong></span></a>
    </div>
    <div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory"><form action="" method="post">
            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                <tbody><tr>
                        <td>
                            Field name: <input type="text" value="" name="name" class="inp"/>
                        </td>

                        <td>
                            Type: <select name="field_type" class="inp">
                                <option value="input">Text input</option>
                                <option value="text">Non-editable text</option>
                                <option value="select">Drop down box</option>
                                <option value="switch_app" >Switch App</option>
                                <option value="pdu_app" >PDU App</option>
                            </select>
                        </td>
                        <td>
                            Default value: <input type="text" value="" name="default_value" class="inp" size="40" />

                        </td>
                        <td>
                            <input type="hidden" name="make" value="addfield">
                            <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Add new field">
                            <span class="orspace">Or</span> <a class="editbtn" onclick="$('#addcategory').hide();
                                    return false;" href="#">Cancel</a>
                        </td>
                    </tr>
                </tbody></table>
        </form></div>
    <small>
        Note: Item fields are displayed on rack items. You can define different types of fields - ones that are editable, like "server name", and ones that are just displayed.<br>
        For dropdown boxes separate values with comma ","

    </small>
{elseif $subdo=='fieldtypescat'}
    <script src="{$moduledir}js/inventory.js"></script>

    <div id="listform">
        <div id="serializeit">
            <table class="inventory-list inventory-list-tdetails" id="grab-sorter" >
                <tbody>
                    {foreach from=$ftypescat item=field}
                        <tr>
                            <td>
                                <a onclick="return toggleTypeEdit('{$field.id}', this)" title="Edit" class="menuitm menu-auto" href="#">
                                    <span class="editsth"></span> 
                                </a>
                                <a onclick="return confirm('Are you sure you want to remove this field category? ')" title="delete" class="menuitm  menu-auto"
                                   href="?cmd=dedimgr&do=inventory&subdo=fieldtypescat&make=removefield&id={$field.id}">
                                    <span class="delsth"></span>
                                </a>

                            </td>
                            <td>
                                <div id="fname_{$field.id}">{$field.name}</div>
                                <div id="fform_{$field.id}" style="display:none">
                                    <form action="" method="post">
                                        <label>
                                            Category name: <input type="text" value="{$field.name}" name="name" class="inp"/>
                                        </label> &nbsp;
                                        <input type="hidden" name="make" value="editfield">
                                        <input type="hidden" name="id" value="{$field.id}">

                                        {if $ftypes}
                                            <br /><br />
                                            <label id="new_additional_{$field.id}_group">
                                                Category fields:
                                                <select name="x" class="inp" id="new_additional_{$field.id}_select">
                                                    {foreach from=$ftypes item=ffield}
                                                        <option value="{$ffield.id}">{$ffield.name}</option>
                                                    {/foreach}
                                                </select>
                                                <input type="button" value="Assign" onclick="assignnew('#new_additional_{$field.id}');
                                                        return false;" />

                                            </label>
                                        {/if}

                                        <div id="new_additional_{$field.id}" class="additional-fields fields-category">
                                            {foreach from=$field.fields item=ffield}
                                                {if $ftypes[$ffield]}
                                                    <div class="additional-field">
                                                        <span>
                                                            <a href='#' class="menuitm menu-auto sort-handle" ><span class="movesth"></span> 
                                                            </a>
                                                            <a href='#' class="menuitm menu-auto" onclick='return remaddopt(this);'><span class="delsth"></span></a>
                                                        </span>
                                                        <input type='hidden' name='fields[]' value='{$ftypes[$ffield].id}'/>
                                                        {$ftypes[$ffield].name} 
                                                    </div>
                                                {/if}
                                            {/foreach}
                                        </div>
                                        <br /><br />
                                        <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Save">
                                        <span class="orspace">Or</span> 
                                        <a class="editbtn" onclick="return toggleTypeEdit('{$field.id}')" href="#">Cancel</a>
                                    </form>
                                </div>
                            </td>
                            <td>
                                <strong>Fields: </strong>
                                {foreach from=$ftypes item=ffield}
                                    {if in_array($ffield.id, $field.fields)}
                                        {$ffield.name},
                                    {/if}
                                {/foreach}
                            </td>
                        </tr>
                    {foreachelse}
                        <tr>
                            <td style="text-align: center; font-size: 12px; line-height: 30px;">

                                Nothing to display

                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>

    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();
                return false;" class="new_control" href="#">
            <span class="addsth">
                <strong>Define new field category</strong>
            </span>
        </a>
    </div>
    <div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory">
        <form action="" method="post">
            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                <tbody>
                    <tr>
                        <td>
                            Category name: <input type="text" value="" name="name" class="inp"/>
                        </td>
                        <td>
                            <input type="hidden" name="make" value="addfield">
                            <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Add new category">
                            <span class="orspace">Or</span> <a class="editbtn" onclick="$('#addcategory').hide();
                                    return false;" href="#">Cancel</a>
                        </td>
                    </tr>
                </tbody></table>
        </form></div>
    <small>
        Note: Item fields are displayed on rack items. You can define different types of fields - ones that are editable, like "server name", and ones that are just displayed.<br>
        For dropdown boxes separate values with comma ","

    </small>
{else}


{/if}