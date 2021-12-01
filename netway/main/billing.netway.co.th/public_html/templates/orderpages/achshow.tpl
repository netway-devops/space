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
        padding:5px 10px 5px;
    }
    .citm {
        padding:5px;
        width: 280px;
    }


</style>

{/literal}
<div class="wbox">
    <div class="wbox_header">
        <strong>{$lang.ach_information}</strong>
    </div>
    <div class="wbox_content ccform">
        <div class="left cfitm">
            <label for="field_ach_account_number">{$lang.ach_account_number}</label>
            <b>{$achaccount.account}</b>
        </div>

        <div class="left cfitm" style="padding-bottom:3px">
            <label for="field_ach_routing_number">{$lang.ach_routing_number}</label>
            <b>{$achaccount.routing}</b>
        </div>


        <div class="clear"></div>



    </div>
</div>
