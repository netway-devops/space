{*
This file is used by paypal module when "Verify PayPal email" option is enabled.
It will be displayed on orderform for client to provide his email address.
*}
<div class="wbox">
    <div class="wbox_header">
        <strong>{$lang.paypalemail}</strong>
    </div>
    <div class="wbox_content ccform">
        <div class="left citm">
            <label for="paypalemail">{$lang.paypalemaildescr}</label>
            <input type="text" id="paypalemail" class="styled" name="paypalemail" style="width: 90%;" value="{$submit.paypalemail}" autocomplete="off" />
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