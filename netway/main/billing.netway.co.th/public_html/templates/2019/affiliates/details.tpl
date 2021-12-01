{include file="affiliates/top_nav.tpl"}

<h5 class="my-5">{$lang.affiliate_description}</h5>


<section class="section-affiliates">
    <h3 class="mb-3 mt-4">{$lang.Statistics}</h3>
    <div class="table-responsive table-borders table-radius">
        <table class="table position-relative">
            <tr>
                <td class="w-50">{$lang.Commissions}:</td>
                <td><strong>{$stats.monthly_commision}</strong> / <strong>{$stats.total_commision}</strong> ({$lang.thismonth} / {$lang.total})</td>
            </tr>
            <tr>
                <td class="w-50">{$lang.referred} </td>
                <td>{$stats.monthly_visits} / {$stats.total_visits} ({$lang.thismonth} / {$lang.total})</td>
            </tr>
            <tr>
                <td class="w-50">{$lang.singupreferred}</td>
                <td>{$stats.monthly_singups} / {$stats.total_singups} ({$lang.thismonth} / {$lang.total})</td>
            </tr>
            <tr>
                <td class="w-50"><strong>{$lang.curbalance}</strong></td>
                <td>{$affiliate.balance|price:$affiliate.currency_id}</td>
            </tr>
            <tr >
                <td class="w-50">{$lang.reflink}</td>
                <td ><a class="font-weight-bold" href="{$system_url}?affid={$affiliate.id}">{$system_url}?affid={$affiliate.id}</a></td>
            </tr>
            {if $payout}
                <tr>
                    <td>{$lang.withdrawinfo}</td>
                    <td><a href="{$ca_url}tickets/new/" class="btn btn-primary btn-small"><i class="icon-ok-sign icon-white"></i> {$lang.payout}</a></td>
                </tr>
            {/if}
        </table>
    </div>
    <h3 class="mb-3 mt-5">{$lang.options}</h3>
    <div class="table-responsive table-borders table-radius" style="overflow-x: auto;">
        <table class="table position-relative affiliates_options">
            <tr>
                <td class="w-50">{$lang.emailoncemonth}:</td>
                <td>
                    <input type="radio" value="1" name="sendreport" {if $affiliate.sendreport}checked="checked"{/if}/> {$lang.enable} &nbsp; &nbsp;
                    <input type="radio" value="0" name="sendreport" {if !$affiliate.sendreport}checked="checked"{/if}/> {$lang.disable}
                </td>
            </tr>
            {if $autopay}
                <tr >
                    <td class="w-50">{$lang.receivecommissionsauto}</td>
                    <td >
                        <select name="withdraw_method">
                            <option {if $affiliate.withdraw_method==0}selected="selected"{/if} value="0">{$lang.disable}</option>
                            {foreach from=$autopay item=value key=name}
                                <option {if $affiliate.withdraw_method==$value}selected="selected"{/if} value="{$value}">{$lang[$name]}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
            {/if}
            {if $landingpage}
                <tr>
                    <td class="w-50">{$lang.landingpage}<a href="#" class="vtip_description" title="{$lang.landurldescr}" ></a></td>
                    <td><a class="font-weight-bold" href="{$landingpage}" data-toggle="modal" data-target="#landinglink" data-remote="false">{$landingpage}</a></td>
                </tr>
            {/if}
        </table>
    </div>
    {if $campaigns }
        <h3 class="mb-3 mt-5">{$lang.affcampaigns}</h3>
        {foreach from=$campaigns item=campaign}
            <div class="border rounded mb-3 p-4">
                <h4>{$campaign.name}</h4>
                <a class="font-weight-bold" href="{$system_url}?affid={$affiliate.id}&campaign={$campaign.campid}">{$system_url}?affid={$affiliate.id}&campaign={$campaign.campid}</a>
                <p class="text-muted">{$campaign.description}</p>
                {if $campaign.banners}
                    <h5 class="mb-2 mt-5">{$lang.intcodes}</h5>
                    <nav class="nav-tabs-wrapper mt-2">
                        <ul class="nav nav-tabs d-flex justify-content-between align-items-center flex-nowrap" role="tablist">
                            <li>
                                <ul class="nav nav-slider flex-nowrap" >
                                    {foreach from=$campaign.banners key=banner_key item=banner name=catiter}
                                        <li class="nav-item {if $smarty.foreach.catiter.iteration == 1}active{/if}">
                                            <a class="nav-link" id="nav-{$banner_key}-tab" data-toggle="tab" href="#nav-{$banner_key}" role="tab">{$banner.name|lang}</a>
                                        </li>
                                    {/foreach}
                                </ul>
                            </li>
                        </ul>
                    </nav>
                    <div class="tab-content">
                        {foreach from=$campaign.banners key=banner_key item=banner name=catiter}
                            <div class="tab-pane fade {if $smarty.foreach.catiter.iteration == 1}active show{/if}" id="nav-{$banner_key}" role="tabpanel">
                                {foreach from=$banner.inputs key=lang_key item=input}
                                    {if $input && $language == $lang_key}
                                        <pre class="alert alert-default text-wrap">{$input|escape}</pre>
                                        {$input}
                                    {/if}
                                {/foreach}
                            </div>
                        {/foreach}
                    </div>
                {/if}
            </div>
        {/foreach}
    {/if}
    {if $integration_code!=''}
        <h3 class="mb-3 mt-5">{$lang.intcodes}</h3>
        <div class="table-responsive table-borders table-radius">
            <table class="table position-relative">
                <tr>
                    <td class="py-5">
                        <pre class="alert alert-default">{$integration_code|escape}</pre>
                        {$integration_code}
                    </td>
                </tr>
            </table>
        </div>
    {/if}
    {if $integration_banners}
        <h3 class="mb-3 mt-5">{$lang.intcodes}</h3>
        <nav class="nav-tabs-wrapper mt-2">
            <ul class="nav nav-tabs d-flex justify-content-between align-items-center flex-nowrap" role="tablist">
                <li>
                    <ul class="nav nav-slider flex-nowrap" >
                        {foreach from=$integration_banners key=category_key item=category name=catiter}
                            <li class="nav-item {if $smarty.foreach.catiter.iteration == 1}active{/if}">
                                <a class="nav-link" id="nav-{$category_key}-tab" data-toggle="tab" href="#nav-{$category_key}" role="tab">{$category.name|lang}</a>
                            </li>
                        {/foreach}
                    </ul>
                </li>
            </ul>
        </nav>
        <div class="tab-content">
            {foreach from=$integration_banners key=category_key item=category name=catiter}
                <div class="tab-pane fade {if $smarty.foreach.catiter.iteration == 1}active show{/if}" id="nav-{$category_key}" role="tabpanel">
                    <div class="table-responsive table-borders table-radius">
                        <table class="table position-relative">
                            {foreach from=$category.banners item=lang_banners}
                                {foreach from=$lang_banners key=lang_key item=banner}
                                    {if $banner && $language == $lang_key}
                                        <tr>
                                            <td class="py-5">
                                                <pre class="alert alert-default">{$banner|escape}</pre>
                                                {$banner}
                                            </td>
                                        </tr>
                                    {/if}
                                {/foreach}
                            {foreachelse}
                                <tr>
                                    <td class="py-5 text-center">
                                        {$lang.nothing}
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                </div>
            {/foreach}
        </div>
    {/if}
</section>

<div class="modal fade" id="landinglink" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title font-weight-bold mt-2">{$lang.landingpage}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <i class="material-icons">cancel</i>
                </button>
            </div>
            <div class="modal-body">
                <form method="POST" action="{$ca_url}affiliates/" class="form-horizontal">
                    <label>{$lang.enternewlandingurl}</label>
                    <input type="text" name="landingurl" id="landingurl" placeholder="{$landingpage}" data-domain="{$validationhost|escape}" class="form-control affiliates_landing_input w-100">
                    <button class="btn btn-primary btn-lg w-100 affiliates_landing_btn mt-4">{$lang.savechanges}</button>
                </form>
            </div>
        </div>
    </div>
</div>
