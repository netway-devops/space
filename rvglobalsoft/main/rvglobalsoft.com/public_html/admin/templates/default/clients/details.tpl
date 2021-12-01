<div id="confirm_cacc_close" hidden bootbox data-title="{$lang.closeheading}" data-btnclass="btn-danger">

    <form action="?cmd=clients&make=close" method="post">
        <p><strong>{$lang.closedescr}</strong></p>

        <input type="radio" checked="checked" name="hardclose" value="true" id="cc_hard"/> {$lang.closeopt1}<br/>
        <input type="radio" name="hardclose" value="false" id="cc_soft"/> {$lang.closeopt2}<br/>

        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>

<div id="confirm_cacc_archive" hidden bootbox data-title="{$lang.archiveheading}" data-btnclass="btn-danger">

    <form action="?cmd=clients&action=archive" method="post">
        <div>
            Using this function will result in:
            <ul>
                <li>marking unpaid client invoices as cancelled</li>
                <li>suspending & canceling client services</li>
                <li>closing client tickets</li>
            </ul>
        </div>
        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>
</div>
<div id="confirm_cacc_anonymize" hidden bootbox data-title="{$lang.anonymizeheading}" data-btnclass="btn-danger">

    <form action="?cmd=clients&action=anonymize" method="post">
        <div>
            Using this function will result in:
            <ul>
                <li>closing client profile</li>
                <li>terminating client services</li>
                <li>clearing client changes log, emails and tickets</li>
                <li>removing ALL non-billing data</li>
            </ul>
        </div>
        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>

<div id="confirm_cacc_delete" hidden bootbox data-title="{$lang.deleteheading}" data-btnclass="btn-danger">

    <form action="?cmd=clients&make=delete" method="post">
        <p><strong>{$lang.deletedescr}</strong></p>

        <input type="radio" checked="checked" name="harddelete" value="true"/> {$lang.deleteopt1}<br/>
        <input type="radio" name="harddelete" value="false"/> {$lang.deleteopt2}<br/>


        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>

<div id="gdpr_request" hidden bootbox data-title="Details Request" data-btntitle="Download" data-btnclass="btn-primary">

    <form action="?cmd=clients&action=pdfdetails" method="post">
        <div class="form-group">
            <label>This information was requested by</label>
            <input type="text" class="form-control" name="name"/>
        </div>
        <div class="form-group">
            <label>Purpose</label>
            <textarea class="form-control" name="purpose"></textarea>
        </div>
        <input type="hidden" name="id" value="{$client.id}"/>
        {securitytoken}
    </form>

</div>

<div id="confirm_curr_change" hidden bootbox data-title="{$lang.currheading}" data-callback="confirmsubmit"
     data-btnclass="btn-primary">

    <div>
        <p><strong>{$lang.currdescr}</strong></p>

        <div id="conf_c_b_1">
            <input type="radio" checked="checked" name="curchange" value="recalculate"/> {$lang.curropt1}<br/>
            <input type="radio" name="curchange" value="change"/> {$lang.curropt2}<br/>
        </div>


    </div>
    <script type="text/javascript">
        {literal}
        function confirmsubmit() {
            var val = $('.bootbox-body input[name=curchange]:checked').val();
            $('#clientform').append('<input type="hidden" name="curchange" value="' + val + '" />');
            $('#clientform').unbind('submit');
            $('#clientsavechanges').click();
        }

        {/literal}
    </script>
