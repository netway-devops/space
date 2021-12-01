{if $edit}
    {include file='services/domain_details.tpl'}
{else}
    <div class="text-block clear clearfix">
        <h5>{$lang.domains|capitalize}</h5>
        {if $domains || $currentfilter}
            <div class="input-bg pull-right search-shadow">
                <form style="margin:0px" id="testform" href="{$ca_url}clientarea/domains/" method="post">
                    <input type="text" class="search-field" name="filter[name]" value="{$currentfilter.name}" placeholder="{$lang.filterdomains}" id="d_filter"  >
                    <button type="submit" class="clearstyle" name="resetfilter=1" id="r_filter"  onclick="$('#d_filter').val(''); $('#r_filter').hide()">
                        <i class="icon-search"></i>
                    </button>				
                </form>
            </div>
        {/if}
        {if $domains}
            <div class="clear clearfix">
                <div class="table-box">
                    <div class="table-header">
                        <p class="inline-block"><i class="icon-select-all"></i> {$lang.withdomains} </p>
                        <div class="tooltip-group">
                            <a href="{$ca_url}clientarea/domains/renew/" title="{$lang.renew_widget}" class="clearstyle btn domain-header-icon">
                                <i class="icon-bag"></i>
                            </a>

                            {if $domwidgets}
                                {foreach from=$domwidgets item=widg}

                                    {assign var=widg_name value="`$widg.name`_widget"}

                                    <a href="{$ca_url}clientarea/domains/bulkdomains/&widget={$widg.widget}" title="{*
                                      *} {if $lang[$widg_name]}{*
                                          *} {$lang[$widg_name]}{*
                                       *}{elseif $lang[$widg.widget]}{*
                                           *}{$lang[$widg.widget]}{*
                                      *}{else}{*
                                           *}{$widg.name}{*
                                       *}{/if}" 
                                       class="clearstyle btn domain-header-icon">
                                        <img alt="{$widg.name}" src="{$system_url}{$widg.config.smallimg}" />
                                    </a>
                                {/foreach} 
                            {/if}

                            <!--                        <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-contacts"></i></a>
                                                    <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-forward"></i></a>
                                                    <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-cycle"></i></a>
                                                    <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-lock"></i></a>
                                                    <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-address"></i></a>-->
                        </div>
                    </div>
                    <a href="{$ca_url}clientarea&amp;action=domains" id="currentlist" style="display:none" updater="#updater"></a>
                    <table class="table table-striped table-hover">
                        <tr class="table-header-high">
                            <th><input type="checkbox" onclick="c_all(this)" /></th>
                            <th class="w30"><a class="sortorder" href="{$ca_url}clientarea/domains/&amp;orderby=name|ASC">{$lang.domain}</a></th>
                            <th class="w15"><a class="sortorder" href="{$ca_url}clientarea/domains/&amp;orderby=date_created|ASC">{$lang.registrationdate}</a></th>
                            <th class="w15 cell-border"><a class="sortorder" href="{$ca_url}clientarea/domains/&amp;orderby=expires|ASC">{$lang.expirydate}</a></th>
                            <th class="w10 cell-border"><a class="sortorder" href="{$ca_url}clientarea/domains/&amp;orderby=expires|ASC">{$lang.status}</a></th>
                            {*<th class="w15 cell-border">{$lang.autorenew}</th>*}
                            <th class="w10 cell-border"></th>
                        </tr>
                        <tbody id="updater">

                            {include file='ajax/ajax.domains.tpl'}

                        </tbody>
                    </table>
                </div>
                <div class="top-btm-padding">
                    {if $lang.add_domain}
                        <form method="post" action="{$ca_url}checkdomain" style="display:inline-block">
                            <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-white-add"></i> {$lang.add_domain}</button>
                            {securitytoken}
                        </form>
                    {/if}
                    {if $totalpages}
                        <div class="pagination pagination-box">
                            <div class="right p19 pt0 no-margin">
                                <div class="pagelabel left ">{$lang.page}</div>
                                <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
                                    {section name=foo loop=$totalpages}
                                        <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
                                    {/section}
                                </div>
                                <input type="hidden" id="currentpage" value="0" />
                            </div>
                        </div>
                    {/if}
                </div>
            {else}
                {$lang.nothing}
                {if $lang.add_domain}
                    <form method="post" action="{$ca_url}checkdomain">
                        <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.add_domain}</button>
                        {securitytoken}
                    </form>
                {/if}
            {/if}
        </div>
    </div>
{/if}
<script type="text/javascript" src="{$template_dir}js/domains.js"></script>
