<tr>
    <td colspan="2" class="tree-editor tree-editor-menuleft">
        <p>In this section you can configure left menu</p>
        <div id="leftmenu-tree"></div> <!-- main tree menu element -->
        <div class="clear"></div>
        <button class="btn btn-sm btn-default" style="margin-top: 10px;" onclick="LeftMenuEditor.addMenuItem('section');return false;">Add new section</button>
        <button class="btn btn-sm btn-default" style="margin-top: 10px;" onclick="LeftMenuEditor.addMenuItem('link');return false;">Add new link</button>
        <button class="btn btn-sm btn-default" style="margin-top: 10px;" onclick="LeftMenuEditor.addMenuItem('list');return false;">Add new list</button>
        {include file="theme_config/_treeeditor_modal.tpl" tab="menuleft"}
    </td>
</tr>

<script>
    {literal}
    $(function () {
        var treedata_menuleft = {/literal}{$section.sections|@json_encode}{literal};
        $.menuTree = new Object();
        $.menuTree.tree = $('#leftmenu-tree');
        $.menuTree.caurl = "{/literal}{$caurl}{literal}";
        LeftMenuEditor.init(treedata_menuleft);
    });
    {/literal}
</script>