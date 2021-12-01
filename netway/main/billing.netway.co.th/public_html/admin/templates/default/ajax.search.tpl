{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.search.tpl.php');
{/php}

{if $results}
 <div class="row results-nav">
    <div class="col-md-12">
        <ul class="nav nav-tabs" role="tablist">
            {foreach from=$results item=i key=r name=fr}
                <li role="presentation" {if $activetab == $r}class="active"{/if}><a href="#t-{$r|md5}" aria-controls="t-{$r|md5}" role="tab" data-toggle="tab">{if $lang[$r]}{$lang[$r]}{else}{$r}{/if} <span class="label label-{if $i.count}info{else}default{/if}">{$i.count}{if $i.count==$options.maxresults}+{/if}</span></a></li>
            {/foreach}

        </ul>
    </div>
</div>

{/if}
<div class="row results-bg">

    <div class="col-md-9">
        <div class="tab-content">
            {foreach from=$results item=i key=r name=fr}
                <div role="tabpanel" class="tab-pane  {if $activetab == $r} active {/if}" id="t-{$r|md5}">
                    {foreach from=$i.results item=re}
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row resultsrow" style="">



                                        <div class="col-md-10 ">
                                            {if $r == 'Domains'}
                                                <a href="?cmd=domains&action=edit&id={$re.id}" target="_blank"><strong>#{$re.id} {$re.name}</strong></a>
                                            {elseif $r == 'Accounts'}
                                                <a href="?cmd=accounts&action=edit&id={$re.id}&list=all"  target="_blank"><strong>#{$re.id} {$re.domain} </strong><em>{if $re.ip}IP: {$re.ip}{/if} {if $re.username}U: {$re.username}{/if}</em></a>
                                            {elseif $r == 'DNS'}
                                                Zone: <a href="?cmd=accounts&action=edit&id={$re.id}&list=all"  target="_blank"><strong>{$re.domain}</strong> in Account #{$re.id}</a>
                                            {elseif $r == 'Invoices'}
                                                <a href="?cmd=invoices&action=edit&id={$re.id}&list=all" target="_blank"><strong>{$re|@invoice}</strong></a>
                                            {elseif $r == 'Orders'}
                                                <a href="?cmd=orders&action=edit&id={$re.id}" target="_blank"><strong>id: {$re.id} - #{$re.number}</strong></a>
                                            {elseif $r == 'Tickets'}
                                                <a href="?cmd=tickets&action=view&list=all&num={$re.ticket_number}" target="_blank"><strong>#{$re.ticket_number} - {$re.subject|escape}</strong></a>
                                            {elseif $r == 'Transactions'}
                                                <a href="?cmd=transactions&action=edit&id={$re.id}" target="_blank"><strong>#{$re.trans_id}</strong></a>
                                            {elseif $r == 'Products'}
                                                <a href="?cmd=services&action=product&id={$re.id}" target="_blank"><strong>#{$re.id} {$re.name}</strong></a>

                                            {elseif $r == 'Estimates'}
                                                <a href="?cmd=estimates&action=edit&id={$re.id}"  target="_blank"><strong>#{$re.id} - {$re.subject}</strong></a>
                                            {elseif $r == 'Clients'}
                                                {$re|@profilelink:false:true}
                                            {elseif $r == 'Contacts'}
                                                <a href="?cmd=clients&action=showprofile&id={$re.id}"  target="_blank"><strong>#{$re.id} - {if $re.firstname}{$re.firstname} {$re.lastname}{else}{$re.companyname}{/if}</strong></a>
                                            {elseif $r == 'General'}
                                                <a href="{$re.cmdLink}"  target="_blank"><strong>#{$re.id} - {$re.itemName} {$re.clientFirstName} {$re.clientLastName} {if $re.clientCompanyName} - {$re.clientCompanyName} {/if}</strong></a>
                                            {else}
                                                <a href="{$re.link}"  target="_blank">{$re.text}</a>
                                            {/if}
                                        </div>
                                        <div class="col-md-2" style="text-align: right;">
                                            {if $re.status}<span class="label label-{$re.status}">{$re.status}</span>{/if}
                                        </div>
                                    </div>
                                        <div class="row metarow">

                                            <div class="col-md-12">

                                                {if $re.department}
                                                    <div class="itm">
                                                        <i class="fa fa-folder-o"  data-toggle="tooltip" data-placement="bottom" title="Department"></i> {$re.department|parsetag}
                                                    </div>
                                                {/if}

                                                {if $re.parent}
                                                    <div class="itm">
                                                        <i class="fa fa-user"  data-toggle="tooltip" data-placement="bottom" title="Client"></i> {$re.parent|@profilelink:false:true}
                                                    </div>

                                                {elseif $re.client_id}
                                                    {if $r == 'Clients'}
                                                        <div class="itm">
                                                            <i class="fa fa-user"  data-toggle="tooltip" data-placement="bottom" title="Client"></i> <a href="?cmd=clients&action=show&id={$re.client_id}" target="_blank">{if $re.firstname}{$re.firstname} {$re.lastname}{else}{$re.companyname}{/if}</a>
                                                        </div>
                                                    {else}
                                                        <div class="itm">
                                                            <i class="fa fa-user"  data-toggle="tooltip" data-placement="bottom" title="Client"></i> {$re|@profilelink:true:true}
                                                        </div>
                                                    {/if}


                                                {/if}

                                                {if $re.email}
                                                    <div class="itm">
                                                        <i class="fa fa-envelope-o"  data-toggle="tooltip" data-placement="bottom" title="Email"></i> {$re.email}
                                                    </div>
                                                {/if}
                                                {if $re.total}
                                                    <div class="itm">
                                                        <i class="fa fa-tags"  data-toggle="tooltip" data-placement="bottom" title="Total"></i> {$re.total|price:$re.currency_id}
                                                    </div>
                                                {/if}

                                                {if $re.gateway}
                                                    <div class="itm">
                                                        <i class="fa fa-money"  data-toggle="tooltip" data-placement="bottom" title="Gateway"></i> {$re.gateway|parsetag}
                                                    </div>
                                                {/if}


                                                {if $re.product}
                                                    <div class="itm">
                                                        <i class="fa fa-cube"  data-toggle="tooltip" data-placement="bottom" title="Product"></i> {$re.product|parsetag}
                                                    </div>
                                                {/if}


                                                {if $re.category}
                                                    <div class="itm">
                                                        <i class="fa fa-folder-o"  data-toggle="tooltip" data-placement="bottom" title="Category"></i> {$re.category|parsetag}
                                                    </div>
                                                {/if}


                                                {if $re.date}
                                                    <div class="itm">
                                                        <i class="fa fa-calendar-plus-o"  data-toggle="tooltip" data-placement="bottom" title="Created"></i> {$re.date|dateformat:$date_format}
                                                    </div>
                                                {/if}

                                                {if $re.expires && $re.expires!='0000-00-00'}
                                                    <div class="itm">
                                                        <i class="fa fa-calendar-times-o"  data-toggle="tooltip" data-placement="bottom" title="Expires"></i> {$re.expires|dateformat:$date_format}
                                                    </div>
                                                {/if}

                                                {if $re.duedate}
                                                    <div class="itm">
                                                        <i class="fa fa-calendar-times-o"  data-toggle="tooltip" data-placement="bottom" title="Due Date"></i> {$re.duedate|dateformat:$date_format}
                                                    </div>
                                                {/if}

                                            </div>




                                    </div>



                                </div>
                                {if $re._matches}<div class="panel-footer" style="font-size:90%">Match: {foreach from=$re._matches key=field item=m}<span class="label label-default">{$field}</span> {/foreach}</div>{/if}
                            </div>


                    {foreachelse}
                        <center>
                            <h3 style="color:#919191">{$lang.nothingwasfound}</h3>
                        </center>
                    {/foreach}
                </div>
            {/foreach}

    </div>
    </div>
        <div class="col-md-3">
            <div class="form-group">
                <label for="maxresults">Max results</label>
                <input type="number" value="{$options.maxresults|default:10}" name="maxresults" id="maxresults" class="form-control searchoptions" >

            </div>


            <div class="form-group">
                <label for="testString">Search in</label>
                {foreach from=$options.models item=modl}
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="searchmodel[]" value="{$modl}" {if in_array($modl,$options.limitmodels)}checked="checked"{/if} class="searchmodel">
                            {$modl}
                        </label>
                    </div>
                {/foreach}

            </div>

            <div class="form-group">
                <label for="testString">Additional options</label>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="activeclients" value="1" {if $options.activeclients}checked="checked"{/if} class="searchoptions">
                        Only active clients
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="searchreplies" value="1"  {if $options.searchreplies}checked="checked"{/if} class="searchoptions">
                        Search in ticket replies
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="searchcontents" value="1"  {if $options.searchcontents}checked="checked"{/if} class="searchoptions">
                        Search in invoice contents
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="searchecontents" value="1"  {if $options.searchecontents}checked="checked"{/if} class="searchoptions">
                        Search in estimate contents
                    </label>
                </div>
            </div>

            <div class="form-group">

                <input class="btn btn-info btn-sm search-apply-button" value="Apply" type="button" />
            </div>
        </div>



</div>
