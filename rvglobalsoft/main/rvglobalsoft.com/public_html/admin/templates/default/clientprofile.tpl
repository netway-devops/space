{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientprofile.tpl.php');
{/php}

<script type="text/javascript">
    lang['deleteprofileheading'] = "{$lang.deleteprofileheading}";
    lang['convertclientheading'] = "{$lang.convertclientheading}";
</script>

<div class="blu">
    <div class="menubar">
        <a href="?cmd=clients&action=show&id={$parent.id}">
            <strong>&laquo; {$lang.backtoclient}</strong>
        </a>
        &nbsp;
        {if $action=='showprofile'}
            <a class=" menuitm menu-auto" href="{$system_url2}?action=adminlogin&id={$client.client_id}"
               target="_blank">
                <span><strong>{$lang.loginascontact}</strong></span>
            </a>
            <a class="menuitm clDropdown menu-auto" id="hd1" onclick="return false" href="#">
                <span class="morbtn">{$lang.moreactions}</span>
            </a>
            <ul id="hd1_m" class="ddmenu">
                <li><a href="SendNewPass">{$lang.SendNewPass}</a></li>
                <li><a href="ConvertToClient">{$lang.converttoclient}</a></li>
                <li  class="{if ! isset($admindata.access.editClients)}isForbidAccess{/if}" >
                    <a href="?cmd=clients&action=showprofile&id={$client.id}&make=close&security_token={$security_token}"
                       class="directly">{$lang.CloseAccount}</a></li>
                <li class="{if ! isset($admindata.access.deleteClients)}isForbidAccess{/if}" ><a href="DeleteContact" style="color:#ff0000">{$lang.deletecontact}</a></li>
            </ul>
        {/if}
    </div>
</div>

<form action='' method='post'  {if ! isset($admindata.access.editClients)} onsubmit="return false;" {/if} >
    <input type="hidden" value="{$client.client_id}" name="id" id="client_id"/>
    <input type="hidden" value="{$parent.id}" name="parent_id" id="parent_id"/>
    <input type="hidden" value="main" name="section_submit">
    <div id="ticketbody">
        {if $action=='showprofile'}
            <h1>#{$parent.id} <a
                        href="?cmd=clients&action=show&id={$parent.id}">{$parent.firstname} {$parent.lastname}</a> {$lang.contact}
                : {$client.firstname} {$client.lastname}</h1>
            <div id="client_nav">
                <!--navigation-->
                <a class="nav_el nav_sel left" href="#">Contact profile</a>
                {*include file="_common/quicklists.tpl"*}

                <div class="clear"></div>
            </div>
            <div class="ticketmsg ticketmain" id="client_tab">
                <div class="slide" style="display:block">

                    <div class="right replybtn tdetail  {if ! isset($admindata.access.editClients)}isForbidAccess{/if}  " id="tdetail">
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
                                    {if $smarty.foreach.floop.index%3==0}<tr>
                                    {/if}
                                    <td width="100" align="right"
                                        {if $field.type=='Company'}class="iscomp light"
                                        style="{if $client.company!='1'}display:none{/if}"
                                        {elseif $field.type=='Private'}class="ispr light"
                                        style="{if $client.company=='1'}display:none{/if}" {else}class="light"{/if}>
                                        {$k}
                    
                                        {if $k == 'mailingaddress'}
                                        
                                            {literal}
                                            <script language="JavaScript">
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
                                            </script>
                                            {/literal}
            
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
                                 
                                        
                                        {elseif $k=='type'}
                                            {$lang.clacctype}
                                        {elseif $field.options & 1}
                                            {if $lang[$k]}{$lang[$k]}
                                            {else}{$field.name}
                                            {/if}
                                        {else}
                                            {$field.name}
                                        {/if}:
                                    </td>
                                    <td  align="left"
                                        {if $field.type=='Company'}class="iscomp"
                                        style="{if $client.company!='1'}display:none{/if}"
                                        {elseif $field.type=='Private'}class="ispr"
                                        style="{if $client.company=='1'}display:none{/if}" {/if}>
                                        <span class="livemode">
                                            {if $k=='type'}
                                                {if $client.company=='0'}{$lang.Private}
                                                {/if}
                                                {if $client.company=='1'}{$lang.Company}
                                                {/if}

                                            {elseif $k=='country'}
                                                {$client.country} - {$client.countryname}
                                            {else}
                                            
                                            {if $k == 'mailingaddress'}
                                            
                                                {literal}
                                                <script language="JavaScript">
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
                                                </script>
                                                {/literal}
                
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
                                                 <textarea id="mailingaddress" name="{$k}" style="width: 80%; display:none;">{$submit[$k]}</textarea>
                                     
                                            
                                                {elseif $field.field_type=='Password'}
                                                {elseif $field.field_type=='Check'}
                                                    {foreach from=$field.default_value item=fa}
                                                        {if in_array($fa,$client[$k])}{$fa},{/if}
                                                    {/foreach}
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
                                    <td  align="left">
                                        <span class="livemode">{if $client.company=='0'}{$lang.Private}{/if}
                                            {if $client.company=='1'}{$lang.Company}{/if}</span>
                                    </td>

                                    <td width="100" align="right" class="light">{$lang.Status}:</td>
                                    <td  align="left"><span
                                                class="{$client.status} livemode">{$lang[$client.status]}</span></td>
                                </tr>

                                <tr>
                                    <td align="right" class="light">{$lang.signupdate}:</td>
                                    <td align="left">{$client.datecreated|dateformat2:$date_format}</td>
                                    <td align="right" class="light">{$lang.clientlastlogin}:</td>
                                    <td align="left">{if $client.lastlogin == '0000-00-00 00:00:00'}{$lang.never}{else}{$client.lastlogin|dateformat2:$date_format}{/if}</td>
                                    <td align="right" class="light">{$lang.From}:</td>
                                    <td align="left">{$client.ip} {$lang.Host}: {$client.host}</td>
                                </tr>

                                <tr>
                                    <td width="100" align="right" class="light">{$lang.password}:</td>
                                    <td  align="left"><span class="livemode">**********</span></td>
                                    <td colspan="2" ></td>
                                </tr>
                            </table>
                        </div>


                        <div class="secondtd" style="display:none">
                            <table border="0" width="100%" cellspacing="5" cellpadding="0">

                                {foreach from=$fields item=field key=k name=floop}
                                    {if $smarty.foreach.floop.index%3==0}<tr>
                                    {/if}
                                    <td width="100" align="right"
                                        {if $field.type=='Company'}class="iscomp light"
                                        style="{if $client.company!='1'}display:none{/if}"
                                        {elseif $field.type=='Private'}class="ispr light"
                                        style="{if $client.company=='1'}display:none{/if}"
                                        {else}class="light"{/if}>
                                        {if $k=='type'}
                                            {$lang.clacctype}
                                        {elseif $field.options & 1}
                                            {if $lang[$k]}{$lang[$k]}
                                            {else}{$field.name}
                                            {/if}
                                        {else}
                                            {$field.name}
                                        {/if}:
                                    </td>
                                    <td {if $field.type=='Company'}class="iscomp"
                                        style="{if $client.company!='1'}display:none{/if}"
                                        {elseif $field.type=='Private'}class="ispr"
                                        style="{if $client.company=='1'}display:none{/if}" {else}{/if}>
                                        {if $k=='type'}
                                        {elseif $k=='country'}
                                            <select name="country" id="field_live_{$field.code}">
                                                {foreach from=$countries key=k item=v}
                                                    <option value="{$k}" {if $k==$client.country} selected="Selected"{/if}>{$v}</option>
                                                {/foreach}
                                            </select>
                                        {else}
                                        
                                            {if $k == 'mailingaddress'}
                                            
                                                {literal}
                                                <script language="JavaScript">
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
                                                </script>
                                                {/literal}
                
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
                                                 <textarea id="mailingaddress" name="{$k}" style="width: 80%; display:none;">{$submit[$k]}</textarea>
                                     
                                        
                                            {elseif $field.field_type=='Password'}
                                            {elseif $field.field_type=='Input'}
                                                <input value="{$client[$field.code]}" id="field_live_{$field.code}"
                                                       name="{$field.code}" style="width: 80%;"/>
                                            {elseif $field.field_type=='Check'}
                                                {foreach from=$field.default_value item=fa}
                                                    <input type="checkbox" name="{$field.code}[{$fa}]" value="1"
                                                           {if in_array($fa,$client[$field.code])}checked="checked"{/if}/>{$fa}
                                                    <br/>
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
                                    <td  align="left">
                                        <select id="contacttype" name="type">
                                            <option value="Private"
                                                    {if $client.company=='0'}selected="selected"{/if}>{$lang.Private}</option>
                                            <option value="Company"
                                                    {if $client.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
                                        </select></td>

                                    <td width="100" align="right" class="light">{$lang.Status}:</td>
                                    <td  align="left">
                                        <select name="status" id="contacstatus">
                                            <option value="Active"
                                                    {if $client.status=='Active'}selected="selected"{/if}>{$lang.Active}</option>
                                            <option value="Closed"
                                                    {if $client.status=='Closed'}selected="selected"{/if}>{$lang.Closed}</option>
                                        </select>
                                    </td>

                                <tr>
                                    <td width="100" align="right" class="light">{$lang.newpass}:</td>
                                    <td  align="left"><input name="password"/></td>

                                    <td width="100" align="right" class="light">{$lang.repeatpass}:</td>
                                    <td  align="left"><input name="password2"/></td>
                                </tr>

                                </tr>
                            </table>
                            {literal}
                                <script>
                                    $('#contacttype').on('change', function () {
                                        var priv = $(this).val() == 'Private';
                                        $('.iscomp').toggle(!priv);
                                        $('.ispr').toggle(priv);
                                    })
                                    $('#contacstatus').on('change', function () {
                                        var actv = $(this).val() == 'Active';
                                        $('#privileges').toggle(actv);
                                    })
                                </script>
                            {/literal}
                        </div>
                    </div>


                </div>
                {*include file="_common/quicklists.tpl" _placeholder=true*}
            </div>
        {elseif $action=='newprofile'}
            <h1>#{$parent.id} <a
                        href="?cmd=clients&action=show&id={$parent.id}">{$parent.firstname} {$parent.lastname}</a>
                &raquo; {$lang.addcontact}</h1>
            <input type="hidden" name="id" value="{$parent.id}"/>
            <div id="client_tab" class="ticketmsg ticketmain">
                <div class="container-fluid clear lighterblue" style="padding-top:14px">
                    <div class="row">
                        <div class="col-md-6  col-lg-4">
                            {foreach from=$fields item=field name=floop key=k}
                                {if $smarty.foreach.floop.iteration > ($smarty.foreach.floop.total/2)}{break}
                                {/if}
                                {include file="clients/signup_input.tpl"}
                            {/foreach}
                        </div>
                        <div class="col-md-6  col-lg-4">
                            {foreach from=$fields item=field name=floop key=k}
                                {if $smarty.foreach.floop.iteration <= ($smarty.foreach.floop.total/2)}{continue}
                                {/if}

                                {include file="clients/signup_input.tpl"}
                            {/foreach}
                        </div>
                        <div class="col-md-4">

                            <div class="form-group">
                                <label>Optional: </label>
                                <div class="checkbox">
                                    <label>
                                        <input name="notifyclient" value="yes" type="checkbox"/> {$lang.notifyclient}
                                    </label>
                                </div>

                            </div>


                        </div>
                    </div>
                </div>
            </div>
        {/if}
        {literal}
            <style type="text/css">
                .pgroup {
                    padding: 0 0 20px 15px
                }
            </style>
        {/literal}
    </div>

    <div class="blu">
        <div class="menubar" style="text-align: center">
            <button type="submit" name="save" value="1" class="btn btn-success">
                {if $action=='showprofile'}
                    Save contact details
                {elseif $action=='newprofile'}
                    {$lang.addcontact}
                {/if}
            </button>
            {if $action=='newprofile'}
                <hr>
                <p>Add contact to manage permissions</p>
            {/if}
        </div>
    </div>
    {securitytoken}
</form>
{if $action=='showprofile'}
    <form action='' method='post'>
        <input type="hidden" value="{$client.client_id}" name="id" id="client_id"/>
        <input type="hidden" value="{$parent.id}" name="parent_id" id="parent_id"/>
        <input type="hidden" value="permissions" name="section_submit">
            <input type="hidden" value="{$privilages_pages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="left">
                    <h1>Contact Permissions:</h1>
                </div>
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=clients&action=showprofile_priviliages&id={$client.id}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table">
                <tbody>
                <tr>
                    <td id="updater">
                        {include file="ajax.clientprofile_priviliages.tpl"}
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right">
                    <div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
        <div class="blu">
            <div class="menubar" style="text-align: center">
                <button type="submit" name="save" value="1" class="btn btn-success">
                    Save Contact Permissions
                </button>
            </div>
        </div>
        {securitytoken}
    </form>
{/if}