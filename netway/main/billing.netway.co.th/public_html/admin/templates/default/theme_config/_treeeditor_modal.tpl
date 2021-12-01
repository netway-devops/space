<div class="modal fade" tabindex="-1" role="dialog" id="treeeditor-modal_{$tab}">
    <div class="modal-dialog" role="document">
        <div class="modal-content tc_item_modal_{$tab}">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Edit menu item</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <p><b>Name:</b></p>
                    <input type='text' name='tc_item_name' class='form-control' id='tc_item_name' />
                    <div class='l_editor' id='l_editor_tc_item_name'><span class='translations'><span style="display: none;" class='taag'>Tags: </span></span>
                        <a class='fs11 editbtn l_adder' href='#' onclick='return HBInputTranslate.addTranslation("tc_item_name");'>Add translation</a>
                        <div class='clear'></div>
                    </div>
                </div>
                <div class="tc_item_modal_additional tc_item_modal_additional_link">
                    <hr>
                    <div class="form-group">
                        <p><b>Url:</b></p>
                        <input type="radio" name="tc_item_url_type" value="system" onclick="$('.tc_item_url_box').hide();$('.tc_item_url_box_system').toggle($(this).is(':checked'))"> Use predefined URL<br>
                        <input type="radio" name="tc_item_url_type" value="custom" onclick="$('.tc_item_url_box').hide();$('.tc_item_url_box_custom').toggle($(this).is(':checked'))"> Use custom URL<br><br>
                        <div class="tc_item_url_box tc_item_url_box_system" style="display:none;">
                            <select name="tc_item_url" class="form-control">
                                <option value="clientarea/">Main page</option>
                                <option value="services/">Services</option>
                                <option value="domains/">Domains</option>
                                <option value="clientarea/overview/">Account details</option>
                                <option value="clientarea/details/">Edit account details</option>
                                <option value="clientarea/password/">Edit account password</option>
                                <option value="clientarea/settings/">Edit account settings</option>
                                <option value="profiles/">Profiles</option>
                                <option value="clientarea/invoices/">Invoices</option>
                                <option value="clientarea/creditreceipts/">Credit receipts</option>
                                <option value="clientarea/addfunds/">Add funds</option>
                                <option value="clientarea/ach/">ACH details</option>
                                <option value="clientarea/ccard/">Credit card details</option>
                                <option value="affiliates/">Affiliates</option>
                                <option value="clientarea/ipaccess/">IP access</option>
                                <option value="clientarea/history/">Account log</option>
                                <option value="clientarea/emails/">Email log</option>
                                <option value="clientarea/creditlogs/">Credit log</option>
                                <option value="clientarea/portal_notifications/">Portal notifications</option>
                                <option value="knowledgebase/">Knowledgebase</option>
                                <option value="support/">Support center</option>
                                <option value="tickets/">Support tickets</option>
                                <option value="downloads/">Downloads</option>
                                <option value="chat/">Chat</option>
                                <option value="netstat/">Server status</option>
                                <option value="root/logout/">Logout</option>
                            </select>
                        </div>
                        <div class="tc_item_url_box tc_item_url_box_custom" style="display:none;">
                            <input id="ns1" class="form-control" placeholder="Provide URL here" type="text" name="tc_item_url">
                        </div>
                    </div>
                </div>
                <div class="tc_item_modal_additional tc_item_modal_icon tc_item_modal_additional_list tc_item_modal_additional_link">
                    <hr>
                    <div class="form-group">
                        <p><b>Icon:</b></p>
                        <input type="text" class="form-control" name="tc_item_icon">
                        <div style="margin-bottom: 20px;"><small>Supported icons can be found <a href="{$section.icons_url}" target="_blank">here</a></small></div>
                    </div>
                </div>
                <div class="tc_item_modal_additional tc_item_modal_additional_list">
                    <hr>
                    <div class="form-group">
                        <p><b>List items:</b></p>
                        <select name="tc_item_list" class="form-control">
                            <option value="services">Services</option>
                            <option value="products">Order pages</option>
                        </select>
                    </div>
                </div>
                <div class="tc_item_modal_additional tc_item_modal_options">
                    <hr>
                    <div class="form-group">
                        <p><b>Options:</b></p>
                        <div class="tc_item_custom_options"></div>
                    </div>
                </div>
                <div class="tc_item_modal_additional tc_item_modal_conditions">
                    <hr>
                    <div class="form-group">
                        <p><b>Conditions:</b></p>
                        <div class="tc_item_custom_conditions"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <input type="hidden" name="tc_item_id">
                <input type="hidden" name="tc_item_type">
                <a class="btn btn-default" data-dismiss="modal">Cancel</a>
                <a class="btn btn-primary" onclick="{if $tab=='menuleft'}LeftMenuEditor.saveMenuItem();{elseif $tab=='footer'}FooterEditor.saveMenuItem();{/if}return false;">Save changes</a>
            </div>
        </div>
    </div>
</div>