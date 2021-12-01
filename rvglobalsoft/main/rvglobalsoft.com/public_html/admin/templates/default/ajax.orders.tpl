{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.orders.tpl.php');
{/php}

{if $action =='frauddetails'}
    {if $fraud_out}
        {include file="orders/step_FraudCheck.tpl"}
    {/if}
{elseif $action == 'getadvanced'}
    <a href="?cmd=orders&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=orders" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>
{elseif $action=='get_product'}
    {if $product}
        <tr>
            <td colspan="2"><h3>{$lang.productdetails}</h3></td>
        </tr>
        <tr>
            <td width="25%">{$lang.billingcycle}</td>
            <td>
                {if $product.paytype=='Free'}
                    <input type="hidden" name="cycle" value="Free" />{$lang.freeproduct}
                {elseif $product.paytype=='Once'}
                    <input type="hidden" name="cycle" value="Once" />
                    {if $admindata.access.viewOrdersPrices}{$product.m|price:$currency} {$lang.Once} / {$product.m_setup|price:$currency} {$lang.setupfee}{/if}
                {else}
                    <select name="cycle">
                        {if $product.h!='0.00'}
                            <option value="h">{if $admindata.access.viewOrdersPrices}{$product.h|price:$currency}{/if} {$lang.Hourly}</option>
                        {/if}
                        {if $product.d!='0.00'}        
                            <option value="d">{if $admindata.access.viewOrdersPrices}{$product.d|price:$currency}{/if} {$lang.Daily}</option>
                        {/if}
                        {if $product.w!='0.00'}
                            <option value="w">{if $admindata.access.viewOrdersPrices}{$product.w|price:$currency}{/if} {$lang.Weekly}</option>
                        {/if}
                        {if $product.m!='0.00'}        
                            <option value="m">{if $admindata.access.viewOrdersPrices}{$product.m|price:$currency}{/if} {$lang.Monthly}</option>
                        {/if}
                        {if $product.q!='0.00'}        
                            <option value="q">{if $admindata.access.viewOrdersPrices}{$product.q|price:$currency}{/if} {$lang.Quarterly}</option>
                        {/if}
                        {if $product.s!='0.00'}        
                            <option value="s">{if $admindata.access.viewOrdersPrices}{$product.s|price:$currency}{/if} {$lang.SemiAnnually}</option>
                        {/if}
                        {if $product.a!='0.00'}        
                            <option value="a">{if $admindata.access.viewOrdersPrices}{$product.a|price:$currency}{/if} {$lang.Annually}</option>
                        {/if}
                        {if $product.b!='0.00'}        
                            <option value="b">{if $admindata.access.viewOrdersPrices}{$product.b|price:$currency}{/if} {$lang.Bienially}</option>
                        {/if}
                        {if $product.t!='0.00'}
                            <option value="t">{if $admindata.access.viewOrdersPrices}{$product.t|price:$currency}{/if} {$lang.Triennially}</option>
                        {/if}
                        {if $product.p4!='0.00'}
                            <option value="p4">{if $admindata.access.viewOrdersPrices}{$product.p4|price:$currency}{/if} {$lang.Quadrennially}</option>
                        {/if}
                        {if $product.p5!='0.00'}
                            <option value="p5">{if $admindata.access.viewOrdersPrices}{$product.p5|price:$currency}{/if} {$lang.Quinquennially}</option>
                        {/if}
                    </select>
                {/if} 
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top" >{$lang.Addons}</td>
            <td>
                {if $addons}
                    {foreach from=$addons item=addon key=addon_id}
                        {if $addon_id!='categories'}
                            <input type="checkbox" name="addon[{$addon_id}]" value="1" /><strong>{$addon.name}</strong>{if $addon.description!=''} - {$addon.description}{/if}<br />
                            {/if}
                        {/foreach}
                    {else}
                        {$lang.noaddonsforproduct}
                    {/if}
            </td>
        </tr>
    {/if}

{elseif $action=='whois'}
    {if $available}
        <span style="color:green">{$lang.Available} !</span>
    {else}
        <span style="color:red">{$lang.Notavailable} 
            <a href="http://{$domain_name}" target="_blank">www</a> 
            <a href="{$system_url}?cmd=checkdomain&action=whois&domain={$domain_name}&security_token={$security_token}"
               onclick="window.open(this.href, 'WHOIS', 'width=500, height=500, scrollbars=1');
                       return false">whois</a>
        </span>
    {/if}
{elseif $action=='getperiod'}
    {if $period}
        <select name="domain_period">
            {foreach from=$period item=years}
                <option value="{$years}" {if $years == $submit.domain_period}selected="selected" {/if}>{$years}{if $years == 1} {$lang.Year}{else} {$lang.Years}{/if}</option>
            {/foreach}
        </select>  
    {else}
        {$lang.cantgetperiods}.
    {/if}
{elseif $action=='clientorders'}
    <div class="quitlist_orders">
        <div class="clearfix" style="padding-bottom: 5px;">
            <div class="col-sm-12">
                <div class="row">
                    <div class="pull-right">
                        {include file='ajax.filterquicktool.tpl' client_id=$client_id loadid='ordersfilter' href="?cmd=orders&action=getadvanced"}
                        <a href="?cmd=orders&action=add&related_client_id={$client_id}" class="btn btn-primary btn-xs" target="_blank"><i class="fa fa-plus"></i> {$lang.neworder}</a>
                    </div>
                    <ul class="nav nav-tabs">
                        <li {if $orders || (!$orders && !$draft)}class="active"{/if}>
                            <a href="#" style="padding: 5px 15px; text-decoration: none; border-radius: 3px 3px 0 0;" onclick="change_tab('?cmd=orders&action=clientorders&id={$client_id}');">Regular Orders</a>
                        </li>
                        <li {if $drafts || (!$drafts && $draft)}class="active"{/if}>
                            <a href="#" style="padding: 5px 15px; text-decoration: none; border-radius: 3px 3px 0 0;" onclick="change_tab('?cmd=orders&action=clientorders&id={$client_id}&draft=1');">Draft Orders</a>
                        </li>
                    </ul>
                </div>

            </div>
        </div>
        {if $orders}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <tbody>
                <tr>
                    <th><a href="?cmd=orders&action=clientorders&id={$client_id}" class="sortorder" data-orderby="id">ID</a></th>
                    <th><a href="?cmd=orders&action=clientorders&id={$client_id}" class="sortorder" data-orderby="number">{$lang.orderhash}</a></th>
                    <th><a href="?cmd=orders&action=clientorders&id={$client_id}" class="sortorder" data-orderby="date_created">{$lang.Date}</a></th>
                    {if $admindata.access.viewOrdersPrices}
                        <th><a href="?cmd=orders&action=clientorders&id={$client_id}" class="sortorder" data-orderby="total">{$lang.Total}</a></th>
                    {/if}
                    <th><a href="?cmd=orders&action=clientorders&id={$client_id}" class="sortorder" data-orderby="module">{$lang.paymethod}</a></th>
                    <th>{$lang.paymentstatus}</th>
                    <th><a href="?cmd=orders&action=clientorders&id={$client_id}" class="sortorder" data-orderby="status">{$lang.Status}</a></th>
                </tr>
                </tbody>
                <tbody>
                {foreach from=$orders item=order}
                
                    <tr>
                        <td><a href="?cmd=orders&action=edit&id={$order.id}">{$order.id}</a></td>
                        <td><a href="?cmd=orders&action=edit&id={$order.id}">{$order.number}</a></td>
                        <td>{$order.date_created|dateformat2:$date_format}</td>
                        {if $admindata.access.viewOrdersPrices}
                            <td>{$order.total|price:$order.currency_id}</td>
                        {/if}
                        <td>{if $order.total<0}{$lang.amountcredited}{else}{$order.module}{/if}</td>
                        <td><span class="{$order.balance}">{$lang[$order.balance]}</span></td>
                        <td><span class="{$order.status}">{$lang[$order.status]}</span></td>

                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="text-center" style="margin-top: 10px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="orders_per_page" id="orders_per_page">
                        <option value="10" {if $orders_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $orders_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $orders_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $orders_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $orders_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                    <center class="blu paginercontainer" >
                        <strong>{$lang.Page} </strong>
                        {section name=foo loop=$totalpages}
                            <a href='?cmd=orders&action=clientorders&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer
                                   {if $smarty.section.foo.iteration-1==$currentpage}
                                       currentpage
                                   {/if}"
                            >{$smarty.section.foo.iteration}</a>

                        {/section}
                    </center>
                </div>
            </div>
        {elseif $drafts}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <tbody>
                <tr>
                    <th><a href="?cmd=orders&action=clientorders&id={$client_id}&draft=1" class="sortorder" data-orderby="id">ID</a></th>
                    <th><a href="?cmd=orders&action=clientorders&id={$client_id}&draft=1" class="sortorder" data-orderby="date_created">{$lang.Date}</a></th>
                    {if $admindata.access.viewOrdersPrices}
                        <th><a href="?cmd=orders&action=clientorders&id={$client_id}&draft=1" class="sortorder" data-orderby="total">{$lang.Total}</a></th>
                    {/if}
                    <th><a href="?cmd=orders&action=clientorders&id={$client_id}&draft=1" class="sortorder" data-orderby="module">{$lang.paymethod}</a></th>
                    <th>{$lang.Status}</th>
                </tr>
                </tbody>
                <tbody>

                {foreach from=$drafts item=draft}
                    <tr>
                        <td><a href="?cmd=orders&action=createdraft&id={$draft.id}">{$draft.id}</a></td>
                        <td>{$draft.date_created|dateformat:$date_format}</td>
                        {if $admindata.access.viewOrdersPrices}
                            <td>{$draft.total|price:$draft.currency_id}</td>
                        {/if}
                        <td>{if $draft.total<0}{$lang.amountcredited}{else}{$draft.module}{/if}</td>
                        <td><span class="{$draft.status}">{$lang[$draft.status]}</span></td>

                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="text-center" style="margin-top: 10px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="orders_per_page_draft" id="orders_per_page_draft">
                        <option value="10" {if $orders_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $orders_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $orders_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $orders_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $orders_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                    <center class="blu paginercontainer" >
                        <strong>{$lang.Page} </strong>
                        {section name=foo loop=$totalpages}
                            <a href='?cmd=orders&action=clientorders&id={$client_id}&page={$smarty.section.foo.iteration-1}&draft=1' class="npaginer
                                   {if $smarty.section.foo.iteration-1==$currentpage}
                                       currentpage
                                   {/if}"
                            >{$smarty.section.foo.iteration}</a>
                        {/section}
                    </center>
                </div>
            </div>
        {else}
            <p style="text-align: center">{$lang.nothingtodisplay}</p>
        {/if}
        {literal}
        <script>
            function change_tab(link) {
                $.post(link, false, function (result) {
                    $('.quitlist_orders').html(result);
                    pagination();
                });
            }
        </script>
        {/literal}
        {if $orders || $drafts}
            <script>
                {literal}
                $(function () {
                    pagination();
                });

                function pagination() {
                    $('.paginercontainer', 'div.slide:visible').infinitepages();
                    FilterModal.bindsorter('{/literal}{$orderby.orderby}', '{$orderby.type}'{literal});
                    $('#orders_per_page, #orders_per_page_draft').on('change', function () {
                        var form_client = {orders_per_page: $(this).val()},
                            url = "?cmd=orders&action=clientorders&id={/literal}{$client_id}{literal}",
                            name = $(this).attr('name');
                            if (name == 'orders_per_page_draft') {
                                url += '&draft=1';
                            }
                        ajax_update(url, form_client, $('div.slide:visible'), true);
                    });
                }
                {/literal}
            </script>
        {/if}
    </div>
{elseif $action=='getextended'}
    {if $extended}
        <table width="100%" cellspacing="1" cellpadding="1" border="0">
            <tr>
                <td colspan="2">
                    <h3>{$lang.extendedattribs}</h3>
                </td>
            </tr>
            {foreach from=$extended item=attribute}
                <tr>
                    <td width="25%">{$attribute.description}</td><td>         
                        {if $attribute.type == "input"}
                            <input type="text" name="domain_extended[{$attribute.name}]" size="20" value="{$fields.extended[$attribute.name]}"/>
                        {elseif $attribute.type == "select"}
                            <select name="domain_extended[{$attribute.name}]">
                                {foreach from=$attribute.option item=value}
                                    <option value="{$value.value}" {if $value.value == $fields.extended[$attribute.name]} selected="selected"{/if} >{$value.title}</option>
                                {/foreach}
                            </select>
                        {elseif $attribute.type == "checkbox"}
                            <input type="checkbox"  name="domain_extended[{$attribute.name}]" value="1" {if $fields.extended[$attribute.name] == "1"}checked="checked" {/if}/>
                        {/if}
                        <br />
                    </td>
                </tr>
            {/foreach}
        </table>
    {/if}
{elseif $action=="draft"}
    {if $orders}
        {foreach from=$orders item=order}
            <tr>
                <td><input type="checkbox" class="check" value="{$order.id}" name="selected[]"/></td>
                <td><a href="?cmd=orders&action=createdraft&id={$order.id}">{$order.id}</a></td>
                <td>{$order|@profilelink:true}</td>
                <td>{$order.date_created|dateformat2:$date_format}</td>
                {if $admindata.access.viewOrdersPrices}
                    <td>{if $order.currency_id}{$order.total|price:$order.currency_id}{else}{$order.total|price:$currency}{/if}</td>
                {/if}
                <td>{if $order.module}{$order.module}{else}-{/if}</td>
                <td><span class="{$order.status}">{$lang[$order.status]}</span></td>
                <td><span class="{$order.estimate_id}">{if $order.estimate_id > 0}<a href="?cmd=estimates&action=edit&id={$order.estimate_id}">{$order.estimate_id}</a>{else}{$order.estimate_id}{/if}</span></td>
                <td><a href="?cmd={$cmd}&action={$action}&make=delete&id={$order.id}&security_token={$security_token}" onclick="return confirm('{$lang.deleteorderconfirm}');" class="delbtn">Delete</a></td>
            </tr>
        {/foreach}
    {elseif $action=="createdraft"}
        {include file='orders/add.tpl'}
    {else}
        <tr><td colspan="12"><p align="center" >{$lang.Click} <a href="?cmd=orders&action=createdraft" >{$lang.here}</a> to create new draft.</p></td></tr>
    {/if}
{else}
    {if $orders}
        {foreach from=$orders item=order}
            <tr>
                <td><input type="checkbox" class="check" value="{$order.id}" name="selected[]"/></td>
                <td><a href="?cmd=orders&action=edit&id={$order.id}&list={$currentlist}">{$order.id}</a></td>
                <td><a href="?cmd=orders&action=edit&id={$order.id}&list={$currentlist}">{$order.number}</a></td>
                <td>{$order|@profilelink:true:true}</td>
                <td>{$order.service}</td>
                <td>{$order.date_created|dateformat2:$date_format}</td>
                {if $admindata.access.viewOrdersPrices}
                    <td>{$order.total|price:$order.currency_id}</td>
                {/if}
                <td>
                    {if $order.total<0}
                        <span class="fs11">{$lang.amountcredited}</span>
                    {elseif $order.invcredit>0 && $order.invcredit>=$order.invsubtotal2}
                        {$lang.paidbybalance}
                    {else}
                        {$order.module|default:"`$lang.none`"} 
                        {if $order.invcredit>0}<span class="fs11">+ {$lang.paidbybalance}</span>{/if}
                    {/if}
                </td>
                <td><span class="{$order.balance}">{$lang[$order.balance]}</span></td>
                <td><span class="{$order.status}">{$lang[$order.status]}</span></td>
                <td>
                    {if !$forbidAccess.deleteOrders}
                        <a href="?cmd=orders&make=delete&id={$order.id}&security_token={$security_token}"
                           onclick="return confirm2(this);" class="delbtn">Delete</a>
                    {/if}
                </td>
            </tr>
        {/foreach}
    {elseif $action=="createdraft"}
        {include file='orders/add.tpl'}
    {elseif $action=="search_domain"}
        {if $domain_id}
            <span class="label label-warning">Warning</span> Domain with this name already exists in system: <a href="?cmd=domains&action=edit&id={$domain_id}" target="_blank">#{$domain_id}</a>
        {/if}
    {else}
        <tr><td colspan="11"><p align="center" >{$lang.Click} <a href="?cmd=orders&action=add">{$lang.here}</a> {$lang.toplaceneworder}</p></td></tr>
    {/if}
{/if}