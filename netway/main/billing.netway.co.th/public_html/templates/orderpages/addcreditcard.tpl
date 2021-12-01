{if $custom_overrides.addcreditcard}
    {include file=$custom_overrides.addcreditcard}
{else}
    <div class="wbox">
        <div class="wbox_header">
            <strong>{$lang.ccarddetails}</strong>
        </div>
        <div class="wbox_content ccform">
            <div class="left citm">
                <label for="field_credit_number">{$lang.ccardnum}</label>
                <input type="text" id="field_credit_number" class="styled" name="cc[cardnum]" style="width: 90%;" value="" onblur="verifyCardNumber()" onkeyup="verifyCardNumber()"  autocomplete="off" />
            </div>

            <div class="left cfitm" style="padding-bottom:3px">
                <label for="field_credit_number">{$lang.ccardexp}</label>
                <select name="cc[expirymonth]" class="styled span1"> <option value="01">01</option>
                    <option value="02">02</option>
                    <option value="03">03</option>
                    <option value="04">04</option>
                    <option value="05">05</option>
                    <option value="06">06</option>
                    <option value="07">07</option>
                    <option value="08">08</option>
                    <option value="09">09</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option></select> / <select name="cc[expiryyear]" class="styled span1">
                        {section name=bar start=$curyear loop=$curyear+10}
                            <option value="{$smarty.section.bar.index}">20{$smarty.section.bar.index}</option>
                    {/section}
                 </select>
            </div>
            <div class="left cfitm">
                <label for="field_credit_number">CVV2</label>
                <input type="text" id="field_credit_number" class="styled" name="cc[cvv]" style="width:50px" value=""  autocomplete="off" />
            </div>
            <div class="left cfitm" id="card_types">

                <input type="hidden" id="field_credit_type"  name="cc[cardtype]"  value="" />
                <label for="field_credit_number">{$lang.ccardtypeaccept}</label>
                {foreach from=$supportedcc item=cc}
                    <div class="credit_card {$cc|replace:'American Express':'amex'}" title="{$cc}"></div>
                {/foreach}

                <div class="clear"></div>
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
        .credit_card {
            display:block;
            width:32px;
            height:32px;
            background-image: url('templates/orderpages/images/credit_cards.png');
            background-repeat:no-repeat;
            float:left;
            margin-right:10px;
        }
        .amex {
            background-position: -32px 0px;
        }
        .amex.offcard {
            background-position: -32px -32px !important;
        }
        .Visa {
            background-position: -64px 0px;
        }
        .Visa.offcard {
            background-position: -64px -32px !important;
        }
        .Discover {
            background-position: 0px 0px;
        }
        .Discover.offcard {
            background-position: 0px -32px !important;
        }
        .MasterCard {
            background-position: -96px 0px;
        }
        .MasterCard.offcard {
            background-position: -96px -32px !important;
        }

        .JCB {
            background-position: -160px 0px;
        }
        .JCB.offcard {
            background-position: -160px -32px !important;
        }

        .Dinersclub {
            background-position: -192px 0px;
        }
        .Dinersclub.offcard {
            background-position: -192px -32px !important;
        }

        .Maestro {
            background-position: -224px 0px;
        }
        .Maestro.offcard {
            background-position: -224px -32px !important;
        }
        .Solo {
            background-position: -256px 0px;
        }
        .Solo.offcard {
            background-position: -256px -32px !important;
        }


        .Laser {
            background-position: -288px 0px;
        }
        .Laser.offcard {
            background-position: -288px -32px !important;
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
    <script type="text/javascript">

        function getCreditCardType(ccnumber)
        {
            var cc = (ccnumber + '').replace(/\s/g, '').replace('-', '');
            var result = "unknown";

            if ((/^(34|37)/).test(cc) && cc.length == 15) {
                return 'amex'; //AMEX begins with 34 or 37, and length is 15.
            } else if ((/^(51|52|53|54|55)/).test(cc) && cc.length == 16) {
                return 'MasterCard'; //MasterCard beigins with 51-55, and length is 16.
            } else if ((/^(4)/).test(cc) && (cc.length == 13 || cc.length == 16)) {
                return 'Visa'; //VISA begins with 4, and length is 13 or 16.
            } else if ((/^(300|301|302|303|304|305|36|38)/).test(cc) && cc.length == 14) {
                return 'Dinersclub'; //Diners Club begins with 300-305 or 36 or 38, and length is 14.
            } else if ((/^(2014|2149)/).test(cc) && cc.length == 15) {
                return 'Enroute'; //enRoute begins with 2014 or 2149, and length is 15.
            } else if ((/^(6011)/).test(cc) && cc.length == 16) {
                return 'Discover'; //Discover begins with 6011, and length is 16.
            } else if ((/^(3)/).test(cc) && cc.length == 16) {
                return 'JCB';  //JCB begins with 3, and length is 16.
            } else if ((/^(2131|1800)/).test(cc) && cc.length == 15) {
                return 'JCB';  //JCB begins with 2131 or 1800, and length is 15.
            } else if ((/^(6304|6706|6771|6709)/).test(cc) && cc.length >= 16 && cc.length <= 19) {
                return 'Laser';
            } else if ((/^(5018|5020|5038|6304|6759|6761)/).test(cc) && cc.length >= 12 && cc.length <= 19) {
                return 'Maestro';
            } else if ((/^(6334|6767)/).test(cc) && cc.length >= 16 && cc.length <= 19 && cc.length != 17) {
                return 'Solo';
            }

            return result;
        }

        function verifyCardNumber() {
            var num = $('#field_credit_number').val();
            $('#card_types .credit_card').removeClass('offcard');
            var type=getCreditCardType(num);
            if(type!='unknown') {
                $('#card_types .credit_card').addClass('offcard');
                $('#card_types .'+type).removeClass('offcard');

                var xtype =   $('#card_types .'+type).attr('title');
                $('#field_credit_type').val(xtype);
            }
            return false;
        }
    </script>
    {/literal}
{/if}