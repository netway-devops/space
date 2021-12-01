{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clients.tpl.php');
{/php}

<script type="text/javascript">loadelements.clients = true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.Clients}</h3></td>
        {if $action=='default' || $action=='_default' || $action=='show'}
            <td  class="searchbox"><div id="hider2" style="text-align:right">

                    &nbsp;&nbsp;&nbsp;<a href="?cmd=clients&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=clients&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>

                </div>
                <div id="hider" style="display:none"></div></td>
        {else}<td></td>
        {/if}
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=newclient"  class="tstyled btn btn-success"><strong>{$lang.registernewcustomer}</strong></a><br />

            <a href="?cmd=clients"  class="tstyled {if $action!='fields' && $action!='editfield' && !$currentlist}selected{/if}">{$lang.managecustomers} <span>({$cstats.All})</span></a>

            <a href="?cmd=clients&list=active"  class="tstyled tsubit {if $currentlist=='Active'}selected{/if}">{$lang.Active} <span>({$cstats.Active})</span></a>
            <a href="?cmd=clients&list=closing"  class="tstyled tsubit {if $currentlist=='Closing'}selected{/if}">{$lang.Closing} <span>({$cstats.Closing})</span></a>
            <a href="?cmd=clients&list=archived"  class="tstyled tsubit {if $currentlist=='Archived'}selected{/if}">{$lang.Archived} <span>({$cstats.Archived})</span></a>
            <a href="?cmd=clients&list=closed"  class="tstyled tsubit {if $currentlist=='Closed'}selected{/if}">{$lang.Closed} <span>({$cstats.Closed})</span></a>
            {if $admindata.access.viewArchivedClients}
                <a href="?cmd=clients&list=archived"  class="tstyled tsubit {if $currentlist=='Archived'}selected{/if}">{$lang.Archived} <span>({$cstats.Archived})</span></a>
            {/if}
            {foreach from=$groups item=group}
                <a href="?cmd=clients&list={$group.id}"  class="tstyled tsubit {if $currentlist==$group.id}selected{/if}" style="color:{$group.color}">{$group.name} <span>({$group.count})</span></a>
            {/foreach}

            <br />
            <a href="?cmd=clients&action=groups"  class="tstyled {if $action=='groups' || $action=='editgroup' || $action=='addgroup'}selected{/if}">{$lang.clientgroups}</a>
            <a href="?cmd=clients&action=fields"  class="tstyled {if $action=='fields' || $action=='editfield'}selected{/if}">{$lang.customerfields}</a>
            <br />
            <a href="?cmd=affiliates"  class="tstyled">{$lang.Affiliates}</a>
            <a href="?cmd=affiliates&action=configuration"  class="tstyled">{$lang.affconfig}</a> </td>
        <td  valign="top"  class="bordered">
            {if $action=='show'}

                {include file="clients/details.tpl"}
            {else}
                <div id="bodycont">

            {/if}


                {if $action=='groups' || $action=='addgroup' || $action=='editgroup' || $action=='overrides' }
                    {include file='configuration/clientgroups.tpl'}
                {elseif $action=='fields'}
                    {include file='ajax.clientfields.tpl'}
                {elseif $action=='default'}
                    <div id="confirm_cacc_delete" hidden bootbox data-title="{$lang.deleteheading}" data-btnclass="btn-danger">

                        <form action="?cmd=clients&delete=1" method="post">
                            <p><strong>{$lang.deletedescr}</strong></p>

                            <input type="radio" checked="checked" name="harddelete" value="1" /> {$lang.deleteopt1}<br />
                            <input type="radio"  name="harddelete" value="0" /> {$lang.deleteopt2}<br />


                            {securitytoken}
                        </form>

                    </div>
                    <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>

                        <div class="blu">
                            <div class="right"><div class="pagination"></div></div>
                            <div class="left menubar">
                                {literal}
                                    <script type="text/javascript">
                                        function sendtoall_show() {
                                            if ($('#sendtoall').hasClass('visible')) {
                                                $('#sendtoall').removeClass('visible');
                                                $('#sendtoall').hide();
                                            }
                                            else {
                                                $('#sendtoall').addClass('visible');
                                                $('#sendtoall').show();
                                            }
                                            return false;
                                        }
                                        function specifictypes_show() {
                                            if ($("input[name='sendtype']:checked").val() == 'specific')
                                                $('#specifictypes').show();
                                            else
                                                $('#specifictypes').hide();
                                        }


                                        function deleteClients() {
                                            if ($("input[class=check]:checked").length < 1) {
                                                alert('Nothing checked.');
                                                return false;
                                            } else {
                                                $('#confirm_cacc_delete form .hid_cls_in').remove();
                                                $("input[class=check]:checked").each(function(){
                                                    var val=$(this).val();
                                                    $('#confirm_cacc_delete form').append('<input type="hidden" value="'+val+'" name="selected[]" class="hid_cls_in">');
                                                });

                                                $('#confirm_cacc_delete').trigger('show');
                                            }
                                        }
                                        function confirmsubmit1() {
                                            var add = '';
                                            if ($('#cl_hard').is(':checked'))
                                                add = '&harddelete=true';

                                            $('#testform').removeAttr('action');
                                            $('#testform').attr('action', '?cmd=clients&make=delete' + add);
                                            $('#testform').submit();
                                        }
                                        function cancelsubmit1() {
                                            $('#confirm_cacc_delete').parent().parent().css('position', 'inherit');
                                            $('#confirm_cacc_delete').hide();
                                            return false;
                                        }
                                    </script>
                                {/literal}

                                <a onclick="return sendtoall_show()" class="menuitm" href="#" style="margin-right: 5px;font-weight:bold;"><span >{$lang.sendmassemail}</span></a>
                                <a href="#" onclick="return false" id="hd1" class="menuitm clDropdown"><span class="morbtn">Import</span></a>
                                <ul class="ddmenu" id="hd1_m">
                                    <li><a href="?cmd=csv" class="directly">Import from CSV</a></li>
                                </ul>

                                {$lang.withselected}
                                {if !$forbidAccess.deleteClients}
                                    <a class="menuitm menu-auto" href="#"  name="deleteclients" 
                                       onclick="deleteClients(); return false;" >
                                        <span style="color: red">{$lang.Delete}</span>
                                    </a>
                                {/if}
                                <a class=" menuitm menu-auto" href="#" onclick="return send_msg('clients')" >
                                    <span >{$lang.SendMessage}</span>
                                </a>

                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="lighterblue" id="sendtoall" style="display: none; padding: 10px">
                            <input checked="checked" type="radio" name="sendtype" value="all" onclick="specifictypes_show()" /> {$lang.allclients}
                            <input type="radio" name="sendtype" value="specific" onclick="specifictypes_show()" /> {$lang.specifiedclients}
                            <input type="radio" name="sendtype" value="filters" onclick="specifictypes_show()" /> Use current filters

                            <input type="submit" name="sendmail" value="{$lang.Send}" onclick="return send_msg('allclients')" style="font-weight: bold; margin-left: 50px" />
                            <input type="submit" value="{$lang.Cancel}" onclick="return sendtoall_show()" />
                            <div id="specifictypes" style="display: none;">
                               {include file='clients/ajax.emailcriterias.tpl'}
                            </div>
                        </div>

                        <a href="?cmd=clients&list={$currentlist|strtolower}" id="currentlist" style="display:none"></a>
                        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                            <tbody>
                            <tr>
                                <th width="20"><input type="checkbox" id="checkall"/></th>
                                <th><a href="?cmd=clients&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.clienthash}</a></th>
                                <th><a href="?cmd=clients&list={$currentlist}&orderby=firstname|ASC"  class="sortorder">{$lang.firstname}</a></th>
                                <th><a href="?cmd=clients&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.lastname}</a></th>
                                <th><a href="?cmd=clients&list={$currentlist}&orderby=email|ASC"  class="sortorder">{$lang.email}</a></th>
                                <th><a href="?cmd=clients&list={$currentlist}&orderby=companyname|ASC"  class="sortorder">{$lang.company}</a></th>

                                <th>{$lang.Services}</th>
                                <th><a href="?cmd=clients&list={$currentlist}&orderby=datecreated|ASC"  class="sortorder">{$lang.Created}</a></th>
                                <th></th>
                            </tr>
                            </tbody>
                            <tbody id="updater">

                            {include file='ajax.clients.tpl'}
                            </tbody>
                            <tbody id="psummary">
                            <tr>
                                <th></th>
                                <th colspan="10">
                                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                                </th>
                            </tr>
                            </tbody>

                        </table>
                        {literal}<script type="text/javascript">function tagColumnShrink() {
                                var a = $("#updater").find(".inlineTags").width();
                                $("#updater").parent().find("tr:first th:last-child").width(a)
                            }
                            tagColumnShrink(), $("#updater").ajaxComplete(tagColumnShrink)</script>{/literal}
                        <div class="blu">
                            <div class="right"><div class="pagination"></div></div>
                            <div class="left menubar">
                                {$lang.withselected}
                                {if !$forbidAccess.deleteClients}
                                    <a class="menuitm menu-auto" href="#"  name="deleteclients"  
                                       onclick="deleteClients(); return false;" >
                                        <span style="color: red">{$lang.Delete}</span>
                                    </a>
                                {/if}
                                <a class=" menuitm menu-auto" href="#" onclick="return send_msg('clients')" >
                                    <span >{$lang.SendMessage}</span>
                                </a>

                            </div>
                            <div class="clear"></div>
                        </div>

                        {securitytoken}</form>
                {elseif $action=='showprofile' || $action=='newprofile'}

                    {include file="clientprofile.tpl"}

                {/if}

                    {if $action=='show'}

                    {else}
                    <div id="bodycont">
                    </div>
                        {/if}
        </td>
    </tr>
</table>