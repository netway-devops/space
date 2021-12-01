<tr>
    <td colspan="2" class="tree-editor tree-editor-footer">
        <p>In this section you can configure footer details</p>
        <hr>
        <input id='check_footer_show_info' type='checkbox' value='1' {if $section.options.show_info.value == 1}checked="checked"{/if} name="configuration[sections][footer][options][show_info][value]">
        <input id='check_hidden_footer_show_info' type='hidden' value='0' {if $section.options.show_info.value == 1}checked="checked"{/if} name="configuration[sections][footer][options][show_info][value]">
        {$section.options.show_info.name} <br>
        <small style="color: #888;"><b>Example:</b> &copy; {$smarty.now|date_format:"%Y"} {$business_name}</small>
        <br>
        <hr>
        <div id="footer-tree"></div> <!-- main tree menu element -->
        <div class="clear"></div>
        <button class="btn btn-sm btn-default" style="margin-top: 10px;" onclick="FooterEditor.addMenuItem();return false;">Add new link</button>
        {include file="theme_config/_treeeditor_modal.tpl" tab="footer"}
    </td>
</tr>

<script>
    {literal}
    $(function () {
        $('#check_footer_show_info').change(function () {
            $('#check_hidden_footer_show_info').prop('disabled', $(this).is(':checked'));
        }).trigger('change');

        var treedata_footer = {/literal}{$section.menu|@json_encode}{literal};
        $.footerTree = new Object();
        $.footerTree.tree = $('#footer-tree');
        $.footerTree.caurl = "{/literal}{$caurl}{literal}";
        FooterEditor.init(treedata_footer);
    });
    {/literal}
</script>