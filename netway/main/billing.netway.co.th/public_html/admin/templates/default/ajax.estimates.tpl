{if $action=='default'}

    {if $showall}
        <form action="" method="post" id="testform" >
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="left menubar">

                    {$lang.withselected}
                    <a class="submiter menuitm menu-auto" name="send"  href="#" ><span style="font-weight:bold">{$lang.Send}</span></a>
                    <a class="submiter menuitm menu-auto" name="markaccepted" href="#" ><span >{$lang.Accept}</span></a>
                    <a class="submiter menuitm menu-auto" name="createinvoice" href="#" ><span >{$lang.converttoinvoice}</span></a>
                        {if !$forbidAccess.deleteEstimates}
                        <a class="submiter menuitm confirm menu-auto" name="delete" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>
                        {/if}

                </div>
                <div class="right"><div class="pagination"></div>
                </div>
                <div class="clear"></div>
                <div id="new_estimate" style="padding: 10px; display: none"></div>

            </div>

            <a href="?cmd=estimates&list={$currentlist}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                    <tr>
                        <th width="20"><input type="checkbox" id="checkall"/></th>
                        <th><a href="?cmd=estimates&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.Estimate}</a></th>
                        <th><a href="?cmd=estimates&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                        <th><a href="?cmd=estimates&list={$currentlist}&orderby=subject|ASC"  class="sortorder">{$lang.description}</a></th>
                        <th><a href="?cmd=estimates&list={$currentlist}&orderby=date_created|ASC"  class="sortorder">{$lang.Date}</a></th>
                        <th><a href="?cmd=estimates&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                        <th><a href="?cmd=estimates&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                        <th width="20">&nbsp;</th>
                        <th width="20">&nbsp;</th>
                    </tr>
                </tbody>
                <tbody id="updater">

                {/if}
                {if $estimates}
                    {foreach from=$estimates item=estimate}
                        <tr>
                            <td><input type="checkbox" class="check" value="{$estimate.id}" name="selected[]"/></td>
                            <td><a href="?cmd=estimates&action=edit&id={$estimate.id}"   >{$estimate.id}</a></td>
                            <td>{$estimate|@profilelink:true:true}</td>
                            <td><a href="?cmd=estimates&action=edit&id={$estimate.id}" >{$estimate.subject}</a></td>
                            <td>{$estimate.date_created|dateformat:$date_format}</td>
                            <td>{$estimate.total|price:$estimate.currency_id}</td>
                            <td><span class="{$estimate.status}">{$lang[$estimate.status]}</span></td>
                            <td><a href="?cmd=estimates&action=edit&id={$estimate.id}" class="editbtn">{$lang.Edit}</a></td>
                            <td><a href="?cmd=estimates&action=menubutton&make=deleteestimate&id={$estimate.id}" class="deleteEstimate delbtn">delete</a></td>
                        </tr>
                    {/foreach}
                {else}

                    <tr>
                        <td colspan="9"><p align="center" > {$lang.nothingtodisplay} </p></td>
                    </tr>
                {/if}
                {if $showall}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th></th>
                        <th colspan="8">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                        </th>
                    </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="left menubar">
                    {$lang.withselected}
                    <a class="submiter menuitm menu-auto" name="send"  href="#" ><span style="font-weight:bold">{$lang.Send}</span></a>
                    <a class="submiter menuitm menu-auto" name="markaccepted" href="#" ><span >{$lang.Accept}</span></a>
                    <a class="submiter menuitm menu-auto" name="createinvoice" href="#" >
                        <span >{$lang.converttoinvoice}</span>
                    </a>
                    {if !$forbidAccess.deleteEstimates}
                        <a class="submiter menuitm confirm menu-auto" name="delete" href="#" >
                            <span style="color:#FF0000">{$lang.Delete}</span>
                        </a>
                    {/if}
                </div>
                <div class="right"><div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}</form>
            {if $ajax}
            <script type="text/javascript">bindEvents();</script>
        {/if}
    {/if}
    {if $ajax}

    {/if}

