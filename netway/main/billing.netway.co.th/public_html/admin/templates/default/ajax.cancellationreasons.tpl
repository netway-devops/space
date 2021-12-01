{foreach from=$reasons item=i name=cat}
    <li class="{if $i.visible=='0'}ishidden{/if} {if $i.visible==-1}archived{/if} entry" id="entry{$i.id}" >
        <div >
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                <tr  class="havecontrols">
                    <td width="20">
                        <input type="hidden" name="sort[]" value="{$i.id}" />
                        <div style="width: 10px">
                            <div class="controls"><a class="sorter-handle" >{$lang.move}</a></div>
                        </div>
                    </td>
                    <td class="name">
                        <a href="?cmd=cancellationreasons&action=edit&id={$i.id}" class="direct">
                            <span>{$i.reason}</span>
                        </a>
                    </td>
                    <td width="100">
                        <span>{$i.target|ucfirst}</span>
                    </td>
                    <td width="100" style="padding-left: 10px">
                        <span>{$i.counter}</span>
                    </td>
                    <td width="100" style="text-align: right">
                        <a href="?cmd=cancellationreasons&action=edit&id={$i.id}" class="menuitm menu-auto"><span style="color: red">{$lang.Edit}</span></a>
                        <a href="?cmd=cancellationreasons&action=delete&id={$i.id}&security_token={$security_token}"
                           onclick="return confirm('{$lang.reason_delete_confirm}');" class="menuitm menu-auto ajax"><span class="delsth"></span></a>
                    </td>
                </tr>
            </table>
        </div>
    </li>
{/foreach}
{literal}
    <script type="text/javascript">
        $(function () {
            $("#grab-sorter").dragsort({
                dragSelector: "a.sorter-handle",
                dragBetween: true,
                dragEnd: saveOrder,
                placeHolderTemplate: "<li class='placeHolder'><div></div></li>"
            });
        });

        function saveOrder() {
            var sorts = $('#serializeit').serialize();
            ajax_update('?cmd=cancellationreasons&action=listfields&' + sorts, {});
        }
    </script>
{/literal}