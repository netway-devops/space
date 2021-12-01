<tr>
    <td colspan="2">
        <p>In this section you can define files that will override default .tpl files</p>

        <div class="tc-overrides">
            {foreach from=$section.options item=override}
                <table class="tc-overrides-item">
                    <tbody>
                        <tr>
                            <td width="40%">
                                <span>Source:</span>
                                <b class="tc-overrides-item-source">{$override.source}</b>
                            </td>
                            <td width="40%">
                                <span>Target:</span>
                                <b class="tc-overrides-item-target">{$override.target}</b>
                            </td>
                            <td align="right" style="width: 160px;">
                                <a href="#" class="btn btn-default btn_edit btn-xs" onclick="Override.edit(this);return false;"><span class="fa fa-edit"></span> Edit</a>
                                <a href="#" class="btn btn-default btn-xs" style="color: red;" onclick="Override.remove(this);return false;"><span class="fa fa-trash-o"></span> Remove</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            {/foreach}
        </div>
        <div class="modal fade" tabindex="-1" role="dialog" id="item-override">
            <div class="modal-dialog" role="document">
                <div class="modal-content tc_override_modal">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Edit override</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <p><b>Source .tpl file:</b></p>
                            <small style="margin-top: 10px; color: #aaa;">Example: clientarea/dashboard.tpl</small>
                            <input type='text' name='tc_override_source' class='form-control' id='tc_override_source' />
                        </div>
                        <div class="form-group">
                            <p><b>Target .tpl file:</b></p>
                            <small style="margin-top: 10px; color: #aaa;">Example: clientarea/dashboard_custom.tpl</small>
                            <input type='text' name='tc_override_target' class='form-control' id='tc_override_target' />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="tc_override_id" id="tc_override_id">
                        <a class="btn btn-default" data-dismiss="modal">Cancel</a>
                        <a class="btn btn-primary" onclick="Override.save();return false;">Save changes</a>
                    </div>
                </div>
            </div>
        </div>
        <button class="btn btn-sm btn-default" style="margin-top: 10px;" onclick="Override.add();return false;">Add new override</button>
        {literal}
            <style>
                .tc-overrides-item {
                    width: 100%;
                    border: 1px solid rgb(238, 238, 238);
                    margin: 20px 0;
                    background-color: rgb(252, 252, 252);
                    box-shadow: rgba(100, 100, 100, 0.1) 0 0 2px;
                }
                .tc-overrides-item td {
                    padding: 10px 20px;
                }
            </style>
        {/literal}
    </td>
</tr>