{elseif $action=='getclients'}
    <center>
        {if $clients}
            {$lang.Client}: <select class="newinvoice_clientid" load="clients" style="width: 180px">
                {*foreach from=$clients item=cl}
                <option value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.firstname} {$cl.lastname}{/if}</option>
                {/foreach*}
            </select>

            <input class="btn btn-success btn-sm" type="submit" name="createestimate" value="{$lang.createestimate}"  style="font-weight:bold" onclick="create_estimate();
                    return false;"/>

            <input class="btn btn-default btn-sm"  type="button" value="{$lang.Cancel}" onclick="$('#new_estimate').hide();
                    return false;"/>
        {else}
            {$lang.thereisnoclients}. {$lang.Click} <a href="?cmd=newclient">{$lang.here}</a> {$lang.toregisternew}.
        {/if}
    </center>
    <script type="text/javascript">
        {literal}
            Chosen.find();
            function create_estimate() {
                var id = $(".newinvoice_clientid option:selected").val();
                if (id) {
                    window.location.href = '?cmd=estimates&security_token={$security_token}&action=createestimate&client_id=' + id;
                }
            }
        {/literal}
    </script>
{elseif $action=='clientestimates'}
    <div class="blu clearfix">
        <div class="pull-right">
        {include file='ajax.filterquicktool.tpl' client_id=$client_id loadid='estimatesfilter' href="?cmd=estimates&action=getadvanced"}
        <a href="?cmd=estimates&action=createestimate&client_id={$client_id}" class="btn btn-primary btn-xs" target="_blank"><i class="fa fa-plus"></i> {$lang.newestimate}</a>
        </div>
    </div>

    {if $estimates}


        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
                <tr>

                    <th><a href="?cmd=estimates&action=clientestimates&id={$client_id}" class="sortorder" data-orderby="id">{$lang.Estimate}</a></th>
                    <th><a href="?cmd=estimates&action=clientestimates&id={$client_id}" class="sortorder" data-orderby="subject">{$lang.description}</a></th>
                    <th><a href="?cmd=estimates&action=clientestimates&id={$client_id}" class="sortorder" data-orderby="date_created">{$lang.Date}</a></th>
                    <th><a href="?cmd=estimates&action=clientestimates&id={$client_id}" class="sortorder" data-orderby="total">{$lang.Total}</a></th>
                    <th><a href="?cmd=estimates&action=clientestimates&id={$client_id}" class="sortorder" data-orderby="status">{$lang.Status}</a></th>
                    <th width="20">&nbsp;</th>

                </tr>
            </tbody>
            <tbody >



                {foreach from=$estimates item=estimate}
                    <tr>

                        <td><a href="?cmd=estimates&action=edit&id={$estimate.id}" >{$estimate.id}</a></td>
                        <td><a href="?cmd=estimates&action=edit&id={$estimate.id}" >{$estimate.subject}</a></td>
                        <td>{$estimate.date_created|dateformat:$date_format}</td>
                        <td>{$estimate.total|price:$estimate.currency_id}</td>
                        <td><span class="{$estimate.status}">{$lang[$estimate.status]}</span></td>
                        <td><a href="?cmd=estimates&action=edit&id={$estimate.id}"  class="editbtn" rel="{$estimate.id}">{$lang.Edit}</a></td>

                    </tr>
                {/foreach}

            </tbody>

        </table>
        {if $totalpages}
            <div class="text-right" style="margin: 10px 0px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="estimates_per_page" id="estimates_per_page">
                        <option value="10" {if $estimates_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $estimates_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $estimates_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $estimates_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $estimates_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                        <center class=" paginercontainer" >
                            <strong>{$lang.Page} </strong>
                            {section name=foo loop=$totalpages}
                                <a href='?cmd=estimates&action=clientestimates&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer
                                {if $smarty.section.foo.iteration-1==$currentpage}
                                currentpage
                                {/if}"
                                >{$smarty.section.foo.iteration}</a>

                            {/section}
                        </center>
                </div>
            </div>
            <script>
                $('.paginercontainer','div.slide:visible').infinitepages();
                FilterModal.bindsorter('{$orderby.orderby}','{$orderby.type}');
                {literal}
                    $('#estimates_per_page').on('change', function () {
                        var form_client = {estimates_per_page: $(this).val()};
                        ajax_update("?cmd=estimates&action=clientestimates&id={/literal}{$client_id}{literal}", form_client, $('div.slide:visible'), true);
                    });
                {/literal}
            </script>
        {/if}
    {else}
        <strong>{$lang.nothingtodisplay}</strong>
    {/if}
{elseif $action=='edit' || $action=='edit_preview'}
    {include file="invoices/estimate.tpl"}
{elseif $action=='updatetotals'}
    <tbody id="main-invoice">
        {include file="invoices/estimate_items.tpl"}
    </tbody>
    <tbody id="updatetotals">
        <tr>
            <td class="summary aright"  colspan="2"><strong>{$lang.Subtotal}</strong></td>
            <td class="summary aright" colspan="2"><strong>{$estimate.subtotal|price:$currency}</strong></td>
            <td class="summary" width="2%"></td>
        </tr>
        {if $estimate.credit}
            <tr>

                <td class="summary aright"  colspan="2"><strong>{$lang.Discount}</strong></td>
                <td class="summary aright" colspan="2"><strong>{$estimate.credit|price:$currency}</strong></td>
                <td class="summary"></td>
            </tr>
        {/if}
        {if $estimate.taxrate!=0}
            <tr>

                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$estimate.taxrate}%)</strong></td>
                <td class="summary aright" colspan="2"><strong>{$estimate.tax|price:$currency}</strong></td>
                <td class="summary"></td>
            </tr>
        {/if}
        {if $estimate.taxrate2!=0}
            <tr>

                <td class="summary aright"  colspan="2"><strong>{$lang.Tax} ({$estimate.taxrate2}%)</strong></td>
                <td class="summary aright" colspan="2"><strong>{$estimate.tax2|price:$currency}</strong></td>
                <td class="summary"></td>
            </tr>
        {/if}
        <tr>

            <td class="summary aright" colspan="2" valign="top"><strong class="bigger">{$lang.Total}</strong></td>
            <td class="summary aright" colspan="2" valign="top" ><strong class="bigger">{$estimate.total|price:$currency}</strong></td>
            <td class="summary"  valign="top"></td>
        </tr>
    </tbody>
{elseif $action=='getproduct'}


    {*{if $products}*}
        {*<select name="product" id="product_id">{foreach from=$products item=prod}<option value="{$prod.id}">{$prod.name} {$prod.price|price:$currency}</option>{/foreach}</select>*}
        {*<input type="button" value="OK" class="prodok"/>*}
    {*{/if}*}
    <select class="inp" name="product" id="product_id"  style="width:450px">
        <option selected="selected" >-</option>
        {foreach from=$services item=category}
            {if $category.products}
                <optgroup label="{$category.name}">
                    {foreach from=$category.products item=prod}
                        <option value="{$prod.id}" data-price="{$prod.price|price:$currency:false}" {if $submit.product == $prod.id}selected="selected" {/if}>{$prod.name}</option>
                    {/foreach}
                </optgroup>
            {/if}
        {/foreach}
    </select>
    {*<input type="button" value="OK"  class="prodok btn btn-success btn-sm"/>*}
    {*<input type="button" value="{$lang.Cancel}" id="prodcanc" class="btn btn-default btn-sm"/>*}
    {if $ajax}{literal}
        <script type="text/javascript">
            $('#product_id').chosenedge({width: '100%'});
            bindEstimatesDetForm();</script>
    {/literal} {/if}