</div>
<form action='' method='post' id="clientform" enctype="multipart/form-data">

    <div id="bodycont">

        <div class="blu">
            <div class="menubar">
                <a href="?cmd=clients"><strong>&laquo; {$lang.backtoallcl}</strong></a>

                <a onclick="$('.nav_el').eq(0).click();
                        $('#tdetail a').click();
                        return false;" class="menuitm" href="#">
                    <span>{$lang.editclientdetails}</span>
                </a>

                {if $admindata.access.loginAsClient}
                    <a class=" menuitm menu-auto" href="{$system_url2}?action=adminlogin&id={$client.client_id}"
                       target="_blank">
                        <span><strong>{$lang.loginasclient}</strong></span>
                    </a>
                {/if}
                <a class="menuitm menu-auto" onclick="$('#ccinfo').toggle();
                        return false" href="#">
                    <span>{$lang.ccardach}</span>
                </a>
                <a class="menuitm clDropdown menu-auto" id="hd1" onclick="return false" href="#">
                    <span class="morbtn">{$lang.moreactions}</span>
                </a>

                <ul id="hd1_m" class="ddmenu">
                    <li><a href="EditNotes">{$lang.editclientnotes}</a></li>
                    <li><a href="OpenTicket">{$lang.opennewticket}</a></li>
                    <li><a href="PlaceOrder">{$lang.PlaceOrder}</a></li>
                    <li><a href="CreateInvoice">{$lang.CreateInvoice}</a></li>
                    {if !$client.affiliate_id}
                        <li><a href="EnableAffiliate">{$lang.EnableAffiliate}</a></li>
                    {/if}
                    <li><a href="DetailsRequest">{$lang.GDPRDetailsRequest}</a></li>
                    <li><a href="SendNewPass">{$lang.SendNewPass}</a></li>
                    <li><a href="CloseAccount">{$lang.CloseAccount}</a></li>
                    <li><a href="ArchiveAccount">{$lang.ArchiveAccount}</a></li>
                    <li><a href="AnonymizeAccount">{$lang.AnonymizeAccount}</a></li>
                    <li><a href="DeleteAccount" style="color:#ff0000">{$lang.DeleteProfile}</a></li>
                </ul>

                {adminwidget module="clients" section="profileheader"}
            </div>
        </div>


        <input type="hidden" value="{$client.currency_id}" name="old_currency_id" id="old_currency_id"/>

        <input type="hidden" value="{$client.client_id}" name="id" id="client_id"/>

        <div class="lighterblue" style="padding:5px;display:none" id="ccinfo">
            {if !$admindata.access.viewCC && !$admindata.access.editCC}
                {$lang.lackpriviliges}
            {else}
                {if $client.cardnum!='' || $ach.account}
                    <div id="cc_cont" style="min-height: 2em">
                        <div class="left">
                            <strong>{$lang.ccard}</strong><br/>
                            {include file='ajax.clients.tpl' action=ccshow cmake=ccshow cardcode=$client verify=1}
                            <div class="o1" style="padding: 5px 0">
                                {if $admindata.access.editCC}
                                    <a href="#" onclick="return load_cc_verify('ccadd');"
                                       class="menuitm">{$lang.editcardnumber}</a>
                                {elseif $admindata.access.viewCC}
                                    <a href="#" onclick="return load_cc_verify('ccshow');"
                                       class="menuitm">{$lang.viewcardnumber}</a>
                                {/if}
                            </div>

                        </div>
                        <div class="left" style="margin-left:60px;">
                            <strong>{$lang.ACHecheck}</strong><br/>
                            {include file='ajax.clients.tpl' action=achshow cmake=achshow cardcode=$ach verify=1}

                            <div class="o1" style="padding: 5px 0">
                                {if $admindata.access.editCC}
                                    <a href="#" onclick="return load_cc_verify('achadd');" class="menuitm">Update bank
                                        account</a>
                                {elseif $admindata.access.viewCC}
                                    <a href="#" onclick="return load_cc_verify('achshow');" class="menuitm">View bank
                                        account</a>
                                {/if}
                            </div>
                        </div>
                        <div style="clear:both"></div>

                        <div class="o2" style="display:none; padding: 5px 0">
                            {$lang.provideyourpassword}
                            <input type="password" autocomplete="off" name="admin_pass" id="admin_pass"/>
                            <input type="button" id="ccbutton"
                                   data-action="{if $admindata.access.editCC}ccadd{else}ccshow{/if}"
                                   onclick="return verify_pass({if $admindata.access.editCC}'ccadd'{else}'ccshow'{/if})"
                                   value="{$lang.submit}" style="font-weight:bold"/>
                        </div>
                    </div>
                {else}
                    <div id="cc_cont" style="min-height: 2em">
                        <div class="o1">
                            This client do not have credit card nor bank account added <br/>
                            {if $admindata.access.editCC}
                                <a href="#" onclick="return add_cc();">Click to add Credit Card</a>
                                |
                                <a href="#" onclick="return add_ach();">Click to add Bank Account</a>
                            {/if}
                        </div>
                        {if $admindata.access.editCC}
                            <div class="o2" style="display:none"></div>
                        {/if}
                    </div>
                {/if}
            {/if}

            <script type="text/javascript">
                {literal}
                function verify_pass(act) {
                    act = $('#ccbutton').attr('data-action');
                    //act = act || 'ccard';
                    if ($('#admin_pass').val() == '')
                        $('#admin_pass').val('none');
                    $('#cc_cont').addLoader();
                    ajax_update('?cmd=clients', {
                        action: act,
                        client_id: $('#client_id').val(),
                        passprompt: $('#admin_pass').val()
                    }, '#cc_cont');
                    return false;
                }

                function edit_cc() {
                    return add_cc();
                }

                function load_cc_verify(action) {
                    $('#cc_cont .o1').hide();
                    $('#ccbutton').attr('data-action', action)
                    $('#cc_cont .o2').show();
                    return false;
                }

                function view_cc() {

                }

                function add_cc() {
                    $('#cc_cont .o1').hide();
                    $('#cc_cont').addLoader();
                    ajax_update('?cmd=clients&action=ccadd', {client_id: $('#client_id').val()}, '#cc_cont');
                    return false;
                }

                function add_ach() {
                    $('#cc_cont .o1').hide();
                    $('#cc_cont').addLoader();
                    ajax_update('?cmd=clients&action=achadd', {client_id: $('#client_id').val()}, '#cc_cont');
                    return false;
                }

                $(document).on('keydown', '#admin_pass', function (e) {
                    if (e.keyCode == 13) {
                        verify_pass();
                        return false;
                    }
                })
                {/literal}
            </script>
        </div>
        {if $picked_tab}
            <script type="text/javascript">
                {literal}
                function fireme() {
                    $('#{/literal}{$picked_tab}{literal}_tab').click();
                }

                appendLoader('fireme');
                {/literal}
            </script>
        {/if}
        <div id="ticketbody">
            <h1>
                #{$client.client_id} {$client.companyname} {if $client.firstname || $client.lastname} - {/if} {$client.firstname} {$client.lastname}</h1>
            <div id="client_nav">
                <!--navigation-->
                <a class="nav_el nav_sel left" href="#">{$lang.clientprofile}</a>
                {include file="_common/quicklists.tpl" _client=$client.client_id _parent=$client.parent_id}

                <div class="clear"></div>
            </div>

            <div class="ticketmsg ticketmain" id="client_tab">
                <div class="slide" style="display:block">

                    <div class="right replybtn tdetail {if ! isset($admindata.access.editClients)}isForbidAccess{/if} " id="tdetail">
                        <strong>
                            <a href="#">
                                <span class="a1">{$lang.editdetails}</span>
                                <span class="a2">{$lang.hidedetails}</span>
                            </a>
                        </strong>
                    </div>

                    <div id="detcont">
                        <div class="tdetails">
                            <table border="0" width="90%" cellspacing="5" cellpadding="0">
                                {foreach from=$fields item=field key=k name=floop}
                                    {if $smarty.foreach.floop.index%3==0}<tr>{/if}
                                    <td width="100" align="right" {if $field.type=='Company'}class="iscomp light"
                                        style="{if $client.company!='1'}display:none{/if}"
                                        {elseif $field.type=='Private'}class="ispr light"
                                        style="{if $client.company=='1'}display:none{/if}"
                                        {else}class="light"{/if}>
                                        {if $k=='type'}
                                            {$lang.clacctype}
                                        {elseif $field.options & 1}
                                            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                        {else}
                                            {$field.name}
                                        {/if}:
                                    </td>
                                    <td width="150" align="left" {if $field.type=='Company'}class="iscomp"
                                        style="{if $client.company!='1'}display:none{/if}"
                                        {elseif $field.type=='Private'}class="ispr"
                                        style="{if $client.company=='1'}display:none{/if}" {else}{/if}>
                                        <span class="{if $field.field_type != 'File'} livemode {/if}">
                                            {if $k=='type'}{if $client.company=='0'}{$lang.Private}{/if}
                                                {if $client.company=='1'}{$lang.Company}{/if}
                                            {elseif $k=='country'}
                                                {$client.country} - {$client.countryname}
                                            
                                            {elseif $k=='mailingaddress'}
                                               {if $isMailingAddress}
                                               {$mAddrPerson}<br />
                                               {$mAddrAddress}<br />
                                               {$mAddrProvince} {$mAddrZipcode}<br />
                                               {else}
                                               <span class="clientmsg">ใช้ที่อยู่เดียวกันกับ client address</span>
                                               {/if}
                                            
                                            {else}
                                                {if $field.field_type=='Password'}
                                                {elseif $field.field_type=='Check'}
                                                    {foreach from=$field.default_value item=fa}
                                                        {if in_array($fa,$client[$k])}{$fa},{/if}
                                                    {/foreach}
                                                {elseif $field.field_type=='File'}
                                                    {if $client[$k]}
                                                        <a class="left"
                                                           href="?cmd=root&amp;action=download&amp;type=downloads&amp;id={$client[$k]}">Download</a>
                                                    {else}{$lang.none}
                                                    {/if}
                                                {elseif $field.field_type == 'Contact'}
                                                    {foreach from=$field.default_value item=fa key=id}
                                                        {if $client[$field.code]==$id}{$fa}{/if}
                                                    {/foreach}
                                                {else}
                                                    {$client[$k]}
                                                {/if}
                                            {/if}
                                        </span>
                                    </td>
                                    {if $smarty.foreach.floop.index%3==5}</tr>{/if}
                                {/foreach}
                                <tr>
                                    <td width="100" align="right" class="light">{$lang.clacctype}:</td>
                                    <td width="150" align="left">
                                        <span class="livemode">
                                            {if $client.company=='0'}{$lang.Private}{/if}
                                            {if $client.company=='1'}{$lang.Company}{/if}
                                        </span>
                                    </td>
                                    {if count($currencies)>1}
                                        <td width="100" align="right" class="light">{$lang.currency}:</td>
                                        <td width="150" align="left"
                                        <span class="livemode">
                                            {foreach from=$currencies item=curre}
                                                {if $client.currency_id==$curre.id}{$curre.code}{/if}
                                            {/foreach}
                                        </span>
                                        </td>
                                    {else}
                                        <td colspan="2"></td>
                                    {/if}
                                    <td width="100" align="right" class="light">{$lang.Status}:</td>
                                    <td width="150" align="left">
                                        <span class="{$client.status} livemode">{$lang[$client.status]}</span>
                                    </td>
                                </tr>
                                {if $groups}
                                    <tr>
                                        <td width="100" align="right" class="light">{$lang.Group}:</td>
                                        <td width="150" align="left">
                                            <span style="color:{$client.group_color}"
                                                  class="livemode">{$client.group_name}</span>
                                        </td>
                                        <td colspan="2"></td>
                                        <td colspan="2"></td>
                                        </td>
                                    </tr>
                                {/if}
                            </table>
                        </div>
                        <div class="secondtd" style="display:none">
                            <table border="0" width="100%" cellspacing="5" cellpadding="0">

                                {foreach from=$fields item=field key=k name=floop}
                                    {if $smarty.foreach.floop.index%3==0}<tr>
                                    {/if}
                                    <td width="100" align="right" {if $field.type=='Company'}class="iscomp light"
                                        style="{if $client.company!='1'}display:none{/if}"
                                        {elseif $field.type=='Private'}class="ispr light"
                                        style="{if $client.company=='1'}display:none{/if}"
                                        {else}class="light"{/if}>
                                        {if $k=='type'}
                                            {$lang.clacctype}
                                        {elseif $field.options & 1}
                                            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                        {else}
                                            {$field.name}
                                        {/if}:
                                    </td>
                                    <td {if $field.type=='Company'}class="iscomp"
                                        style="{if $client.company!='1'}display:none{/if}"
                                        {elseif $field.type=='Private'}class="ispr"
                                        style="{if $client.company=='1'}display:none{/if}" {else}{/if}>
                                        {if $field.description}
                                            <span class="vtip_description">{$field.description}</span>
                                        {/if}
                                        {if $k=='type'}
                                        {elseif $k=='country'}<select name="country"  id="field_live_{$field.code}">
                                            {foreach from=$countries key=k item=v}
                                                <option value="{$k}" {if $k==$client.country} selected="Selected"{/if}>{$v}</option>
                                            {/foreach}
                                            </select>
                                        {else}
                                        
                                            {if $field.code == 'mailingaddress'}
                                                 
                                                <script language="JavaScript">
                                                {literal}
                                                function nwUpdateMailingAddress () {
                                                    var mAddress       = '';
                                                    var isDifference   = $('input:radio[name=isMailingAddress]:checked').val();
                                                    if (isDifference == '0') {
                                                        $('#mailingaddress').text(mAddress);
                                                        return false;
                                                    }
                                                    mAddress       += 'ชื่อผู้รับ:' + $('#mAddrPerson').val() + "\n"
                                                               + 'ที่อยู่:' + $('#mAddrAddress').val() + "\n"
                                                               + 'จังหวัด:' + $('#mAddrProvince').val() + "\n"
                                                               + 'รหัสไปรษณีย์:' + $('#mAddrZipcode').val();
                                                    $('#mailingaddress').text(mAddress);
                                                    return false;
                                                }
                                                {/literal}
                                                </script>
                
                                                 <div style="width:550px; display:block;">
                                                 <label><input type="radio" name="isMailingAddress" value="0" {if $isMailingAddress == false} checked="checked" {/if} onclick="$('#mAddrForm').hide();nwUpdateMailingAddress();" /> ใช้ที่อยู่เดียวกันกับ client address</label><br />
                                                 <label><input type="radio" name="isMailingAddress" value="1" {if $isMailingAddress == true} checked="checked" {/if} onclick="$('#mAddrForm').show();nwUpdateMailingAddress();" /> ต้องการให้จัดส่งเอกสารไปยังที่อยู่อื่น</label>
                                                 </div>
                                                 <div id="mAddrForm" style="width:550px; display:block; background-color:#E0EEE0; padding:3px; border:1px solid #CCCCCC; {if !$isMailingAddress} display:none; {/if}">
                                                    <div><label>ชื่อผู้รับ: <input type="text" id="mAddrPerson" value="{$mAddrPerson}" size="30" onchange="nwUpdateMailingAddress();" /></label></div>
                                                    <div><label>ที่อยู่: <br /><textarea id="mAddrAddress" cols="50" rows="3" onchange="nwUpdateMailingAddress();">{$mAddrAddress}</textarea></label></div>
                                                    <div style="width:550px; display:block;">
                                                       <label>จังหวัด: <input type="text" id="mAddrProvince" value="{$mAddrProvince}" size="30" onchange="nwUpdateMailingAddress();" /></label>
                                                       <label>รหัสไปรษณีย์: <input type="text" id="mAddrZipcode" value="{$mAddrZipcode}" size="10" onchange="nwUpdateMailingAddress();" /></label>
                                                    </div>
                                                 </div>
                                                 <textarea id="mailingaddress" name="{$field.code}" style="width: 80%; display:none;">{$client[$field.code]}</textarea>
                                                 
       
                                        
                                            {elseif $field.field_type=='Password'}
                                            {elseif $field.field_type=='Input'}
                                                <input value="{$client[$field.code]}" id="field_live_{$field.code}"
                                                       name="{$field.code}" style="width: 80%;"/>
                                            {elseif $field.field_type=='Check'}
                                                {foreach from=$field.default_value item=fa key=fk}
                                                    <input type="checkbox" name="{$field.code}[{$fk}]" value="1"
                                                           {if in_array($fa,$client[$field.code])}checked="checked"{/if}/>{$fa}
                                                    <br/>
                                                {/foreach}
                                            {elseif $field.field_type=='File'}
                                                {foreach from=$field.default_value item=fa key=fk}
                                                    <input type="file" name="{$field.code}">
                                                {/foreach}
                                            {elseif $field.field_type == 'Contact'}
                                                <select name="{$field.code}" id="field_live_{$field.code}">
                                                    {foreach from=$field.default_value item=fa key=id}
                                                       <option value="{$id}" {if $client[$field.code]==$id}selected="selected"{/if}>{$fa}</option>
                                                    {/foreach}
                                                </select>
                                            {else}
                                                <select name="{$field.code}" id="field_live_{$field.code}"
                                                        style="width: 80%;">
                                                    {foreach from=$field.default_value item=fa}
                                                        <option {if $client[$field.code]==$fa}selected="selected"{/if}>{$fa}</option>
                                                    {/foreach}
                                                </select>
                                            {/if}
                                        {/if}</td>
                                    {if $smarty.foreach.floop.index%3==5}</tr>{/if}
                                {/foreach}

                                <tr>

                                    <td width="100" align="right" class="light">{$lang.clacctype}:</td>
                                    <td width="150" align="left">
                                        <select name="type" onchange="{literal}if ($(this).val() == 'Private') {
                                                                    $('.iscomp').hide();
                                                                    $('.ispr').show();
                                                                } else {
                                                                    $('.ispr').hide();
                                                                    $('.iscomp').show();
                                                                }{/literal}">
                                            <option value="Private"
                                                    {if $client.company=='0'}selected="selected"{/if}>{$lang.Private}</option>
                                            <option value="Company"
                                                    {if $client.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
                                        </select></td>

                                    {if count($currencies)>1}
                                        <td width="100" align="right" class="light">{$lang.currency}:</td>
                                        <td width="150" align="left">
                                            <select name="currency_id" id="currency_id">
                                                {foreach from=$currencies item=curre}
                                                    <option value="{$curre.id}"
                                                            {if $client.currency_id==$curre.id}selected="selected"{/if}>{if $curre.iso}{$curre.iso}{else}{$curre.code}{/if}</option>
                                                {/foreach}
                                            </select></td>
                                    {else}
                                        <td colspan="2"><input type="hidden" id="currency_id"
                                                               value="{$client.currency_id}"/></td>
                                    {/if}

                                    <td width="100" align="right" class="light">{$lang.Status}:</td>
                                    <td width="150" align="left">
                                        <span class="vtip_description">
                                            <span>
                                                <b>{$lang.Active}</b> - Regular status<br>
                                                <b>{$lang.Closing}</b> - Client can manage current services, but is not
                                                allowed to order new ones<br>
                                                <b>{$lang.Closed}</b> - Client won't be able to login<br>
                                                <b>{$lang.PendingRemoval}</b> - Client account is <b>{$lang.Closed}</b>,
                                                and will be removed within few days<br>
                                                <b>{$lang.Archived}</b> - Client account is archived
                                            </span>
                                        </span>
                                        <select name="status">
                                            {foreach from=$client_status item=status}
                                                <option value="{$status}"
                                                        {if $client.status==$status}selected="selected"{/if}>{$lang[$status]}</option>
                                            {/foreach}
                                        </select>
                                    </td>

                                </tr>
                                {if $groups}
                                    <tr>
                                        <td width="100" align="right" class="light">{$lang.Group}:</td>
                                        <td width="150" align="left"><select name="group_id">
                                                <option value="0"
                                                        {if $client.group_id=='0'}selected="selected"{/if}>{$lang.none}</option>
                                                {foreach from=$groups item=group}
                                                    <option value="{$group.id}" style="color:{$group.color}"
                                                            {if $client.group_id==$group.id}selected="selected"{/if}>{$group.name}</option>
                                                {/foreach}
                                            </select></td>

                                        <td colspan="2"></td>
                                        <td colspan="2"></td>
                                        </td>
                                    </tr>
                                {/if}
                                <tr></tr>
                            </table>
                        </div>
                    </div>
                </div>
                {include file="_common/quicklists.tpl" _placeholder=true}
            </div>

            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-bottom: 20px;background:#fff">
                <tr>
                    <td width="50%" valign="top">
                        <div id="detcont">
                            <div class="tdetails">
                                <table border="0" width="100%" cellspacing="5" cellpadding="0">
                                    <tr>
                                        <td width="25%" align="right" class="light">{$lang.timezone}:</td>
                                        <td width="25%" align="left">
                                            <span class="livemode no-wrap">
                                                <span class="label label-default-invert">
                                                    {$settings.DefaultTimezone.selected.title}
                                                </span>
                                            </span>
                                        </td>
                                        <td width="50%"></td>
                                    </tr>
                                    <tr>
                                        <td width="25%" align="right" class="light">{$lang.defaultlanguage}:</td>
                                        <td width="25%" align="left">
                                            <span class="livemode">{$client.language}</span>
                                        </td>
                                        <td width="50%"></td>
                                    </tr>
                                    <tr>
                                        <td width="25%" align="right" class="light">{$lang.password}:</td>
                                        <td width="25%" align="left"><span class="livemode">**********</span></td>
                                        <td width="50%"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="secondtd" style="display:none">
                                <table border="0" width="100%" cellspacing="5" cellpadding="0">
                                    <tr>
                                        <td width="25%" align="right" class="light">{$lang.timezone}:</td>
                                        <td width="25%" align="left">
                                            <select name="automation[DefaultTimezone]" style="max-width: 200px">
                                                {foreach from=$settings.DefaultTimezone.items item=opt}
                                                    <option value="{$opt.value}" {if $opt.selected}selected{/if} >
                                                        {$opt.title}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </td>
                                        <td width="50%"></td>
                                    </tr>
                                    <tr>
                                        <td width="25%" align="right" class="light">{$lang.defaultlanguage}:</td>
                                        <td width="25%" align="left">
                                            <select name="language">
                                                {foreach from=$client_languages key=k item=v}
                                                    <option {if $v==$client.language} selected="selected"{/if}>{$v}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                        <td width="50%"></td>
                                    </tr>
                                    <tr>
                                        <td width="25%" align="right" class="light">{$lang.newpass}:</td>
                                        <td width="25%" align="left">
                                            <input name="password" type="password" autocomplete="off"/>
                                        </td>

                                        <td width="25%" align="right" class="light">{$lang.repeatpass}:</td>
                                        <td width="25%" align="left">
                                            <input name="password2" type="password" autocomplete="off"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </td>
                    <td width="50%" valign="top" style="padding-left:5px;">

                        <div id="detcont">

                            <table border="0" width="100%" cellspacing="0" cellpadding="4">
                                <tr>
                                    <td width="25%" align="right" class="light">{$lang.signupdate}:</td>
                                    <td width="75%" align="left">{$client.datecreated|date_format:'%d %b %Y'}</td>
                                </tr>

                                <tr>
                                    <td width="25%" align="right" class="light">{$lang.clientlastlogin}:</td>
                                    <td width="75%"
                                        align="left">{if $client.lastlogin == '0000-00-00 00:00:00'}{$lang.never}{else}{$client.lastlogin|date_format:'%d %b %Y'}{/if}</td>
                                </tr>

                                <tr>
                                    <td width="25%" align="right" class="light">{$lang.From}:</td>
                                    <td width="75%" align="left">{$client.ip} {$lang.Host}: {$client.host}</td>
                                </tr>

                                <tr>
                                    <td width="25%" align="right" class="light">Assigned to Affiliate:</td>
                                    <td width="75%" align="left">
                                        {if $client.assigned_affiliate}
                                            <a href="?cmd=affiliates&action=affiliate&id={$client.assigned_affiliate.id}"/>
                                            {$client.assigned_affiliate.firstname} {$client.assigned_affiliate.lastname}
                                            </a>
                                        {else}
                                            None
                                        {/if}
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="p6 secondtd"
                             style="display:none;text-align:center;margin-bottom:0px;margin-top:15px;padding:15px 0px;">
                            <a class="btn btn-success" href="#" onclick="$('#clientsavechanges').click();
                                                                return false;"><span>{$lang.savechanges}</span>
                            </a>
                            <span class="orspace fs11">{$lang.Or}</span>
                            <a href="#" class="editbtn" onclick="$('#tdetail a').click();
                                                                return false;">{$lang.Cancel}</a>
                            <input type="submit" value="{$lang.savechanges}" id="clientsavechanges" style="display:none"
                                   name="save"/>
                            <input type="hidden" value="1" name="save"/>
                        </div>
                    </td>
                </tr>
                {php}
                    $templatePath   = $this->get_template_vars('template_path');
                    include($templatePath . 'clientspartner.tpl.php');
                {/php}
                {if $isRVPatrnet}
                                       
                <tr>
                    <td colspan="2">
                        <h4>Partner Information</h4>
                        <div id="clientspartner"></div>
                        <script>
                        {literal}
                        appendLoader('convert_rvpartner_load');
                        var convert_rvpartner_load = function(){
                            ajax_update('?cmd=clients&action=clientspartner&client_id=' + $('#client_id').val(), {}, '#clientspartner');
                        }
                        {/literal}
                        </script>
                    </td>
                </tr>
                {/if}
                

        </table>
        {securitytoken}

    </div>
    </div>
    <div class="row no-gutter" style="margin-top:20px;">
        <div class="col-md-6 mainleftcol">

            <div class="box box-primary ">
                <div class="box-header">
                    <div class="pull-right">

                    </div>
                    <h3 class="box-title">Settings & Automation <i class="fa fa-cog pull-left"></i></h3>
                </div>
                <div class="box-body">
                {include file="clients/settings.tpl"}
                </div>
                <div class="box-footer clearfix no-border">
                    <a class="btn btn-primary btn-xs" href="?cmd=clients&action=overrides&id={$client.id}">
                        Edit client automation settings
                    </a>
                    <div class="bborder-legend"><span class="bg-warning"></span> Group overrides</div>
                    <div class="bborder-legend"><span class="bg-danger"></span> Client overrides</div>

                </div>
            </div>

            {if !$forbidAccess.clientBalance}
                <div class="box box-primary  ">
                <div class="box-header">
                    <h3 class="box-title">Client stats <i class="fa fa-line-chart pull-left"></i></h3>
                </div>
                <div class="box-body">
                    <div>
                        {include file="clients/statistics.tpl"}
                    </div>
                </div>
                </div>
            {/if}

            {if $stats.affiliate}
                <div class="box box-primary  ">
                    <div class="box-header">
                        <h3 class="box-title">Affiliate <i class="fa fa-user pull-left"></i></h3>

                    </div>
                    <div class="box-body">
                        <div>

                            <table border="0" cellpadding="3" cellspacing="0" width="100%">
                                <tr>
                                    <td><strong>{$lang.affiliatehash}</strong></td>
                                    <td>
                                        <a href="?cmd=affiliates&action=affiliate&id={$stats.affiliate.id}">{$stats.affiliate.id}</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.affsince}</strong></td>
                                    <td>{$stats.affiliate.date_created|dateformat:$date_format}</td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.convrate}</strong></td>
                                    <td>{$stats.affiliate.conversion} %</td>
                                </tr>
                                <tr>
                                    <td><strong>{$lang.balance}</strong></td>
                                    <td>{$stats.affiliate.balance|price:$stats.currency_id}</td>
                                </tr>
                            </table>

                        </div>
                    </div>
                </div>
            {/if}

        </div>

        <div class="col-md-6 mainrightcol">
            {adminwidget module="clients" section="profilewidgets"}
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Contact Client <i class="fa fa-envelope pull-left"></i></h3>
                </div>
                <div class="box-body">
                    <div id="" class="form-horizontal">
                        <a href="?cmd=sendmessage&type=clients&selected={$client_id}" class="btn btn-default btn-sm"
                           target="_blank">{$lang.SendEmail}</a>
                        {if 'config:MobileNotificationsClient:on'|checkcondition}
                            <a href="?cmd=sendmessage&action=asmobile&type=clients&selected={$client_id}"
                               class="btn btn-default btn-sm" target="_blank">{$lang.send_notification}</a>
                        {/if}
                        <a href="?cmd=tickets&action=new&client_id={$client_id}" class="btn btn-default btn-sm"
                           target="_blank">{$lang.opennewticket}</a>
                        {if 'config:EnablePortalNotifications:on'|checkcondition}
                            <a href="?cmd=sendmessage&action=asnotification&type=clients&selected={$client_id}"
                               class="btn btn-default btn-sm" target="_blank">{$lang.SendNotification}</a>
                        {/if}
                        <hr>
                        <div class="form-group">
                            
                            <div class="col-sm-12">
                                {if isset($admindata.access.editClients)}
                                    {assign var=editable value='true'}
                                {else}
                                    {assign var=editable value=''}
                                {/if}
                                {*include file='_common/noteseditor.tpl' editable=$editable*}
                            </div>
                            
                            <div class="col-sm-2">
                                <label>{$lang.SendMessage}</label>
                            </div>
                            <div class="col-sm-8">
                                <select name="mail_id" id="mail_id" style="width: 100%">
                                    <option value="1">Details:Signup</option>
                                    {foreach from=$client_emails item=send_email}
                                        <option value="{$send_email.id}">{$send_email.tplname}</option>
                                    {/foreach}
                                    <option value="custom" style="font-weight:bold">{$lang.newmess}</option>

                                </select>
                            </div>
                            <div class="col-sm-2">
                                <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail"
                                       class="btn btn-primary btn-sm"/>
                            </div>
                        </div>
                        {if $mobilenotify}
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>{$lang.SendTextMessage}</label>
                                </div>
                                <div class="col-sm-8">
                                    <select name="sms_id" id="sms_id" style="width: 100%">
                                        {foreach from=$client_sms.All item=send_email}
                                            {if $send_email.for!='Client'}{continue}{/if}
                                            <option value="{$send_email.id}">{$send_email.tplname}</option>
                                        {/foreach}
                                        {foreach from=$client_sms.Custom item=send_email}
                                            {if $send_email.for!='Client'}{continue}{/if}
                                            <option value="{$send_email.id}">{$send_email.tplname}</option>
                                        {/foreach}
                                        <option value="custom" style="font-weight:bold">{$lang.newmess}</option>
                                    </select>
                                </div>
                                <div class="col-sm-2">
                                    <input type="button" name="sendsms" value="{$lang.Send}" id="sendsms"
                                           class="btn btn-primary btn-sm"/>
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>

            <div class="box box-primary  ">
                <div class="box-header">
                    <h3 class="box-title">Queued Invoice Items <i class="fa fa-list pull-left"></i></h3>

                </div>
                <div class="box-body">
                    <div id="itemqueue">
                        {include file="ajax.itemqueue.tpl" currency=$client_currency}
                    </div>
                </div>
            </div>


            <div class="box box-primary  ">
                <div class="box-header">
                    <h3 class="box-title">Client Files <i class="fa fa-paperclip pull-left"></i></h3>

                </div>
                <div class="box-body">
                    <div id="clientfiles">
                        {include file="ajax.clientfiles.tpl"}
                    </div>
                </div>
            </div>

            <div class="box box-primary  ">
                <div class="box-header">
                    <h3 class="box-title">Client notes <i class="fa fa-sticky-note-o pull-left"></i></h3>

                </div>
                <div class="box-body">
                    <div id="clientnotes">
                        {include file='_common/noteseditor.tpl'}

                    </div>
                </div>
            </div>


            <div class="box box-primary  no-padding">
                <div class="box-header">
                    <h3 class="box-title">Client Profile Changes <i class="fa fa-clock-o pull-left"></i></h3>

                </div>
                <div class="box-body">
                    <div id="clienthistory">
                        {include file="clients/ajax.changeslog.tpl"}
                    </div>
                </div>
            </div>


        </div>
    </div>

</form>
