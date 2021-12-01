{if !$subdo}
{if $categories}
<div id="listform">
    <div id="serializeit"><ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter" >
            {foreach from=$categories item=category}
            <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tbody><tr>
                                <td width="60" valign="top"><div style="padding:10px 0px;">
                                        <a style="width:14px;" title="Edit" class="menuitm menuf" href="#" onclick="return editCategory('{$category.id}')"><span class="editsth"></span></a><!--
                                --><a onclick="return confirm('Are you sure you want to remove this category? This will remove all items from it')" title="delete" class="menuitm menul"
                                           href="?cmd=module&module={$moduleid}&do=inventory&make=removecat&id={$category.id}"><span class="delsth"></span></a>
                                    </div></td>
                                <td>
                                    <a href="?cmd=module&module={$moduleid}&do=inventory&subdo=category&category_id={$category.id}"><b>{$category.name}</b></a>
                                </td>

                            </tr>
                        </tbody></table></div>
            </li>
            {/foreach}
        </ul>
    </div>
</div>
{else}
No item categories found
{/if}
<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();return false;" class="new_control" href="#"><span class="addsth"><strong>Add new category</strong></span></a>
</div>

<div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory"><form action="" method="post">
        <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
            <tbody><tr>
                    <td>
                        Category name: <input type="text" value="" name="name" class="inp"/>
                    </td>
                    <td>
                        <input type="hidden" name="make" value="addcat">
                        <input type="submit" style="font-weight:bold" value="Add category">
                        <span class="orspace">Or</span> <a class="editbtn" onclick="$('#addcategory').hide();return false;" href="#">Cancel</a>
                    </td>
                </tr>
            </tbody></table>
    </form></div>
{elseif $subdo=='category'}
<h3>Category: {$category.name}</h3>

{if $items}
<div id="listform">
    <div id="serializeit"><ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter" >
            {foreach from=$items item=item}
            <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tbody><tr>
                                <td width="60" valign="top"><div style="padding:10px 0px;">
                                        <a style="width:14px;" onclick="$('#fname_{$item.id}').hide();$('#fform_{$item.id}').show();return false" title="Edit" class="menuitm menuf" href="#"><span class="editsth"></span></a>
                                        <a onclick="return confirm('Are you sure you want to remove this item? It will be also removed from all racks!.')" title="delete" class="menuitm  menul"
                                           href="?cmd=module&module={$moduleid}&do=inventory&subdo=category&category_id={$category.id}&make=removeitem&id={$item.id}"><span class="delsth"></span></a>
                                    </div></td>
                                <td>
                                    <div id="fname_{$item.id}"><b>{$item.name}</b></div>
                                    <div id="fform_{$item.id}" {if $expand_id!=$item.id}style="display:none"{/if}>
                                         <form action="" method="post">
                                            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;" class="left">
                                                <tbody>
                                                    <tr><td colspan="2"><h3>General attributes</h3></td></tr>
                                                    <tr>
                                                        <td>
                                                            Item name: </td><td><input type="text" value="{$item.name}" name="name" class="inp"/>
                                                        </td></tr>
                                                    <tr><td>
                                                            Size:</td><td> <input type="text" value="{$item.units}" name="units" class="inp" size="2" /> U
                                                        </td></tr>
                                                    <tr><td>
                                                            Current:</td><td> <input type="text" value="{$item.current}" name="current" class="inp" size="2" /> Amps
                                                        </td></tr>
                                                    <tr><td>
                                                            Power:</td><td> <input type="text" value="{$item.power}" name="power" class="inp" size="2" /> W
                                                        </td></tr>
                                                    <tr><td>
                                                            Weight: </td><td><input type="text" value="{$item.weight}" name="weight" class="inp" size="2" /> lbs
                                                        </td></tr>
                                                    <tr><td>
                                                            Monthly price:</td><td> <input type="text" value="{$item.monthly_price}" name="monthly_price" class="inp" size="2" /> {$currency.code}
                                                        </td>
                                                    </tr>
                                                    <tr><td>
                                                            Vendor:</td><td> <select class="inp" name="vendor_id">{foreach from=$vendors item=v}<option value="{$v.id}" {if $item.vendor_id==$v.id}selected="selected"{/if}>{$v.name}</option>{/foreach}</select>
                                                        </td>
                                                    </tr><tr>
                                                        <td>Icon:</td>
                                                        <td>{include file='class_selector.tpl'} <div class="preview">
                                                                <table cellspacing="0" cellpadding="0" class="racker">
                                                                    <tr  class="have_items dragdrop"><td  class=" previever rack_1u contains">
                                                                            <div class="im_del"></div>
                                                                            <div class="rackitem {$item.css} server{$item.units}u"><div class="lbl">Preview</div></div>
                                                                            <div class="im_edit"></div>
                                                                            <div class="im_sorthandle"></div>
                                                                        </td></tr>
                                                                </table>
                                                            </div></td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="2">
                                                            <input type="hidden" name="make" value="edititem">
                                                            <input type="hidden" name="id" value="{$item.id}">

                                                            <input type="submit" style="font-weight:bold" value="Save Changes">
                                                            <span class="orspace">Or</span> <a class="editbtn" onclick="$('#fname_{$item.id}').show();$('#fform_{$item.id}').hide();return false;" href="#">Cancel</a>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            <div class="left" style="margin-left:40px">
                                                {if $ftypes}
                                                <h3 style="padding:3px 0px">Additional attributes</h3>
                                                <select name="x" class="inp" id="new_additional_{$item.id}_select">
                                                    {foreach from=$ftypes item=field}
                                                    <option value="{$field.id}">{$field.name}</option>
                                                    {/foreach}
                                                </select>
                                                <input type="button" value="Assign" onclick="assignnew('#new_additional_{$item.id}');return false;" />
                                                {/if}

                                                <div id="new_additional_{$item.id}">
                                                    {foreach from=$item.fields item=f}
                                                    <div style='padding:3px 5px'><input type='hidden' name='fields[]' value='{$f.id}'/>{$f.name} <span class='orspace'><a href='#' onclick='return remaddopt(this);'>Remove</a></span></div>
                                                    {/foreach}
                                                </div>
                                            </div>
                                            <div class="clear"></div>

                                        </form>
                                    </div>

                                </td>
                                <td valign="top" style="background:#F0F0F3;color:#767679;font-size:11px" width="150">
                                    Size:  {$item.units} U<br/>
                                    Current:   {$item.current} Amps<br/>
                                    Power:   {$item.power} W<br/>
                                    Weight:   {$item.weight} lbs
                                </td>
                            </tr>
                        </tbody></table></div>
            </li>
            {/foreach}
        </ul>
    </div>