{elseif $action=='getblank'}

    description: <input name="newline_name" id="newline"/>
    <input type="button" value="OK" class="prodok"/>
    <input type="button" value="{$lang.Cancel}" id="prodcanc"/>
    {if $ajax}
        <script type="text/javascript">bindEstimatesDetForm();</script>
    {/if}


{elseif $action=='getaddon'}
    {if $addons}
        <select name="addon" id="addon_id">{foreach from=$addons item=addon}<option value="{$addon.id}">{$addon.name} {$addon.price|price:$currency}</option>{/foreach}</select>
        <input type="button" value="OK" class="prodok"/>
    {/if}
    <input type="button" value="{$lang.Cancel}" id="prodcanc"/>
    {if $ajax}
        <script type="text/javascript">bindEstimatesDetForm();</script>
    {/if}
{elseif $action=='addline' || $action=='removeline'}
    {include file="invoices/items.tpl"}
{elseif $action=='addline'}

    {if $newline}
        <tr id="line_{$newline.id}">
            <td class="editline">
                <span class="line_descr">{$newline.description|nl2br}</span><a class="editbtn" style="display:none;" href="#">{$lang.Edit}</a>
                <div style="display:none" class="editor-line">
                    <textarea name="item[{$newline.id}][description]">{$newline.description}</textarea>
                    <a class="savebtn" href="#" >{$lang.savechanges}</a>
                </div>
            </td>
            <td class="acenter"><input name="item[{$newline.id}][qty]" value="{$newline.qty}" size="7" class="foc invitem invqty" style="text-align:center"/></td>
            <td class="acenter"><input type="checkbox" name="item[{$newline.id}][taxed]" {if $newline.taxed == 1}checked="checked" {/if}value="1" class="invitem2"/></td>
            <td class="acenter"><input name="item[{$newline.id}][amount]" value="{$newline.amount}" size="13" class="foc invitem invamount" style="text-align:right"/></td>
            <td class="aright">{$currency.sign} <span id="ltotal_{$newline.id}">{$newline.linetotal|string_format:"%.2f"}</span> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</td>
            <td class="acenter">
                <a href="?cmd=estimates&action=removeline&id={$estimateid}&line={$newline.id}"
                   class="removeLine">
                    <img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/>
                </a>
                {if $ajax}
                    <script type="text/javascript">bindEstimatesDetForm(); //estimatesItemsSubmit()</script>
                {/if}
            </td>
        </tr>

    {/if}

{elseif $action=='changeowner'}
    <form action="?cmd=estimates&action=edit&id={$estimate_id}" method="post">
        <input type="hidden" name="make" value="changeowner" />
        <select name="new_owner">
            {foreach from=$clients item=client}
                <option value="{$client.id}" {if $selected==$client.id}selected="selected"{/if}>
                    #{$client.id}
                    {if $client.companyname!=''}{$lang.Company}: {$client.companyname}
                    {else}{$client.firstname} {$client.lastname}
                    {/if}
                </option>
            {/foreach}
        </select>
        <input type="submit" value="{$lang.Change}" style="font-size:11px;font-weight:bold;"/>
        &nbsp;&nbsp;

        <a href="#" onclick="$('#curr_det').show();
                $('#client_container').hide();
                return false;">
            {$lang.Cancel}
        </a>

        {securitytoken}
    </form>

{elseif $action=='getadvanced'}

    <a href="?cmd=estimates&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=estimates" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>

    <script type="text/javascript">bindFreseter();</script>
{else}

    {if $drawdetails}
        {include file='invoices/estimate_details.tpl'}
        {if $ajax}
            <script type="text/javascript">bindEstimatesDetForm();</script>
        {/if}
    {/if}

{/if}


