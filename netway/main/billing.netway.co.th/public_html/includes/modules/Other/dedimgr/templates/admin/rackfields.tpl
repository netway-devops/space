
<script src="{$moduledir}js/inventory.js"></script>
{if $list}
    <div id="listform">
        <div id="serializeit">
            <table class="inventory-list" id="grab-sorter" >
                <tbody>
                    {foreach from=$list item=category}
                        <tr>
                            <td>
                                <a onclick="return toggleTypeEdit('{$category.id}', this)" title="Edit" class="menuitm menu-auto" href="#">
                                    <span class="editsth"></span> 
                                </a>
                                <a onclick="return confirm('Are you sure you want to remove this field? This will remove all its values')" 
                                   title="delete" class="menuitm menu-auto"
                                   href="?cmd=dedimgr&do=inventory&make=removefield&subdo=rackfields&id={$category.id}">
                                    <span class="delsth"></span>
                                </a>
                            </td>
                            <td>
                                <div id="fname_{$category.id}">{$category.name}</div>
                                <div id="fform_{$category.id}" style="display:none" class="fform_labels">
                                    <form action="" method="post">
                                        <label>
                                            <span class="l">Field name:</span><input type="text" value="{$category.name}" name="name" class="inp"/>
                                        </label>

                                        <input type="hidden" name="make" value="editfield">
                                        <input type="hidden" name="id" value="{$category.id}">

                                        <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Save">
                                        <span class="orspace">Or</span>
                                        <a class="editbtn" onclick="return toggleTypeEdit('{$category.id}')" href="#">Cancel</a>
                                    </form>
                                </div>
                            </td>

                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
{else}
    No rack fields
{/if}
<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();
            return false;" class="new_control" href="#">
        <span class="addsth"><strong>Add new rackfield</strong></span>
    </a>
</div>
<div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory"><form action="" method="post">
        <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
            <tbody>
                <tr>
                    <td>
                        Name: <input type="text" value="" name="name" class="inp"/>
                    </td>
                    <td>
                        <input type="hidden" name="make" value="addfield">
                        <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Add field">
                        <span class="orspace">Or</span>
                        <a class="editbtn" onclick="$('#addcategory').hide();
                            return false;" href="#">Cancel</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
</div>