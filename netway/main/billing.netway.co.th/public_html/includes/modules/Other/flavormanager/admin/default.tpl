{include file="header.tpl"}
{if $list}
    <form id="serializeit">
        <ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
            {foreach from=$list item=field name=fff}
                <li style="background:#ffffff">
                <div style="border-bottom:solid 1px #ddd;">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr class="havecontrols">
                                <td width="120">
                                    <div style="padding:10px 5px;">
                                        <a class="sorter-ha menuitm menu-auto" style="margin-left:4px;"
                                           onclick="return false" href="#"><span title="move"
                                                                                 class="movesth">&nbsp;</span></a>
                                        <a class="menuitm menu-auto"
                                           href="?cmd=flavormanager&action=edit&id={$field.id}" title="edit"><span
                                                    class="editsth"></span></a>
                                        <a class="menuitm menu-auto" title="delete"
                                           href="?cmd=flavormanager&action=delete&id={$field.id}&security_token={$security_token}"
                                           onclick="return confirm('Are you sure you wish to delete this flavor?');"><span
                                                    class="delsth"></span></a>
                                    </div>
                                </td>
                                <td>
                                    <input type="hidden" name="sort[]" value="{$field.id}"/>
                                    {if $field.enabled=='0'}<em>{/if}{$field.name} {if !$entry.enabled}</em>{/if}
                                </td>
                                <td align='right'>  {$field.price_on|price:$currency:true:false:true:10} / hour</td>
                                <td width='100'></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                </li>    {/foreach}
        </ul>
        {securitytoken}
    </form>
{else}
    <div class="blank_state blank_kb">
        <div class="blank_info">
            <h1>Flavor Manager</h1>
            You can create flavors to be used by clients here
            <div class="clear"></div>
            <a style="margin-top:10px" href="?cmd=flavormanager&action=add" class="new_add new_menu">
                <span>Add new Flavor</span></a>
            <div class="clear"></div>
        </div>
    </div>
{/if}
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>

{literal}
    <script>
        $(document).ready(function () {
            $("#grab-sorter").dragsort({
                dragSelector: "a.sorter-ha",
                dragBetween: true,
                dragEnd: saveOrder,
                placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
            });

        });

        function saveOrder() {
            var sorts = $('#serializeit').serialize();
            ajax_update('?cmd=flavormanager&action=sort&' + sorts, {});
        };
    </script>
{/literal}