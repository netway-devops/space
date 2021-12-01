<link href="templates/default/css/invoices.css?v={$hb_version}" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="{$template_dir}js/transactions.js?v={$hb_version}"></script>
<form action="" method="post" id="transaction-form">
    <input type="hidden" value="add" name="make" />
    <div class="blu"><a href="?cmd=transactions"  data-pjax><strong>&laquo; {$lang.backtotransactions}</strong></a></div>


    <div id="ticketbody">

        <div id="invoice-draft">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><h1>{$lang.addnewtransaction}</h1></td>
            </tr>
        </table>


        <div class="ticketmsg ticketmain" id="client_tab">
            <div  class="slide" style="display:block">

                {assign value=0 var=draftstep}
            <ul class="hbnav breadcrumb draft-steps">
                <li class="step {if $draftstep==0}active{/if}">
                    <a><span>Client: <span id="client-name"></span></span></a>
                </li>
                <li class="step {if $draftstep==1}active{/if}">
                    <a><span>Transaction type</span></a>
                </li>
                <li class="step {if $draftstep==2}active{/if}">
                    <a><span>Details</span></a>
                </li>

            </ul>
                <div class="draft-steps-box">
                    <div class="draft-step" {if $draftstep==0}style="display:block"{/if}>
                        <div id="clientloader">
                            <p>Choose client profile that you want to assign to this transaction.</p>

                            <div class="row">
                                <div class="col-md-6">
                                    <select  style="width: 100%" name="client_id" load="clients" default="{$submit.client_id}">
                                        <option value="0">{$lang.selectcustomer}</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <a  class="btn btn-default">Continue</a>
                                </div>
                            </div>


                        </div>

                    </div>
                    <div class="draft-step" {if $draftstep==1}style="display:block"{/if}>
                        <ul class="invoice-type">
                            <li>
                                <input type="radio" value="credit" id="credit" name="type"  {if $submit.type=='credit'}checked{/if}/>
                                <label for="credit">
                                    <h3>Add to client credit</h3>
                                    <span>Transaction will increase/decrease client credit balance</span>
                                </label>
                            </li>
                            <li>
                                <input type="radio" value="invoice" id="invoice" name="type"   {if $submit.type=='invoice'}checked{/if}/>
                                <label for="invoice">
                                    <h3>Add to single invoice</h3>
                                    <span>Adds transaction to single customer's invoice.</span>
                                </label>
                            </li>

                            <li>
                                <input type="radio" value="bulk" id="bulk" name="type"  {if $submit.type=='bulk'}checked{/if}/>
                                <label for="bulk">
                                    <h3>Add to multiple invoices</h3>
                                    <span>Adds single transaction to multiple invoices</span>
                                </label>
                            </li>
                        </ul>
                    </div>

                    <div class="draft-step searchform" {if $draftstep==2}style="display:block"{/if}>
                        <div id="detcont" >

                            <div class="row">
                                <div class="form-group col-sm-6 col-md-4" >
                                    <label>
                                        {$lang.Transactionid}
                                    </label>
                                    <input type="text" name="trans_id" value="{$submit.trans_id}"  class="form-control ">
                                </div>
                                <div class="form-group col-sm-6 col-md-4" >
                                    <label>
                                        {$lang.paymethod}
                                    </label>
                                    <select name="module" class="form-control ">

                                        {foreach from=$modules item=module key=id}
                                            <option value="{$id}"  {if $submit.module==$id}selected="selected"{/if}>{$module}</option>
                                        {/foreach}

                                    </select>
                                </div>
                                <div class="form-group col-sm-3 col-md-3" >
                                    <label>
                                        {$lang.Date}
                                    </label>
                                    <div class="input-group" style="width: 100%;">
                                        <div class="datepicker">
                                            <input type="text" value="{$submit.date|dateformat:$date_format}" name="date" class="form-control haspicker " />
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group col-sm-3 col-md-1" >
                                    <label>
                                        Time
                                    </label>
                                    <div class="input-group" >
                                        <div class="datepicker">
                                            <input type="text" value="{$now}" name="time" class="form-control  " />
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group col-md-12" >
                                    <label>
                                        {$lang.Description}
                                    </label>
                                    <input type="text" name="description" value="{$submit.description}"  class="form-control ">
                                </div>

                                <div class="form-group col-sm-6 col-md-4" >
                                    <label for="total-in">
                                       Total amount in
                                    </label>
                                    <div class="input-group" >
                                        <div class="input-group-addon currency_sign">{$client_currency.sign}</div>
                                         <input type="text" value="{$submit.in|default:'0.00'}" name="in" id="total-in" class="form-control " />
                                        <div class="input-group-addon currency_code">{$client_currency.code}</div>
                                    </div>
                                </div>

                                <div class="form-group col-sm-6 col-md-4" >
                                    <label for="total-fee">
                                        {$lang.fees}
                                    </label>
                                    <div class="input-group" >
                                        <div class="input-group-addon currency_sign">{$client_currency.sign}</div>
                                        <input type="text" value="{$submit.fee|default:'0.00'}" name="fee" id="total-fee"  class="form-control " />
                                        <div class="input-group-addon currency_code">{$client_currency.code}</div>
                                    </div>
                                </div>

                                <div class="form-group col-sm-6 col-md-4" >
                                    <label for="total-out">
                                        {$lang.amountout}
                                    </label>
                                    <div class="input-group" >
                                        <div class="input-group-addon currency_sign">{$client_currency.sign}</div>
                                        <input type="text" value="{$submit.out|default:'0.00'}" name="out" id="total-out"  class="form-control " />
                                        <div class="input-group-addon currency_code">{$client_currency.code}</div>
                                    </div>
                                </div>
                            </div>

                            <hr>
                            <div class="row type-bulk type-invoice" >
                                <div class="form-group col-sm-6 col-md-4">
                                    <label>
                                        Attach to invoice:
                                    </label>
                                    <div id="type-invoice">
                                        <select name="invoice_id" class="form-control ">


                                        </select>
                                    </div>

                                </div>

                                <div class="form-group col-sm-2 type-bulk"  >
                                    <label class="hide-sm">{$lang.amountin}</label>
                                    <div>
                                        <input type="text" value="{$submit.in|default:'0.00'}" id="partial-in" class="form-control " />
                                    </div>
                                </div>

                                <div class="form-group col-sm-2 type-bulk"  >
                                    <label class="hide-sm">{$lang.amountout}</label>
                                    <div>
                                        <input type="text" value="{$submit.out|default:'0.00'}" id="partial-out" class="form-control " />
                                    </div>
                                </div>
                                <div class="form-group col-sm-6 col-md-4 type-bulk"  >
                                        <label class="hide-sm">&nbsp;</label>
                                        <div>
                                            <a id="add" class="btn btn-primary btn-md" href="#add">Attach invoice</a>

                                        </div>
                                </div>


                            </div>
                            <div class="row type-bulk">
                                <div class="col-md-12">
                                <table class="table table-striped table-import">
                                    <colgroup>
                                        <col class="col-sm-4" />
                                        <col class="col-sm-2" />
                                        <col class="col-sm-2" />
                                        <col class="col-sm-4" />


                                    </colgroup>
                                    <tbody id="import-items" data-totalin="0.00" data-totalout="0.00">


                                    <tr class="placeholder">
                                        <td colspan="4">No invoices attached to this transacion yet.</td>
                                    </tr>
                                    </tbody>
                                </table>
                                </div>
                            </div>


                            <div style="text-align:center;margin:20px 0px;padding:15px 0px;" class="p6 secondtd">
                                <input class="btn btn-success" type="submit" id="form-submit" value="{$lang.addtransaction}" disabled />

                            </div>

                        </div>
                    </div>
                </div>
            </div>





        </div>





        </div>

    </div>

    <div class="blu"><a href="?cmd=transactions"  data-pjax><strong>&laquo; {$lang.backtotransactions}</strong></a>
    </div>
    {securitytoken}
