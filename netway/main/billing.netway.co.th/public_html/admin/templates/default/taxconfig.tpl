<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">


            {include file='configuration/leftmenu.tpl'}

        </td>
        <td valign="top" class="bordered">
            <div id="bodycont" style="">

                {include file="configuration/nav.tpl" picked_tab='5'}

                <div class="nicerblu" id="ticketbody">
                    <div id="newtab">
                        <div class="tabb">
                            {if !$enabletax}
                                <div class="imp_msg">
                                    <strong>{$lang.taxdisabled}</strong>
                                </div>
                            {/if}
                            <form action="" method="post">
                                <input type="hidden" name="action" value="changeconfig"/>
                                <table width="100%" cellpadding="10" cellspacing="0">
                                    <tr class="bordme">
                                        <td width="205" align="right">
                                            <strong>{$lang.enabletax}</strong></td>
                                        <td>
                                            <input type="radio" name="EnableTax"
                                                   {if $enabletax}checked{/if} value="on"/>
                                            <strong>{$lang.yes}, </strong> {$lang.EnableTax1}
                                            <br/>

                                            <input type="radio" name="EnableTax"
                                                   {if !$enabletax}checked{/if} value="off"/>
                                            <strong>{$lang.no}, </strong> {$lang.EnableTax2}
                                        </td>
                                    </tr>
                                    <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right">
                                            <strong>{$lang.taxtype}</strong>
                                        </td>
                                        <td>
                                            <select name="TaxType" class="form-control">
                                                <option {if $taxtype=='inclusive'}selected="selected"{/if}
                                                        value="inclusive">{$lang.inclusive|capitalize}
                                                </option>
                                                <option {if $taxtype=='exclusive'}selected="selected"{/if}
                                                        value="exclusive">{$lang.exclusive|capitalize}
                                                </option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr class="rest bordme tax_type inclusive" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right">
                                            <strong>Reference tax-exempt</strong>
                                            <a class="vtip_description"><span>
                                                Enable to override location based tax rate with selected rate
                                                    when calculating prices for tax exemption.
                                            </span></a>
                                        </td>
                                        <td>
                                            <select class="form-control" name="TaxInclusiveRate" id="TaxInclusiveRate"
                                                    data-val="{$taxconfig.TaxInclusiveRate}" >
                                                <option value="">Disabled</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right"><strong>{$lang.compoundl2}</strong></td>
                                        <td>
                                            <input type="radio" name="CompoundL2" {if $compoundl2}checked="checked"{/if}
                                                   value="on"/><strong>{$lang.yes}, </strong> {$lang.CompoundL21}
                                            <br/>
                                            <input type="radio" name="CompoundL2"
                                                   {if !$compoundl2}checked="checked"{/if}
                                                   value="off"/><strong>{$lang.no}, </strong> {$lang.CompoundL22}
                                        </td>

                                    </tr>
                                    <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right"><strong>{$lang.addtolatefee}</strong></td>
                                        <td>
                                            <input type="radio" name="TaxLateFee" {if $taxlatefee}checked="checked"{/if}
                                                   value="on"/><strong>{$lang.yes}, </strong> {$lang.TaxLateFee1}<br/>
                                            <input type="radio" name="TaxLateFee"
                                                   {if !$taxlatefee}checked="checked"{/if}
                                                   value="off"/><strong>{$lang.no}, </strong> {$lang.TaxLateFee2}
                                        </td>

                                    </tr>
                                    <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right"><strong>{$lang.applytodomains}</strong></td>
                                        <td>
                                            <input type="radio" name="TaxDomains" {if $taxdomains}checked="checked"{/if}
                                                   value="on"/><strong>{$lang.yes}, </strong> {$lang.TaxDomains1}<br/>
                                            <input type="radio" name="TaxDomains"
                                                   {if !$taxdomains}checked="checked"{/if}
                                                   value="off"/><strong>{$lang.no}, </strong> {$lang.TaxDomains2}

                                        </td>

                                    </tr>
                                    {if $taxtrackingstore}
                                        <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                            <td width="205" align="right"><strong>{$lang.TaxTimetracking}</strong></td>
                                            <td>
                                                <input type="radio" name="TaxTimetracking"
                                                       {if $taxtracking}checked="checked"{/if}
                                                       value="on"/><strong>{$lang.yes}
                                                    , </strong> {$lang.TaxTimetracking}<br/>
                                                <input type="radio" name="TaxTimetracking"
                                                       {if !$taxtracking}checked="checked"{/if}
                                                       value="off"/><strong>{$lang.no}
                                                    , </strong> {$lang.TaxTimetracking1}

                                            </td>

                                        </tr>
                                    {/if}
                                    <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right"><strong>Tax after credit</strong></td>
                                        <td>
                                            <input type="radio" name="TaxCredited"
                                                   {if $taxcredited}checked="checked"{/if}
                                                   value="on"/><strong>{$lang.yes}, </strong>
                                            calculate tax only from amount not covered by credit<br/>
                                            <input type="radio" name="TaxCredited"
                                                   {if !$taxcredited}checked="checked"{/if}
                                                   value="off"/><strong>{$lang.no}, </strong>
                                            calculate tax from net amount
                                        </td>
                                    </tr>
                                    <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right"><strong>Calculate Negative tax</strong></td>
                                        <td>
                                            <input type="radio" name="AllowNegativeTax"
                                                   {if $AllowNegativeTax}checked="checked"{/if}
                                                   value="on"/><strong>{$lang.yes}, </strong>
                                            calculate tax from items with negative ammount on all invoices<br/>
                                            <input type="radio" name="AllowNegativeTax"
                                                   {if !$AllowNegativeTax}checked="checked"{/if}
                                                   value="off"/><strong>{$lang.no}, </strong>
                                            allow negative tax only on Credit note invoices
                                        </td>
                                    </tr>
                                    <tr class="bordme tax_negative" {if !$AllowNegativeTax}style="display:none"{/if} >
                                        <td width="205" align="right"><strong>Tax discounts</strong></td>
                                        <td>
                                            <input type="radio" name="TaxOnDiscounts"
                                                   {if $TaxOnDiscounts}checked="checked"{/if}
                                                   value="on"/><strong>{$lang.yes}, </strong>
                                            calculate tax from discounts if its shown on invoice and related item contain tax<br/>
                                            <input type="radio" name="TaxOnDiscounts"
                                                   {if !$TaxOnDiscounts}checked="checked"{/if}
                                                   value="off"/><strong>{$lang.no}, </strong>
                                            do not calculate tax on discount invoice lines
                                        </td>
                                    </tr>

                                    <tr class="rest bordme tax_type exclusive"
                                        {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right"><strong>Tax Rounding</strong></td>
                                        <td>
                                            <input type="radio" name="TaxRounding"
                                                   {if $taxconfig.TaxRounding == 'item'}checked{/if}
                                                   value="item"/>
                                            Round tax for each item / invoice line<br/>
                                            <input type="radio" name="TaxRounding"
                                                   {if $taxconfig.TaxRounding == 'total'}checked{/if}
                                                   value="total"/>
                                            Round tax for total amount
                                        </td>
                                    </tr>
                                    <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right"><strong>{$lang.applytofunds}</strong></td>
                                        <td>
                                            <input type="radio" name="TaxClientFunds"
                                                   {if $taxclientfunds=='gross'}checked="checked"{/if}
                                                   value="gross"/><strong>{$lang.yes}, </strong> {$lang.TaxFunds3}<br/>
                                            <input type="radio" name="TaxClientFunds"
                                                   {if $taxclientfunds=='on'}checked="checked"{/if}
                                                   value="on"/><strong>{$lang.yes}, </strong> {$lang.TaxFunds1}<br/>
                                            <input type="radio" name="TaxClientFunds"
                                                   {if !$taxclientfunds || $taxclientfunds=='off'}checked="checked"{/if}
                                                   value="off"/><strong>{$lang.no}, </strong> {$lang.TaxFunds2}
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="2" class="tex-center">
                                            <button type="submit" class="btn btn-primary">
                                                {$lang.savechanges}
                                            </button>
                                        </td>
                                    </tr>

                                </table>
                                {securitytoken}
                            </form>

                            <div class="box rest" style="margin-top: 20px{if !$enabletax}display:none;{/if}"
                                 id="box-tax-rates">
                                <div class="box-header">
                                    <h3 class="box-title">
                                        <i class="fa fa-percent"></i>
                                        {$lang.taxrules}
                                    </h3>
                                </div>
                                <div class="empty-state panel-body" {if $taxes}style="display: none;"{/if}>
                                    <h3>{$lang.notaxrules}</h3>
                                    <span>{$lang.taxfewclicks}</span>
                                    <div class="clear"></div>
                                    <br>
                                    <a href="#" class="btn btn-default btn-sm add-tax-btn">
                                        <i class="fa fa-plus-square"></i>
                                        {$lang.addnewtax}
                                    </a>
                                    {$lang.Or|lcfirst}
                                    <a href="#" class="btn btn-default btn-sm add-premade-btn">
                                        <i class="fa fa-plus-square"></i>
                                        {$lang.usepremadetax}
                                    </a>
                                </div>
                                <div class="non-empty-state" {if !$taxes}style="display: none;"{/if}>
                                    <table class="table table-striped" id="tax-table" style="width:100%"></table>
                                    <div class="box-footer">
                                        <a href="#new" class="btn btn-xs btn-success add-tax-btn"
                                        >{$lang.addnewtax}</a>&nbsp;
                                        <a href="#premade" class="btn btn-xs btn-default add-premade-btn"
                                        >{$lang.addpremadetax}</a>&nbsp;
                                        <a href="?cmd=taxconfig&action=removealltaxes&security_token={$security_token}"
                                           class="btn btn-xs btn-danger del-all-btn">{$lang.removealltaxes}</a>
                                    </div>
                                </div>
                            </div>

                            <div class="box rest" style="margin-top: 20px{if !$enabletax}display:none;{/if}"
                                 id="box-tax-groups">
                                <div class="box-header">
                                    <h3 class="box-title">{$lang.taxgroups}</h3>
                                </div>
                                <table class="table table-striped" id="tax-group-table" style="width:100%">
                                    <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody id="tax-group-table-body"></tbody>
                                </table>
                                <div class="box-footer">
                                    <a href="#new" class="btn btn-xs btn-success add-group-btn"
                                    >Add group</a>&nbsp;
                                </div>
                            </div>

                            <div id="add-new-tax" style="display:none" hidden bootbox
                                 data-title="{$lang.addnewtax}" data-btnclass="btn-primary">

                                <form action="" method="post" class="clearfix">

                                    <div class="row">
                                        <div class="form-group col-md-4">
                                            <label>{$lang.Name}:</label>
                                            <input type="text" name="name" class="form-control" required/>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>{$lang.Level}:</label>
                                            <select name="type" class="form-control">
                                                <option>1</option>
                                                <option>2</option>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>{$lang.taxrate}</label>
                                            <input type="text" name="rate" value="0.00" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.Group}:</label>

                                        <select name="group_id" class="form-control tax-group-select">
                                            {foreach from=$tax_groups item=taxg}
                                                <option value="{$taxg.id}">{$taxg.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>{$lang.country}:</label>
                                        <div class="radio option-pick">
                                            <label>
                                                <input type="radio" checked="" value="0" name="countrypick"/>
                                                {$lang.applytoallcountries}
                                            </label>
                                        </div>

                                        <div class="radio option-pick">
                                            <label>
                                                <input type="radio" value="1" name="countrypick"/>
                                                {$lang.applytospecificc}
                                            </label>
                                        </div>

                                        <select name="country" class="form-control" disabled>
                                            {foreach from=$countries key=k item=v}
                                                <option value="{$k}">{$v}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="form-group" class="tax-state">
                                        <label>{$lang.State}:</label>
                                        <div class="radio option-pick">
                                            <label>
                                                <input type="radio" checked="" value="0" name="statepick"/>
                                                {$lang.applytoallstates}
                                            </label>
                                        </div>

                                        <div class="radio option-pick">
                                            <label>
                                                <input type="radio" value="1" name="statepick"/>
                                                {$lang.applytospecifics}
                                            </label>
                                        </div>

                                        <input type="text" name="state" class="form-control" disabled/>
                                    </div>

                                    <input type="hidden" value="addtax" name="action"/>
                                    {securitytoken}
                                </form>
                            </div>

                            <div id="add-premade-tax" style="display:none" hidden bootbox
                                 data-title="{$lang.addpremadetax}" data-btnclass="btn-primary">
                                <form action="" method="post">
                                    <div class="form-group">
                                        <label> {$lang.choosecountry}&nbsp;</label>
                                        <select name="country" id="ct_" class="form-control">
                                            {foreach from=$premade item=v}
                                                {if $countries.$v || $lang.$v}
                                                    <option value="{$v}">
                                                        {if $countries.$v}{$countries.$v}{else}{$lang.$v}{/if}
                                                    </option>
                                                {/if}
                                            {/foreach}
                                        </select>
                                    </div>

                                    <input type="hidden" value="addpremadetax" name="action"/>
                                    {securitytoken}
                                </form>
                            </div>

                            <div id="edit-tax-group" style="display:none" hidden bootbox
                                 data-title="Add Tax Group" data-btnclass="btn-primary">
                                <form action="?cmd=taxconfig&action=group_edit" method="post">
                                    <div class="form-group">
                                        <label>Name</label>
                                        <input type="text" name="name" class="form-control" value=""/>
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea name="description" class="form-control"></textarea>
                                    </div>
                                    <input type="hidden" name="id" value="new"/>
                                    {securitytoken}
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>
<link href="{$template_dir}dist/plugins/datatables/dataTables.bootstrap.min.css?v={$hb_version}" type="text/css"
      rel="stylesheet">
<script src="{$template_dir}dist/plugins/datatables/jquery.dataTables.min.js?v={$hb_version}"></script>
<script src="{$template_dir}dist/plugins/datatables/dataTables.bootstrap.min.js?v={$hb_version}"></script>
<script src="{$template_dir}js/taxconfig.js?v={$hb_version}"></script>
{literal}
    <script type="text/x-handlebars-template" id="tax-rate-select-tpl">
        <option value="">Disabled</option>
        {{#each rates}}
            <option value="{{id}}">{{country}} - {{name}} {{rate}}%</option>
        {{/each}}
    </script>
    <script type="text/x-handlebars-template" id="tax-groups-select-tpl">
        {{#each groups}}
            <option value="{{id}}">{{name}}</option>
        {{/each}}
    </script>
    <script type="text/x-handlebars-template" id="tax-groups-tpl">
        {{#each groups}}
        <tr id="tax-group-{{id}}">
            <td>{{name}}</td>
            <td>{{description}}</td>
            <td class="text-right">
                {{#if editable}}
                <a class="btn btn-xs btn-default edit-group-btn" href="#edit"
                   title="{{../lang.Edit}}">
                    <i class="fa fa-edit"></i>
                </a>
                <a class="btn btn-xs btn-default rm-group-btn" href="?cmd=taxconfig&action=group_del&id={{id}}&security_token={{../sctoken}}"
                   title="{{../lang.Delete}}">
                    <i class="fa fa-trash-o"></i>
                </a>
                {{/if}}
            </td>
        </tr>
        {{/each}}
    </script>
<script>
    $(function () {
        var data = {/literal}{$taxes|@json_encode}{literal},
            countries = {/literal}{$countries|@json_encode}{literal},
            tax_groups = {/literal}{$tax_groups|@json_encode}{literal},
            lang = {/literal}{$jslang|@json_encode}{literal};

        taxConfigInit(data, lang, countries, tax_groups);
    })
</script>
{/literal}