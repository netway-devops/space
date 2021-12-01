<table width="100%">
    <tr>
        <td class="fright">
            <h1 style="margin: 5px 10px -5px;">Edit list details {$group.name}</h1>
            <hr />

            <form action="?cmd=module&module={$moduleid}" method="post" id="edit-list-form" onsubmit="return false">
                <input type="hidden" name="action" value="editlist"/>
                <input type="hidden" name="group" value="{$group.id}"/>
                <input type="hidden" id="ipvtype" value="{$group.type}"/>

                {include file="list_form.tpl"}
            </form>

        </td>
    </tr>
</table>
<div class="f-footer">
    <div class="left spinner" style="display: none;">
        <img src="ajax-loading2.gif"/>
    </div>
    <div class="right">
        <span class="bcontainer ">
            <a class="new_control greenbtn" onclick="$('.spinner').show();
                        submitIPRange($('#edit-list-form').eq(0));
                        return false;" href="#">
                <span>Update list details</span>
            </a>
        </span>
        <span class="bcontainer">
            <a class="submiter menuitm" href="#" onclick="$(document).trigger('close.facebox');
                        return false;">
                <span>Close</span>
            </a>
        </span>
    </div>
    <div class="clear"></div>
</div>
{literal}
    <script type="text/javascript">
        $(function () {
            $("a.vtip_description").vTip();
        });
    </script>
{/literal}