</div>
{else}
No items has been added yet.
{/if}
<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();return false;" class="new_control" href="#"><span class="addsth"><strong>Define new item in {$category.name}</strong></span></a>
</div>
<div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory"><form action="" method="post">
        <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;" class="left">
            <tbody>
                <tr><td colspan="2"><h3>General attributes</h3></td></tr>
                <tr>
                    <td>
                        Item name: </td><td><input type="text" value="" name="name" class="inp"/>
                    </td></tr>
                <tr><td>
                        Size:</td><td> <input type="text" value="1" name="units" class="inp" size="2" /> U
                    </td></tr>
                <tr><td>
                        Current:</td><td> <input type="text" value="0.00" name="current" class="inp" size="2" /> Amps
                    </td></tr>
                <tr><td>
                        Power:</td><td> <input type="text" value="0.00" name="power" class="inp" size="2" /> W
                    </td></tr>
                <tr><td>
                        Weight: </td><td><input type="text" value="0.00" name="weight" class="inp" size="2" /> lbs
                    </td></tr>
                <tr><td>
                        Monthly price:</td><td> <input type="text" value="0.00" name="monthly_price" class="inp" size="2" /> {$currency.code}
                    </td></tr>
                 <tr><td>
                                                            Vendor:</td><td> <select class="inp" name="vendor_id">{foreach from=$vendors item=v}<option value="{$v.id}" {if $item.vendor_id==$v.id}selected="selected"{/if}>{$v.name}</option>{/foreach}</select>
                                                        </td>
                                                    </tr>
                <tr>
                    <td>Icon:</td>
                    <td>{include file='class_selector.tpl'} <div class="preview">
                            <table cellspacing="0" cellpadding="0" class="racker">
                                <tr  class="have_items dragdrop"><td  class=" previever rack_1u contains">
                                        <div class="im_del"></div>
                                        <div class="rackitem default_1u server1u"><div class="lbl">Preview</div></div>
                                        <div class="im_edit"></div>
                                        <div class="im_sorthandle"></div>
                                    </td></tr>
                            </table>
                        </div></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <input type="hidden" name="make" value="additem">
                        <input type="submit" style="font-weight:bold" value="Add this item">
                        <span class="orspace">Or</span> <a class="editbtn" onclick="$('#addcategory').hide();return false;" href="#">Cancel</a>
                    </td>
                </tr>
            </tbody></table>
        <img src="../includes/modules/Other/Dedimgr/admin/images/server1u_3d.png" style="margin:10px;float:left"/>
        <div class="left">
            {if $ftypes}
            <h3>Additional attributes</h3>
            <select name="x" class="inp" id="new_additional_select">
                {foreach from=$ftypes item=field}
                <option value="{$field.id}">{$field.name}</option>
                {/foreach}
            </select>
            <input type="button" value="Assign" onclick="assignnew('#new_additional');return false;" />
            {/if}

            <div id="new_additional">


            </div>
        </div>
        <div class="clear"></div>
    </form></div>
