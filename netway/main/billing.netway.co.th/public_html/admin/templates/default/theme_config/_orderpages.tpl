<tr>
    <td colspan="2">
        <p>In this section you can configure orderpage icons</p>

        <div class="tc-orderpages" data-icons_path="{$system_url}{$icons_path}">
            {foreach from=$orderpages item=orderpage}
                <table class="tc-orderpage-item" data-id="{$orderpage.id}">
                    <tbody>
                        <tr>
                            <td width="40%">
                                <span>Orderpage:</span>
                                <b>{$orderpage.name}</b>
                            </td>
                            <td width="40%">
                                <span>Icon:</span>
                                <b class="tc-orderpage-item-icon">{$section.options[$orderpage.id].icon}</b>
                                <img {if !$section.options[$orderpage.id].icon}style="display: none;"{/if} src="{$system_url}{$icons_path}{$section.options[$orderpage.id].icon}" alt="" width="48" height="48" class="tc-orderpage-item-icon-url" style="margin: 10px 0;">
                            </td>
                            <td align="right" style="width: 160px;">
                                <a href="#" class="btn btn-default btn_edit btn-xs" onclick="Orderpage.edit(this);return false;"><span class="fa fa-edit"></span> Edit</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            {/foreach}
        </div>
        <div class="modal fade" tabindex="-1" role="dialog" id="item-orderpage">
            <div class="modal-dialog" role="document">
                <div class="modal-content tc_orderpage_modal">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Edit orderpage</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <p><b>Icon:</b></p>
                            <img src="" alt="" width="64" height="64" class="tc_orderpage_icon_url" style="margin: 10px 0;">
                            <div>
                                <input style="width: 79%;display: inline-block" readonly="readonly" type='text' name='tc_orderpage_icon' class='form-control' id='tc_orderpage_icon'/>
                                <a style="width: 20%" class="btn btn-default" href="#" onclick="Orderpage.show_icons(this);return false;">Show all icons</a>
                            </div>
                            <small style="color: #888">The icon color depends on the Brand primary color</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="tc_orderpage_id" id="tc_orderpage_id">
                        <a class="btn btn-default" data-dismiss="modal">Cancel</a>
                        <a class="btn btn-primary" onclick="Orderpage.save();return false;">Save changes</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" tabindex="-1" role="dialog" id="orderpage-icons">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Select icon</h4>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-info">
                            Note! You can use your own icons. Add your own images to the folder: <b>{$hb_maindir}{$icons_path}</b>
                        </div>
                        <div style="max-height: 400px; overflow-y: auto">
                            <table class="table table-striped" style="width: 100%">
                                <tbody>
                                {foreach from=$icons item=icon}
                                    <tr>
                                        <td><img src="{$system_url}{$icons_path}{$icon}" alt="" width="64" height="64"></td>
                                        <td>{$icon}</td>
                                        <td><a class="btn btn-sm btn-primary" href="#" onclick="Orderpage.select_icon('{$icon}');return false;">Select this icon</a></td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {literal}
            <style>
                .tc-orderpage-item {
                    width: 100%;
                    border: 1px solid rgb(238, 238, 238);
                    margin: 20px 0;
                    background-color: rgb(252, 252, 252);
                    box-shadow: rgba(100, 100, 100, 0.1) 0 0 2px;
                }
                .tc-orderpage-item td {
                    padding: 10px 20px;
                }
            </style>
        {/literal}
    </td>
</tr>