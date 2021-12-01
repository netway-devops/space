<article>
    {if $service}
        {include file='services/service_details.tpl'}
    {else}
        {if $services}
            {if $custom_template}
                {include file=$custom_template}
            {else}

                <h2><i class="icon-main-cog"></i> 
                    {if $action=='services' && $cid}
                        {foreach from=$offer item=o}{if $action=='services' && $cid==$o.id}{$o.name}
                            {/if}
                        {/foreach}
                    {else}
                        {$lang[$action]|capitalize}
                    {/if}
                </h2>
                <p>{$lang.listservices}</p>

                <div class="invoices-box clearfix no-height">
                    <ul id="invoice-tab" class="nav nav-tabs table-nav" data-filter="status">
                        <li class="active"><a href="#tab1" data-toggle="tab" data-filter=""><div class="tab-left"></div> {$lang.all}<div class="tab-right"></div></a></li>
                        <li><a href="#tab2" data-toggle="tab" data-filter="Active"><div class="tab-left"></div> {$lang.Active}<div class="tab-right"></div></a></li>
                        <li><a href="#tab3" data-toggle="tab" data-filter="Cancelled"><div class="tab-left"></div> {$lang.Cancelled}<div class="tab-right"></div></a></li>
                    </ul>
                    <div class="tab-content she">

                        <!-- Tab #1 -->
                        <div class="tab-pane active" id="tab1">
                            <div class="affiliates-box">
                                {*<div class="table-details">
                                    
                                    <div class="detailed-info">
                                        <span>4</span>
                                        <p>{$lang.total}</p>
                                    </div>
                                    <div class="detailed-info">
                                        <span class="Open-label">2</span>
                                        <p>{$lang.Active}</p>
                                    </div>
                                    <div class="detailed-info">
                                        <span class="Unpaid-label">12</span>
                                        <p>{$lang.Cancelled}</p>
                                    </div>
                                </div>*}

                                <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
                                <input type="hidden" id="currentpage" value="0" />
                                <table class="table styled-table fixed-table">
                                    <tr>
                                        <th class="w0"></th>
                                        <th class="w40"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=name|ASC"><i class="icon-sort"></i>{$lang.service}</a></th>
                                        <th><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=status|ASC"><i class="icon-sort"></i>{$lang.status}</a></th>
                                                {if $action=='vps'}
                                            <th>
                                                <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=domain|ASC"><i class="icon-sort"></i>{$lang.hostname}</a>
                                            </th>
                                            <th>{$lang.ipadd}</th>
                                            {else}
                                            <th>
                                                <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=total|ASC"><i class="icon-sort"></i>{$lang.price}</a>
                                            </th>
                                            <th>
                                                <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=billingcycle|ASC"><i class="icon-sort"></i>{$lang.bcycle}</a>
                                            </th>
                                        {/if}
                                        <th colspan="2">
                                            <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=next_due|ASC"><i class="icon-sort"></i>{$lang.nextdue}</a>
                                        </th>
                                        
                                    </tr>
                                    <tbody id="updater">
                                        {include file='ajax/ajax.services.tpl'}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            {/if}
            {if $totalpages}
                <div class="pagination c-pagination clearfix">
                    <ul rel="{$totalpages}">
                        <li class="pull-left dis"><a href="#"><i class="icon-pagin-left"></i> {$lang.previous}</a></li>
                        <li class="pull-right dis"><a href="#">{$lang.next} <i class="icon-pagin-right"></i></a></li>
                    </ul>
                </div>
            {/if}
        {else}
            <h2><i class="icon-main-cog"></i> 
                {$lang[$action]|capitalize}
            </h2>

            <p>{$lang.nothing}</p>

            {if $cid}
                {foreach from=$offer item=oo}
                    {if $cid==$oo.id && $oo.visible=='1'}
                        <form method="post" action="{$ca_url}cart&cat_id={$cid}" style="text-align: center">
                            <button  class="clearstyle btn c-orange-btn"  style="font-weight:bold;font-size:16px;padding:15px 10px;">
                                <i class="icon-shopping-cart icon-white"></i> {$lang.Add} {$oo.name}
                            </button>
                            {securitytoken}
                        </form>
                    {/if}
                {/foreach}
            {/if}

        {/if}
    {/if}
</article>