<script type="text/javascript">
    {literal}
    function change_css(select) {
        var p = $(select).parent().find('div.preview').find('.rackitem');
        var form = p.parents('form').eq(0);
        p.attr('class',"");
        p.addClass('rackitem');

        if($('input[name=units]',$(form)).length) {
            if($('input[name=units]',$(form)).val()) {
                p.addClass('server'+$('input[name=units]',$(form)).val()+'u');
            } else {
                p.addClass('server1u');
            }
        }
        p.addClass($(select).val());
        return false;

    }
    function assignnew(target) {
        var id = $(target+'_select').val();
        var n= $(target+'_select option:selected').text();
        $(target).append("<div style='padding:3px 5px'><input type='hidden' name='fields[]' value='"+id+"'/>"+n+" <span class='orspace'><a href='#' onclick='return remaddopt(this);'>Remove</a></span></div>");
        return false;
    }

    function assignnew_current(it) {

    }

    function remaddopt(el) {
        $(el).parents('div').eq(0).remove();
        return false;
    }
    {/literal}

</script>

{elseif $subdo=='fieldtypes'}

{if $ftypes}
<div id="listform">
    <div id="serializeit"><ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter" >
            {foreach from=$ftypes item=field}
            <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tbody><tr>
                                <td width="60" valign="top"><div style="padding:10px 0px;">
                                        <a style="width:14px;" onclick="$('#fname_{$field.id}').hide();$('#fform_{$field.id}').show();return false" title="Edit" class="menuitm menuf" href="#"><span class="editsth"></span></a><!--
                                        --><a onclick="return confirm('Are you sure you want to remove this field type? It will be removed from all items that uses it.')" title="delete" class="menuitm  menul"
                                           href="?cmd=module&module={$moduleid}&do=inventory&subdo=fieldtypes&make=removefield&id={$field.id}"><span class="delsth"></span></a>
                                    </div></td>
                                <td>
                                    <div id="fname_{$field.id}">{$field.name}</div>
                                    <div id="fform_{$field.id}" style="display:none"><form action="" method="post">
                                            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                                                <tbody><tr>
                                                        <td>
                                                            Field name: <input type="text" value="{$field.name}" name="name" class="inp"/>
                                                        </td>

                                                        <td>
                                                            Type: <select name="field_type" class="inp">
                                                                <option value="input" {if $field.field_type=='input'}selected="selected"{/if}>Text input</option>
                                                                <option value="text" {if $field.field_type=='text'}selected="selected"{/if}>Non-editable text</option>
                                                                <option value="select" {if $field.field_type=='select'}selected="selected"{/if}>Dropdown box</option>
                                                                <option value="switch_app" {if $field.field_type=='switch_app'}selected="selected"{/if}>Switch App</option>
                                                                <option value="pdu_app" {if $field.field_type=='pdu_app'}selected="selected"{/if}>PDU App</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            Default value: <input type="text" value="{$field.default_value}" name="default_value" class="inp" size="40" />

                                                        </td>
                                                        <td>
                                                            <input type="hidden" name="make" value="editfield">
                                                            <input type="hidden" name="id" value="{$field.id}">
                                                            <input type="submit" style="font-weight:bold" value="Save">
                                                            <span class="orspace">Or</span> <a class="editbtn" onclick="$('#fname_{$field.id}').show();$('#fform_{$field.id}').hide();return false;" href="#">Cancel</a>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                        </form>
                                    </div>

                                </td>
                                <td valign="top" style="background:#F0F0F3;color:#767679;font-size:11px" width="150">
                                    Type: {$ftt[$field.field_type]}

                                </td>
                            </tr>
                        </tbody></table></div>
            </li>
            {/foreach}
        </ul>
    </div>
</div>
{else}
No fields found
{/if}
<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();return false;" class="new_control" href="#"><span class="addsth"><strong>Define new field</strong></span></a>
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
                        <input type="submit" style="font-weight:bold" value="Add new field">
                        <span class="orspace">Or</span> <a class="editbtn" onclick="$('#addcategory').hide();return false;" href="#">Cancel</a>
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