</form>
{literal}
    <style>
        .table-import{
            margin-bottom: 15px;
        }
        #import-items tr td {
            padding: 10px;
            border-bottom: 1px solid #ddd
        }
        #import-items tr + tr.placeholder {
            display: none;
        }
        #import-items .placeholder td {
            padding: 12px 15px;
            color: #ccc;
            border: 2px dashed #ddd;
        }
        #import-items code {
            padding: 2px 4px;
            font-size: 90%;
            color: #35779E;
            background-color: #F2F4F9;
            border-radius: 4px;
        }
    </style>
<script type="text/x-handlebars" id="add-item-tpl">
        <tr data-index="{{id}}" data-in="{{amountin}}" data-out="{{amountout}}">
            <td>
                <input type="hidden" name="invoice_ids[{{id}}][id]" value="{{id}}"/>
                <a href="?cmd=invoices&action=edit&list=unpaid&id={{id}}" target="_blank">{{name}}</a>


            </td>
            <td>
               {/literal}{$lang.amountin}{literal}
                <input type="text" name="invoice_ids[{{id}}][in]" class="form-control amountin" value="{{amountin}}"/>
            </td>
            <td>
               {/literal}{$lang.amountout}{literal}

                <input type="text" name="invoice_ids[{{id}}][out]" class="form-control amountout" value="{{amountout}}"/>
            </td>
            <td>
                <a class="rem btn btn-default btn-sm" href="#rem">Remove</a>
            </td>
        </tr>
    </script>
    <script type="text/javascript">
        function updateCurrency(id){
            $.get('?cmd=clients&action=getClientCurrency&id='+id, function(data){
                if(data.currency){
                    $('.currency_sign').text(data.currency.sign);
                    $('.currency_code').text(data.currency.code);
                }
            })
        }
        function new_gateway(elem) {
            if ($(elem).val() == 'new') {
                window.location = "?cmd=managemodules&action=payment";
                $(elem).val(($("select[name='module'] option:first").val()));
            }
        }
    </script>
{/literal}