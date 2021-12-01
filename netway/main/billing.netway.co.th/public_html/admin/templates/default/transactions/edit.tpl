<script type="text/javascript" src="{$template_dir}js/transactions.js?v={$hb_version}"></script>
<form action="" method="post">
    <input type="hidden" value="update" name="make" />
    <div class="blu">

        <div class="menubar">
            <a href="?cmd=transactions"  data-pjax><strong>&laquo; {$lang.backtotransactions}</strong></a>

            <a class="setStatus menuitm menu-auto" name="markpaid" id="hd1">
                <span class="morbtn">Set status</span>
            </a>
            <a class="deleteInvoice menuitm menu-auto " name="delete" href="?cmd=transactions&make=delete&id={$transaction.id}&security_token={$security_token}"  onclick="return confirm('{$lang.deletetransconfirm}');">
                <span style="color:#FF0000">Delete</span>
            </a>
            <ul id="hd1_m" class="ddmenu">
                <li ><a href="?cmd=transactions&action=setstatus&security_token={$security_token}&id={$transaction.id}&status=Processing">{$lang.Processing}</a></li>
                <li ><a href="?cmd=transactions&action=setstatus&security_token={$security_token}&id={$transaction.id}&status=Success">{$lang.Success}</a></li>
                <li ><a href="?cmd=transactions&action=setstatus&security_token={$security_token}&id={$transaction.id}&status=Refunded">{$lang.Refunded}</a></li>
                <li ><a href="?cmd=transactions&action=setstatus&security_token={$security_token}&id={$transaction.id}&status=Chargeback">{$lang.Chargeback}</a></li>
            </ul>
            {adminwidget module="transactions" section="transactionheader"}
        </div>
    </div>


    <div id="ticketbody">

        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><h1>{$lang.transactionhash}{$transaction.trans_id}  <span class="{$transaction.status}">{if $lang[$transaction.status]}{$lang[$transaction.status]}{else}{$transaction.status}{/if}</span></h1></td>
            </tr>
        </table>
        <div id="client_nav">
            <!--navigation-->
            <a class="nav_el nav_sel left" href="#">{$lang.transaction}</a>
            {include file="_common/quicklists.tpl" _client=$transaction.client_id}
            <div class="clear"></div>
        </div>

        <div class="ticketmsg ticketmain" id="client_tab">
            <div class="slide" style="display:block">

                <div id="detcont " >

                    <div class="row">
                        <div class="form-group col-sm-6 col-md-4" >
                            <label>
                                {$lang.Transactionid}
                            </label>
                            <input type="text" name="trans_id" value="{$transaction.trans_id}"  class="form-control ">
                        </div>
                        <div class="form-group col-sm-6 col-md-4" >
                            <label>
                                {$lang.paymethod}
                            </label>
                            <select name="module" class="form-control ">

                                {foreach from=$modules item=module key=id}
                                    <option value="{$id}"  {if $transaction.module==$id}selected="selected"{/if}>{$module}</option>
                                {/foreach}

                            </select>
                        </div>
                        <div class="form-group col-sm-3 col-md-3" >
                            <label>
                                {$lang.Date}
                            </label>
                            <div class="input-group searchform" style="width: 100%;">
                                <div class="datepicker">
                                    <input type="text" value="{$transaction.date|dateformat:$date_format}" name="date" class="form-control haspicker " />
                                </div>
                            </div>
                        </div>


                        <div class="form-group col-sm-3 col-md-1" >
                            <label>
                                Time
                            </label>
                            <div class="input-group" >
                                <div class="datepicker">
                                    <input type="text" value="{$transaction.time}" name="time" class="form-control  " />
                                </div>
                            </div>
                        </div>


                        <div class="col-md-4 form-group">
                            <label>{$lang.relatedclient}</label>
                                <select name="client_id" id="client_id" style="width: 100%"  class="form-control" load="clients" default="{$transaction.client_id}">
                                </select>
                        </div>
                        <div class="form-group col-md-8" >
                            <label>
                                {$lang.Description}
                            </label>
                            <input type="text" name="description" value="{$transaction.description}"  class="form-control ">
                        </div>

                        <div class="form-group col-sm-6 col-md-4" >
                            <label for="total-in">
                                Total amount in
                            </label>
                            <div class="input-group" >
                                <div class="input-group-addon currency_sign">{$transaction.currency.sign}</div>
                                <input type="text" value="{$transaction.in|default:'0.00'}" name="in" id="total-in" class="form-control " />
                                <div class="input-group-addon currency_code">{$transaction.currency.code}</div>
                            </div>
                        </div>

                        <div class="form-group col-sm-6 col-md-4" >
                            <label for="total-fee">
                                {$lang.fees}
                            </label>
                            <div class="input-group" >
                                <div class="input-group-addon currency_sign">{$transaction.currency.sign}</div>
                                <input type="text" value="{$transaction.fee|default:'0.00'}" name="fee" id="total-fee"  class="form-control " />
                                <div class="input-group-addon currency_code">{$transaction.currency.code}</div>
                            </div>
                        </div>

                        <div class="form-group col-sm-6 col-md-4" >
                            <label for="total-out">
                                {$lang.amountout}
                            </label>
                            <div class="input-group" >
                                <div class="input-group-addon currency_sign">{$transaction.currency.sign}</div>
                                <input type="text" value="{$transaction.out|default:'0.00'}" name="out" id="total-out"  class="form-control " />
                                <div class="input-group-addon currency_code">{$transaction.currency.code}</div>
                            </div>
                        </div>
                    </div>

                    <hr>
                    <input type="hidden" name="invoice_id" value="{$transaction.invoice_id}" />
                    {if $transaction.invoice_id}

                        <div class="row type-bulk type-invoice" >
                            <div class="form-group col-md-12">
                                <h1>Related document: #<a href="?cmd=invoices&action=edit&id={$transaction.invoice_id}" target="_blank">{$transaction.invoice|@invoice}</a> </h1>
                                <table  width="100%" class="table table-striped">

                                    <thead>
                                    <tr>
                                        <th>{$lang.documenthash}</th>
                                        <th>{$lang.Status}</th>
                                        <th>{$lang.Date}</th>
                                        <th>{$lang.duedate}</th>
                                        <th>{$lang.Total}</th>
                                    </tr>
                                    </thead>
                                    <tbody >
                                    <tr>
                                        <td><a href="?cmd=invoices&action=edit&id={$transaction.invoice_id}"  target="_blank">{$transaction.invoice|@invoice}</a></td>
                                        <td><span class="{$transaction.invoice.status}">{if $lang[$transaction.invoice.status]}{$lang[$transaction.invoice.status]}{else}{$transaction.invoice.status}{/if}</span></td>
                                        <td>{$transaction.invoice.date|dateformat:$date_format}</td>
                                        <td>{$transaction.invoice.duedate|dateformat:$date_format}</td>
                                        <td>{$transaction.invoice.grandtotal|price:$transaction.invoice.currency_id}</td>
                                    </tr>

                                    </tbody>

                                </table>

                            </div>
                        </div>

                        <hr>

                    {/if}

                    {if $children}
                        <div class="row type-bulk type-invoice" >
                            <div class="form-group col-md-12">
                                <h1>Sub-transactions: </h1>
                                {include file='transactions/sublisting.tpl' listing=$children}
                            </div>
                        </div>

                        <hr>

                    {elseif $parent}
                        <div class="row type-bulk type-invoice" >
                            <div class="form-group col-md-12">
                                <h1>Parent transaction: </h1>
                                {include file='transactions/sublisting.tpl' listing=$parent}
                            </div>
                        </div>

                        <hr>
                    {/if}

                    {if $refunds}
                        <div class="row type-bulk type-invoice" >
                            <div class="form-group col-md-12">
                                <h1>Refunded by:</h1>
                                {include file='transactions/sublisting.tpl' listing=$refunds}
                            </div>
                        </div>

                        <hr>
                    {elseif $refunded}

                        <div class="row type-bulk type-invoice" >
                            <div class="form-group col-md-12">
                                <h1>This transaction refunds following:</h1>
                                {include file='transactions/sublisting.tpl' listing=$refunded}
                            </div>
                        </div>

                        <hr>
                    {/if}


                    <div class="row type-bulk type-invoice" >
                        <div class="form-group col-md-12">
                            <h1>{$lang.relatedentries}</h1>
                            {if !$logentries}
                                {$lang.nothingwasfound}
                            {else}


                                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table table-fixed glike">
                                    <tbody>
                                    <tr>
                                        <th width="80px">{$lang.idhash}</th>
                                        <th>{$lang.Date}</th>
                                        <th>{$lang.Gateway}</th>
                                        <th width="60%">{$lang.Output}</th>
                                        <th width="120px">{$lang.Result}</th>
                                    </tr>
                                    </tbody>
                                    <tbody>
                                    {foreach from=$logentries item=log}
                                        <tr>
                                            <td>{$log.id}</td>
                                            <td>{$log.date|dateformat:$date_format}</td>
                                            <td><strong>{$log.module}</strong></td>
                                            <td>
                                                <div style="max-height:100px; max-width: 100%; overflow:auto">
                                                    <div style="{*display:none;*} white-space: pre; font-size:8pt;">{$log.output}</div>
                                                </div>
                                            </td>
                                            <td><span class="{$log.result}">{$lang[$log.result]}</span></td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            {/if}
                        </div>
                    </div>


                    {if !$forbidAccess.editTransactions}
                    <div style="text-align:center;margin:20px 0px;padding:15px 0px;" class="p6 secondtd">
                        <input class="btn btn-success" type="submit" id="form-submit" value="{$lang.savechanges}"  />

                    </div>
                    {/if}

                </div>

        </div>


            {include file="_common/quicklists.tpl" _placeholder=true}

    </div>
    </div>




    <div class="blu">
        <div class="menubar">
            <a href="?cmd=transactions"  data-pjax><strong>&laquo; {$lang.backtotransactions}</strong></a>

            <a class="setStatus menuitm menu-auto" name="markpaid" id="hd1">
                <span class="morbtn">Set status</span>
            </a>
            <a class="deleteInvoice menuitm menu-auto " name="delete" href="?cmd=transactions&make=delete&id={$transaction.id}&security_token={$security_token}"  onclick="return confirm('{$lang.deletetransconfirm}');">
                <span style="color:#FF0000">Delete</span>
            </a>
            <ul id="hd1_m" class="ddmenu">
                <li ><a href="?cmd=transactions&action=setstatus&security_token={$security_token}&id={$transaction.id}&status=Processing">{$lang.Processing}</a></li>
                <li ><a href="?cmd=transactions&action=setstatus&security_token={$security_token}&id={$transaction.id}&status=Success">{$lang.Success}</a></li>
                <li ><a href="?cmd=transactions&action=setstatus&security_token={$security_token}&id={$transaction.id}&status=Refunded">{$lang.Refunded}</a></li>
                <li ><a href="?cmd=transactions&action=setstatus&security_token={$security_token}&id={$transaction.id}&status=Chargeback">{$lang.Chargeback}</a></li>
        </div>


    </div>
    {literal}
        <script type="text/javascript">
            $(document).ready(function(){
                $('#client_id').change(function(){
                    var id = $(this).val();
                    $.get('?cmd=clients&action=getClientCurrency&id=' + id, function (data) {
                        if (data.currency) {
                            $('.currency_sign').text(data.currency.sign);
                            $('.currency_code').text(data.currency.code);
                        }
                    })
                });
            });

        </script>
    {/literal}
    {securitytoken}
</form>
