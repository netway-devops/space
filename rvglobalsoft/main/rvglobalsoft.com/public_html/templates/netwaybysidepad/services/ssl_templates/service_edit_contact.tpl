<div class="form_edit_contact" style="display: none;">
    {$a|ssl_validation}
    <input id="RV_BASEURL" type="hidden" value="" />
    <input id="orderId" type="hidden" value="" />
    <div class="table-header">
        <p><b>Edit Contact</b></p>
    </div>
    <br>
    <div class="edit_organize_contact" style="display:none;">
        <div class="ssl-information-div">
            <p class="title" style="margin-top:24px;">Organization Contact</p>
        </div>
        <p class="linebottom"></p>
        <br />
        <div id="edit_organize_div" class="edit_organize_contact" style="display:none;">

        </div>
        <br><br>
    </div>
    <div>
        <table width="100%">
            <tr>
                <td width="50%">
                    <div class="edit_admin_contact" style="display:none;">
                        <div class="ssl-information-div">
                            <p class="title" style="margin-top:24px;">Administrative Contact</p>
                        </div>
                        <p class="linebottom"></p>
                        <br />
                        <div id="edit_admin_div" class="edit_admin_contact" style="display:none;">

                        </div>
                    </div>
                </td>
                <td width="50%">
                    <div class="edit_tech_contact" style="display:none;">
                        <div class="ssl-information-div">
                            <p class="title" style="margin-top:24px;">Technical Contact</p>
                        </div>
                        <p class="linebottom"></p>
                        <br />
                        <div id="edit_tech_div" class="edit_tech_contact" style="display:none;">

                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <hr />
    <div align="center">
        <input id="validate_button" class="back" type="button" value="Back">
        &nbsp;
        <input id="validate_button" class="edit_contact_save" type="button" value="Save">
    </div>
</div>