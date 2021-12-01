<div class="product-billing form-horizontal" data-currency="{$currency|@json_encode|escape}">
    <div class="container-fluid">
        <div class="billing-cycles">
            {foreach from=$billingoptions.cycles item=price}
                <div id="{$price.cycle}pricing" class="cycle clearfix"
                     data-cycle="{$price.cycle}"
                     data-price="{$price.recurring}"
                     data-setup="{$price.setup}"
                     data-upgrade="{$price.upgrade}">

                    <div class="col-xs-4 col-md-2 pull-right text-right">
                        <div class="btn-group">
                            <a href="#" class="btn btn-sm btn-default edit" title="{$lang.Edit}">
                                <i class="fa fa-pencil"></i>
                            </a>
                            <a href="#" class="btn btn-sm btn-default delete" title="{$lang.Delete}">
                                <i class="fa fa-trash-o"></i>
                            </a>
                        </div>
                    </div>

                    <label class="col-md-2 col-lg-2 control-label cycle-type">
                        {if $price.year}{$price.year} {$lang.Year}
                        {else}{$lang[$price.cycle]}
                        {/if}
                    </label>

                    <div class="col-md-8 col-lg-8">
                        <div class="e1 row">
                            <div class="col-md-4">
                                {$lang.Price}:
                                <strong class="pricer">{$price.recurring|price}</strong>
                            </div>
                            <div class="col-md-4 price-setup">
                                {$lang.setupfee}:
                                <strong class="pricer_setup">{$price.setup|price}</strong>
                            </div>
                            <div class="col-md-4 price-upgrade">
                                {$lang.upgradefee}:
                                <strong class="pricer_upgrade">{$price.upgrade|price}</strong>
                            </div>
                        </div>
                        <div class="e2 row form-inline" hidden>
                            <div class="col-md-4">
                                {$lang.Price}:
                                <input type="text" value="{$price.recurring|price:$currency:false}" size="6"
                                       name="{$price.cycle}"
                                       class="form-control input-sm input-price"/>
                            </div>
                            <div class="col-md-4">
                                {$lang.setupfee}:
                                <input type="text" value="{$price.setup|price:$currency:false}" size="6"
                                       name="{$price.cycle}_setup"
                                       class="form-control input-sm input-price-setup"/>
                            </div>
                            <div class="col-md-4">
                                {$lang.upgradefee}:
                                <input type="text" value="{$price.upgrade|price:$currency:false}" size="6"
                                       name="{$price.cycle}_upgrade"
                                       class="form-control input-sm input-price-upgrade"/>
                            </div>
                        </div>
                    </div>

                </div>
            {/foreach}
        </div>
        <div id="tbpricing" hidden class="row new-cycle">
            <div class="col-md-2 col-lg-2 cycle-type">
                <label class="hidden-md	hidden-lg">
                    {$lang.billingcycle}:
                </label>
                <select id="billing-cycle-select" class="form-control input-sm">
                    {foreach from=$billingoptions.cycles item=price}
                        <option value="{$price.cycle}">
                            {if $price.year}{$price.year} {$lang.Year}
                            {else}{$lang[$price.cycle]}
                            {/if}
                        </option>
                    {/foreach}
                </select>
            </div>
            <div class="col-md-8 col-lg-8">
                <div class="row form-inline input-price-row">
                    <div class="col-md-4">
                        {$lang.Price}:
                        <input type="text" value="{'0'|price:$currency:false}" size="6" data-type="price"
                               class="form-control input-sm input-price"/>
                    </div>
                    <div class="col-md-4">
                        {$lang.setupfee}:
                        <input type="text" value="{'0'|price:$currency:false}" size="6" data-type="setup"
                               class="form-control input-sm input-price-setup"/>
                    </div>
                    <div class="col-md-4">
                        {$lang.upgradefee}:
                        <input type="text" value="{'0'|price:$currency:false}" size="6" data-type="upgrade"
                               class="form-control input-sm input-price-upgrade"/>
                    </div>
                </div>
            </div>
            <div class="col-sm-2">
                <button type="button" id="add-cycle" class="btn btn-primary btn-sm">{$lang.Add}</button>
                <span class="orspace">{$lang.Or}</span>
                <a href="#" class="editbtn" id="hidepricingadd">{$lang.Cancel}</a>
            </div>
        </div>

        <div class="billing-options">
            {if $billingoptions.postbiling}
                <div class="form-group">
                    <label class="col-md-2 col-xs-4 control-label sm">
                        Billing type
                        <i class="vtip_description fa-info-circle">
                            <span>
                                - <b>Pre-Paid</b> - issue invoice a the start of billing period.
                                All upgrades and addons are charged immediately. <br/>
                                - <b>Post-Paid</b> - issue invoice at the end of billing period.
                                Upgrade charges are added to service’s next invoice.
                            </span>
                        </i>
                    </label>

                    <div class="col-lg-2 col-md-3 col-xs-8">
                        <select name="config[RecurringBillingType]" class="form-control">
                            <option {if $configuration.RecurringBillingType=='PrePay'}selected="selected"{/if}
                                    value="PrePay"> Pre-Paid (Standard)
                            </option>
                            <option {if $configuration.RecurringBillingType=='PostPay'}selected="selected"{/if}
                                    value="PostPay"> Post-Paid
                            </option>
                        </select>
                    </div>
                </div>
            {/if}
        </div>

    </div>

        <div id="add-cycle-area" class="well">
            <a href="#" class="btn btn-sm btn-default" id="addpricing">
                <i class="fa fa-plus-square"></i> {$lang.addpricingoption}
            </a>

        </div>
</div>
{once}
    <script type="text/javascript" src="{$template_dir}js/productbilling.js?v={$hb_version}"></script>
{/once}