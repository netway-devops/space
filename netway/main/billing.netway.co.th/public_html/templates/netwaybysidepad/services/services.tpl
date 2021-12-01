{if $service}
    {include file='services/service_details.tpl'}
{else}
    {if $services}
        {if $custom_template}
        	{if $cid == 83}
        		{include file=$template_path|cat:'/services/cloudserver_list.tpl'}
        	{else}
        		{include file=$custom_template}
        	{/if}
        {else}
            <div class="text-block clear clearfix"  style="padding:17px 35px 17px 35px;"> <!-- Block A -->
                <div class="clear clearfix" style="padding: 20px 0px 0px 0px;">
                    
                     <h3 class=" g-txt32 re-topic"style="text-align: center;">{$lang[$action]|capitalize}</h3>
                     <center><span class="nw-2018-content-line" style="margin-bottom: 25px;"></span> </center> 
                   
                    <div class="table-box">
                        <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
                        <table class="table table-striped table-hover">                          
                            <tr class="table-header-high">
                                <th class="w30"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=name|ASC">{$lang.service}</a></th>
                                <th class="w15"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=status|ASC">{$lang.status}</a></th>
                                    {if $action=='vps'}
                                    <th class="w15 cell-border">
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=domain|ASC">{$lang.hostname}</a>
                                    </th>
                                    <th>{$lang.ipadd}</th>
                                    {else}
                                    <th class="w15 cell-border">
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=total|ASC">{$lang.price}</a>
                                    </th>
                                    <th>
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=billingcycle|ASC">{$lang.bcycle}</a>
                                    </th>
                                {/if}
                                <th class="w15 cell-border">
                                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=next_due|ASC">{$lang.nextdue}</a>
                                </th>
                                <th class="w10 cell-border"></th>
                            </tr>
                            <tbody id="updater">

                                {include file='ajax/ajax.services.tpl'}

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>  <!-- Block A -->
        {/if}
        <div class="top-btm-padding" style="padding:17px 35px 17px 35px;">
            {if $cid}
                {foreach from=$offer item=oo}
                    {if $cid==$oo.id && $oo.visible=='1'}
                        <form method="post" action="{$ca_url}cart&cat_id={$cid}" style="display:inline-block;">
                            <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Add} {$oo.name}</button>
                            {securitytoken}</form>
                        {/if}
                    {/foreach}
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
        <div class="text-block clear clearfix">
            <h5>{$lang[$action]|capitalize}</h5>
            <div class="clear clearfix">
                <center>
                    <strong>{$lang.nothing}</strong>
                </center>
                {if $cid}
                    {foreach from=$offer item=oo}
                        {if $cid==$oo.id && $oo.visible=='1'}
                            <form method="post" action="{$ca_url}cart&cat_id={$cid}">
                                <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Add} {$oo.name}</button>
                                {securitytoken}
                            </form>
                        {/if}
                    {/foreach}
                {/if}
            </div>
        </div>
    {/if}
{/if}