<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1" >
        <ul>
            <li class="{if $action=='default'}active{/if}">
                <a href="?cmd=module&module={$moduleid}"><span>Email Domain Registrar: Change requests</span></a>
            </li>
        </ul>
    </div>
</div>
<div style="padding:10px ;">
    <div class="box box-primary no-padding">
        <div class="box-body">
            <div style="padding: 10px;">
                <a href="?cmd=module&module={$moduleid}&resetfilter=1"  {if $currentfilter}style="display:inline"{/if} class="freseter">{$lang.filterisactive}</a>
                <div class="filterdatablock" style="display: none; margin-top: 20px">
                    <form class="searchform filterform" action="?cmd=module&module={$moduleid}&action=default" method="post" onsubmit="return filter(this)">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-12 col-md-4">
                                    <div class="">Domain ID</div>
                                    <input type="text" value="{$currentfilter.domain_id}" size="40" class="form-control" name="filter[domain_id]"/>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="">Status</div>
                                    <select class="form-control" name="filter[status]">
                                        <option value="">- All -</option>
                                        <option {if $currentfilter.status === 'Done'}selected="selected"{/if} value="Done">Done</option>
                                        <option {if $currentfilter.status === 'Canceled'}selected="selected"{/if} value="Canceled">Canceled</option>
                                        <option {if $currentfilter.status === 'Pending'}selected="selected"{/if} value="Pending">Pending</option>
                                    </select>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="">Change</div>
                                    <select class="form-control" name="filter[what]">
                                        <option value="">- All -</option>
                                        <option {if $currentfilter.status === 'register'}selected="selected"{/if} value="contacts">Register</option>
                                        <option {if $currentfilter.status === 'transfer'}selected="selected"{/if} value="contacts">Transfer</option>
                                        <option {if $currentfilter.status === 'renew'}selected="selected"{/if} value="contacts">Renew</option>
                                        <option {if $currentfilter.status === 'contacts'}selected="selected"{/if} value="contacts">Contacts</option>
                                        <option {if $currentfilter.status === 'idprotection'}selected="selected"{/if} value="idprotection">ID Protection</option>
                                        <option {if $currentfilter.status === 'reglock'}selected="selected"{/if} value="reglock">Registrar lock</option>
                                        <option {if $currentfilter.status === 'dns'}selected="selected"{/if} value="dns">DNS</option>
                                        <option {if $currentfilter.status === 'ns'}selected="selected"{/if} value="ns">Nameservers</option>
                                        <option {if $currentfilter.status === 'epp'}selected="selected"{/if} value="epp">EPP code</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <table width="100%" cellspacing="2" cellpadding="3" border="0" >
                            <tbody>
                            <tr>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <div class="text-center" style="margin-top:20px;">
                                        <input type="submit" value="{$lang.Search}" class="btn btn-primary btn-sm" />
                                        <input type="submit" value="{$lang.Cancel}" class="btn btn-default btn-sm" onclick="$('.filterdatablock').toggle();return false;"/>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        {securitytoken}
                    </form>
                    <script type="text/javascript">bindFreseter();</script>
                </div>
            </div>
            <div class="blu">
                <div class="right">
                    <a href="#" class="fadvanced" onclick="$('.filterdatablock').toggle();">{$lang.filterdata}</a>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=module&module={$moduleid}" id="currentlist" style="display:none" updater="#updater"></a>
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="whitetable hover">
                <thead>
                    <tr>
                        <th><a href="?cmd=module&module={$moduleid}&orderby=id|ASC" class="sortorder">ID</a></th>
                        <th><a href="?cmd=module&module={$moduleid}&orderby=domain_id|ASC" class="sortorder">Domain</a></th>
                        <th><a href="?cmd=module&module={$moduleid}&orderby=created_at|ASC" class="sortorder">Created at</a></th>
                        <th><a href="?cmd=module&module={$moduleid}&orderby=updated_at|ASC" class="sortorder">Updated at</a></th>
                        <th><a href="?cmd=module&module={$moduleid}&orderby=what|ASC" class="sortorder">What</a></th>
                        <th><a href="?cmd=module&module={$moduleid}&orderby=status|ASC" class="sortorder">Status</a></th>
                        <th>Old value</th>
                        <th>New value</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="updater">
                    {include file="ajax.default.tpl"}
                </tbody>
                <tbody id="psummary">
                <tr>
                    <th colspan="100%">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span
                                id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                                id="sorterrecords">{$sorterrecords}</span>
                    </th>
                </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</div>
