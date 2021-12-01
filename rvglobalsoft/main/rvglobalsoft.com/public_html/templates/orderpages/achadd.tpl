<div class="wbox">
    <div class="wbox_header">
        <strong>{$lang.ach_information}</strong>
    </div>
    <div class="wbox_content ccform">
        <div class="left citm">
            <label for="field_ach_account_number">{$lang.ach_account_number}</label>
            <input type="text" id="field_ach_account_number" class="styled" name="cc[account]" style="width: 90%;" value=""   autocomplete="off" />
        </div>

        <div class="left cfitm">
            <label for="field_credit_routing">{$lang.ach_routing_number}</label>
            <input type="text" id="field_credit_routing" class="styled" name="cc[routing]" style="width: 90%;" value=""  autocomplete="off" />
        </div>
        <div class="left cfitm" style="padding-bottom:3px">
            <label for="field_ach_account_number">{$lang.type}</label>
            <select name="cc[type]" class="styled span2">
                <option value="checkings">{$lang.checking}</option>
                <option value="savings">{$lang.savings}</option>
                <option value="business_checking">{$lang.business_checking}</option>
               </select>
        </div>

        <div class="clear"></div>

    </div>
</div>
{literal}<style type="text/css">
    #onestepcontainer #gatewayform .wbox {
        border:none;
    }
    #onestepcontainer #gatewayform .wbox_header {
        border:none;
        margin:0px;
        background:none;
        padding:0px;
        font-size:17px;
        letter-spacing: -1px;
        text-transform: lowercase;
    }
    #onestepcontainer #gatewayform .wbox_content {
        border-radius:4px 4px 4px 4px;
        border:1px solid #D2D2D2;
    }


    .ccform label {
        margin-bottom:4px;
        clear:both;
        display:block;
    }
    .cfitm {
        padding:5px;
    }
    .citm {
        padding:5px;
        width: 280px;
    }


</style>

{/literal}