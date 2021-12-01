{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'domains.tpl.php');
{/php}
<script type="text/javascript">loadelements.domains=true;</script>
<script type="text/javascript">
{literal}
$(document).ready(function() {

    $('#expiryDateStart').datePicker({
        startDate:'01/01/2000'
    });
    $('#expiryDateEnd').datePicker({
        startDate:'01/01/2000'
    });
    
});
{/literal}
</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter && !$details.manual}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.Domains}</h3></td>
        <td  class="searchbox">
            <div id="hider2" style="text-align:right">
                &nbsp;&nbsp;&nbsp;
                <a href="?cmd=domains&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=domains&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
            </div>
            <div id="hider" style="display:none"></div>
            
                
            <div style="text-align:left">
                <form action="?cmd=domains" method="get">
                <input type="hidden" name="cmd" value="domains" />
                <table width="700" border="0">
                <tr>
                    <td>ดู domain ที่จะหมดอายุ ระหว่างวันที่ &nbsp;</td>
                    <td>
                        <input id="expiryDateStart" name="expiryDateStart" type="text" value="{$expiryDateStart|dateformat:$date_format}" style="border:1px dotted gray; color: red; padding-left:10px; width:100px;" readonly="readonly" />
                    </td>
                    <td>ถึง &nbsp;</td>
                    <td>
                        <input id="expiryDateEnd" name="expiryDateEnd" type="text" value="{$expiryDateEnd|dateformat:$date_format}" style="border:1px dotted gray; color: red; padding-left:10px; width:100px;" readonly="readonly" />
                    </td>
                    <td>
                        <input type="submit" id="simpleSearch" name="simpleSearch" value="Search" class="menuitm">
                    </td>
                </tr>
                </table>
                </form>
            </div>
            
        </td>
    </tr>
    <tr>
        <td class="leftNav">


            <a href="?cmd=orders&action=createdraft"  class="tstyled btn btn-success"><strong>{$lang.newdomain}</strong></a><br>

            <a href="?cmd=domains&amp;list=all"  class="tstyled {if ($currentlist=='all' || !$currentlist) && $action!='sync'}selected{/if}">{$lang.Alldomains} <span>({$stats.All})</span></a>
            <a href="?cmd=domains&amp;list=active" class="tstyled {if $currentlist=='active'}selected{/if}">{$lang.Activedomains} <span>({$stats.Active})</span></a>
            <a href="?cmd=domains&amp;list=expired" class="tstyled {if $currentlist=='expired'}selected{/if}">{$lang.Expireddomains} <span>({$stats.Expired})</span></a>
            <a href="?cmd=domains&amp;list=pending" class="tstyled {if $currentlist=='pending'}selected{/if}">{$lang.Pendingdomains} <span>({$stats.Pending})</span></a>
            <a href="?cmd=domains&amp;list=pending_transfer" class="tstyled {if $currentlist=='pending transfer'}selected{/if}">{$lang.PendingTransfer} <span>({$stats.PendingTransfer})</span></a>
            <a href="?cmd=domains&amp;list=cancelled" class="tstyled {if $currentlist=='cancelled'}selected{/if}">{$lang.Cancelleddomains} <span>({$stats.Cancelled})</span></a>
            <br />
            <a href="?cmd=domains&amp;action=sync" class="tstyled {if $action=='sync'}selected{/if}">{$lang.domainsync_menu} </a>
        </td>

        <td  valign="top"  class="bordered"><div id="bodycont">
                {if $action=='edit' && $details}
                
                    <script type="text/javascript">
                    {literal}
                    $(document).ready(function() {
                        {/literal}{if ! isset($admindata.access.editInvoices)}$('.livemode').removeClass('livemode');{/if}{literal}
                    });
                    {/literal}
                    </script>
                
                    <form action="" method="post" id="dom_forms">
                        <input type="hidden" name="domain_id" value="{$details.id}" id="domain_id" />
                        <input type="hidden" name="domain_name" value="{$details.name}" id="domain_name" />
                        <input type="hidden" name="submitcus" value="1" />
                        <div class="blu">
                            <table border="0" cellpadding="2" cellspacing="0" >
                                <tr>
                                    <td class="menubar"><a href="?cmd=domains&list={$currentlist}"><strong>&laquo; {$lang.backto} {$currentlist} {$lang.domains}</strong></a>&nbsp;
                                        <input type="submit" name="save" value="{$lang.savechanges}" style="font-weight:bold;display:none"  id="formsubmiter"/> 
                                        
                                        {if isset($admindata.access.editAccounts)}
                                        <a class="menuitm" href="#" onclick="$('#formsubmiter').click();return false" ><span ><strong>{$lang.savechanges}</strong></span></a>
                                        {/if}
                                        {if isset($admindata.access.editAccounts)}
                                        <a class=" menuitm menu-auto" href="#" onclick="return confirm_delete()"><span style="color:#FF0000">{$lang.Delete}</span></a>
                                        {/if}
                                        {*
                                        *}<a class="setStatus menuitm menu-auto" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                                        {adminwidget module="domains" section="domainheader"}
                                    </td>
                                    <td><input type="checkbox" name="manual" value="1" {if $details.manual == '1'}checked="checked" {/if}  class="changeMode" style="display:none"/></td>
                                </tr>


                            </table>
                            <ul id="hd1_m" class="ddmenu">
                                <li  class="{if ! isset($admindata.access.editAccounts)}disabled{/if}" ><a href="AdminNotes">{$lang.editadminnotes}</a></li>
                                <li  class="{if ! isset($admindata.access.editAccounts)}disabled{/if}" ><a href="ChangeOwner">{$lang.changeowner}</a></li>
                                <!-- <li ><a href="DeleteDomain" style="color:#ff0000">Delete Domain</a></li> -->

                            </ul>
                        </div>

                        <div id="ChangeOwner" style="display:none;" bootbox data-title="{$lang.changeowner}"
                             data-formaction="?cmd=domains&action=edit&id={$details.id}&submitcus=1&changeowner=1">
                            <div class="form-group">
                                <label>{$lang.newowner}</label>
                                <select name="new_owner_id" class="form-control" style="min-width:180px"></select>
                            </div>
                            {securitytoken}
                        </div>

                        <div id="ticketbody">
                            <h1>{$lang.Domain} {$details.name} {if $details.premium}<label class="label label-danger-invert">premium</label>{/if}</h1>

                            <div id="client_nav">
                                <!--navigation-->
                                <a class="nav_el nav_sel left" href="#">{$lang.domaindetails}</a>
                                <a class="nav_el  left" href="?cmd=domains&action=log&id={$details.id}" onclick="return false">{$lang.domainlog}</a>
                                {include file="_common/quicklists.tpl" _client=$details.client_id}

                                <div class="clear"></div>
                            </div>
                            <div class="ticketmsg ticketmain" id="client_tab">
                                <div class="slide" style="display:block">
                                    <table cellspacing="2" cellpadding="3" border="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <td width="15%" >{$lang.orderid}</td>
                                                <td width="35%"><a href="?cmd=orders&action=edit&id={$details.order_id}">{$details.order_id}</a></td>
                                                <td width="15%" >{$lang.paymethod}</td>
                                                <td width="35%"><select name="payment_module" onclick="new_gateway(this)">
                                                        <option value="0">{$lang.none}</option>
                                                        {foreach from=$gateways item=module key=id}
                                                            <option value="{$id}" {if $details.payment_module==$id}selected="selected"{/if}>{$module}</option>
                                                        {/foreach}
                                                        <option value="new" style="font-weight: bold">{$lang.newgateway}</option>

                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >{$lang.Client}</td>
                                                <td ><a href="?cmd=clients&action=show&id={$details.client_id}">{$details.firstname} {$details.lastname}</a>  {if $admindata.access.loginAsClient} <a   class="menuitm"  href="{$system_url}?action=adminlogin&id={$details.client_id}" target="_blank"><span ><strong>Login as client</strong></span></a>{/if} </td>
                                                <td >{$lang.regperiod}</td>
                                                <td ><input type="text" size="4" name="period" value="{$details.period}" class="manumode" {if $details.manual!='1'}style="display:none"{/if} /> <span class="livemode"  {if $details.manual=='1'}style="display:none"{/if}>{$details.period} {$lang.yearslash}</span></td>
                                            </tr>

                                            <tr>
                                                <td >{$lang.ordertype}</td>
                                                <td >{$lang[$details.type]}</td>
                                                <td >{$lang.expirydate}</td>
                                                <td ><span class="manumode" {if $details.manual!='1'}style="display:none"{/if}><input type="text" class="haspicker" name="expires" value="{$details.expires|dateformat:$date_format}" size="12"  readonly="readonly" /></span> <span class="livemode"  {if $details.manual=='1'}style="display:none"{/if}>{if !$details.expires || $details.expires == '0000-00-00'}{$lang.none}{else}{$details.expires|date_format:'%d %b %Y'}{/if}</span></td>
                                            </tr>

                                            <tr>
                                                <td >{$lang.regdate}</td>
                                                <td><span class="manumode" {if $details.manual!='1'}style="display:none"{/if}><input type="text" class="haspicker" value="{$details.date_created|dateformat:$date_format}" name="date_created" size="12"  readonly="readonly" /></span> <span class="livemode"  {if $details.manual=='1'}style="display:none"{/if}>{if !$details.date_created || $details.date_created == '0000-00-00'}{$lang.none}{else}{$details.date_created|date_format:'%d %b %Y'}{/if}</span></td>
                                                <td >{$lang.next_due}</td>
                                                <td ><input type="text" class="haspicker" value="{$details.next_due|dateformat:$date_format}" name="next_due" size="12" readonly="readonly" /><a class="editbtn" href="?cmd=invoices&filter[item_id]={$details.id}&filter[type]=Domain" >{$lang.findrelatedinv}</a></td>
                                            </tr>
                                            <tr>
                                                <td >{$lang.Registrar}</td>
                                                <td >

                                                    <select name="reg_module" class="manumode" {if $details.manual!='1'}style="display:none"{/if} onclick="new_registrar(this)">
                                                        <option value="0">{$lang.none}</option>
                                                        {foreach from=$registrars item=registrar key=id}
                                                        {if $registrar != 'OpenSRS'}
                                                            <option {if $details.reg_module == $id}selected="selected" {/if}value="{$id}">{$registrar}</option>
                                                        {/if}
                                                        {/foreach}
                                                        <option value="new" style="font-weight: bold">{$lang.newregistrar}</option>
                                                    </select>

                                                    {if $module_set}
                                                        {foreach from=$registrars item=registrar key=id}
                                                            {if $details.reg_module == $id}
                                                                <span class="livemode"  {if $details.manual=='1'}style="display:none"{/if}>{$registrar}</span>
                                                            {/if}
                                                        {/foreach}
                                                    {else}
                                                        <em class="livemode" {if $details.manual=='1'}style="display:none"{/if}>None</em>
                                                    {/if}

                                                </td>
                                                {if $admindata.access.viewDomainsPrices}
                                                    <td >{$lang.firstpayment}</td>
                                                    <td ><input type="text" value="{$details.firstpayment}" name="firstpayment" size="10"/></td>
                                                {else}
                                                    <td ><input type="hidden" value="{$details.firstpayment}" name="firstpayment" size="10"/></td>
                                                {/if}
                                            </tr>

                                            <tr valign="top" >
                                                <td >{$lang.Status}</td>
                                                <td >
                                                    
                                                    <div class="{if ! isset($admindata.access.$provisionPrivilege)}isForbidAccess{/if}">
                                                        
                                                    <select name="status" {if $details.manual != '1'}style="display:none"{/if} class="manumode">
                                                        <option {if $details.status == 'Pending'}selected="selected" {/if} value="Pending">{$lang.Pending}</option>
                                                        <option {if $details.status == 'Pending Transfer'}selected="selected" {/if} value="Pending Transfer">{$lang.PendingTransfer}</option>
                                                        <option {if $details.status == 'Pending Registration'}selected="selected" {/if} value="Pending Registration">{$lang.PendingRegistration}</option>
                                                        <option {if $details.status == 'Active'}selected="selected" {/if} value="Active">{$lang.Active}</option>
                                                        <option {if $details.status == 'TransferredOut'}selected="selected" {/if} value="TransferredOut">{$lang.TransferredOut}</option>
                                                        <option {if $details.status == 'Cancelled'}selected="selected" {/if} value="Cancelled">{$lang.Cancelled}</option>
                                                        <option {if $details.status == 'Expired'}selected="selected" {/if} value="Expired">{$lang.Expired}</option>
                                                    </select>

                                                    <span class="{$details.status} livemode" {if $details.manual == '1'}style="display:none"{/if}><strong>{$lang[$details.status]}</strong></span>
                                                    
                                                    {if count($aInvoiceItem)}
                                                    <div>
                                                        Invoice# <a href="?cmd=invoices&action=edit&id={$aInvoiceItem.invoice_id}" target="_blank">{$aInvoiceItem.invoice_id}</a> มี invoice item ที่เกี่ยวกับโดเมนนี้ ยังไม่ได้บันทึกว่าจัดส่ง<br />
                                                        <label><input type="checkbox" name="is_shipped" value="{$aInvoiceItem.id}" class="manumode"> <span class="livemode">เลือกเพื่อบันทึกว่า</span>ได้จัดส่ง สินค้า/บริการ แล้ว</label>
                                                    </div>
                                                    {/if}
                                                    </div>
                                                    
                                                </td>
                                                {if $admindata.access.viewDomainsPrices}
                                                    <td >{$lang.recurring}</td>
                                                    <td ><input type="text" value="{$details.recurring_amount}" name="recurring_amount" size="10"/></td>
                                                {else}
                                                    <td ><input type="hidden" value="{$details.recurring_amount}" name="recurring_amount" size="10"/></td>
                                                {/if}
                                            </tr>

                                            <tr>
                                                <td class="auto-renew">
                                                    {$lang.AutoRenew}
                                                </td>
                                                <td class="auto-renew">
                                                    <div>
                                                        <label>
                                                            <input type="radio" name="autorenew" value="1"
                                                                   {if $details.autorenew == 1}checked{/if} hidden/>
                                                            <span class="label-livemode label label-success-invert"
                                                                  data-value="1">{$lang.yes}</span>
                                                        </label>
                                                        <label>
                                                            <input type="radio" name="autorenew" value="0"
                                                                   {if $details.autorenew == 0}checked{/if} hidden/>
                                                            <span class="label-livemode label label-default-invert"
                                                                  data-value="0">{$lang.no}</span>
                                                        </label>
                                                    </div>
                                                </td>
                                            </tr>


                                        </tbody>
                                    </table>
                                </div>
                                {include file="_common/quicklists.tpl" _placeholder=true}
                            </div>
                            {if $details.reg_module_diff}
                                <div class="alert alert-warning">
                                    Domain registration module is different that product registration module.
                                    Some functions may not be available for this domain in client area.
                                    Renewal options will be limited to current period
                                    ({$details.period} {$lang.yearslash})
                                </div>
                            {/if}

                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                
                                <tr>
                                    <td>
                                        {if isset($admindata.access.editAccounts)}
                                            {assign var=editable value='true'}
                                        {else}
                                            {assign var=editable value=''}
                                        {/if}
                                        {include file='_common/noteseditor.tpl' editable=$editable}
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td valign="top">
                                        <ul class="accor">
                                            <li><a href="#">{$lang.domainmanagement}</a>
                                                <div class="sor">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                        <tr>
                                                            <td width="50%">
                                                                <table cellspacing="2" cellpadding="3" border="0" width="100%">
                                                                    <tr><td width="150">{$lang.Domain}</td>
                                                                        <td><input type="text" size="30"  name="name" value="{$details.name}" id="domainname" {if $details.manual !='1'}readonly="readonly"{/if}/> 
                                                                            <a href="http://www.{$details.name}" target="_blank" style="color: rgb(204, 0, 0);" class="fs11">www</a>
                                                                            <a href="{$system_url}?cmd=checkdomain&action=whois&domain={$details.name}&security_token={$security_token}" onclick="window.open(this.href,'WHOIS','width=500, height=500, scrollbars=1'); return false"  class="fs11">whois</a>
                                                                            
                                                                        </td>
                                                                    </tr>
                                                                    <tr><td width="150">Product</td>
                                                                        <td>
                                                                            <select name="tld_id" style="width: 105px;"
                                                                                    onchange="$(this).next('a').attr('href','?cmd=services&action=product&id=' + $(this).val())">
                                                                            {foreach from=$categories item=category}
                                                                                <optgroup label="{$category.name}" >
                                                                                {foreach from=$category.products item=tld}
                                                                                    {if $details.tld_id}
                                                                                        <option {if $details.tld_id == $tld.id}selected="selected"{/if}
                                                                                                {if !in_array($tld.name, $details.tlds)}disabled="disabled"{/if}
                                                                                                     value="{$tld.id}">{$tld.name}</option>
                                                                                    {else}
                                                                                        <option {if !in_array($tld.name, $details.tlds)}disabled="disabled"{/if}
                                                                                                value="{$tld.id}">{$tld.name}</option>
                                                                                    {/if}
                                                                                {/foreach}
                                                                                </optgroup>
                                                                            {/foreach}
                                                                            </select>
                                                                            {if $details.tld_category}
                                                                                <a href="?cmd=services&action=product&id={$details.tld_id}" target="_blank" class="fs11">TLD settings</a>
                                                                            {/if}
                                                                        </td>
                                                                    </tr>
                                                                    {if $module_set}
                                                                        {foreach from=$details.nameservers item=nameserver key=number name=ns}
                                                                            {if $smarty.foreach.ns.index > 9}
                                                                                {break}
                                                                            {/if}
                                                                            <tr {if !$allowns}class="manumode"{/if} {if !$allowns && $details.manual!='1'}style="display:none"{/if} >
                                                                                <td >{$lang.Nameserver} {$number+1}</td><td ><input type="text" data-id="{$number+1}" size="40" value="{$nameserver}" name="nameservers[ns{$number+1}]"/>
                                                                                    {if $smarty.foreach.ns.last && ($number+1) != 10}<a class="add_ns" style="font-size: 11px;" href="#" onclick="add_ns(this); return false;">Add more</a>{/if}
                                                                                </td>
                                                                            </tr>
                                                                        {/foreach}
                                                                        {if $details.nsips && $details.nsips|is_array}
                                                                            {foreach from=$details.nsips item=nsip key=nnumber}
                                                                                <tr {if !$allowns}class="manumode"{/if} {if !$allowns && $details.manual!='1'}style="display:none"{/if} >
                                                                                    <td >{$lang.Nameserver} IP {$nnumber+1}</td><td ><input type="text" size="40" value="{$nsip}" name="nsips[nsip{$nnumber+1}]"/>
                                                                                    </td>
                                                                                </tr>
                                                                            {/foreach}
                                                                        {/if}
                                                                    {/if}

                                                                    <tr {if !$alloweppcode} id="epp_code"{if $details.manual!='1'} style="display:none"{/if}{/if}>
                                                                        <td>{$lang.Eppcode}</td>
                                                                        <td><input type="text" size="30" name="epp_code" value="{$details.epp_code|escape}" /></td>
                                                                    </tr>

                                                                    {if $registrarlock}
                                                                        <tr {if !$showregistrarlock}class="manumode"{/if} {if !$showregistrarlock && $details.manual!='1'}style="display:none"{/if}>
                                                                            <td >{$lang.RegistrarLock}</td>
                                                                            <td>
                                                                                <input type="checkbox" name="reglock" value="1" {if $details.reglock=='1'}checked="checked"{/if} />
                                                                            </td>
                                                                        </tr>
                                                                    {/if}

                                                                    {if $module_set}
                                                                        <tr>
                                                                            <td>{$lang.availablecommands}</td>
                                                                            <td class="dom_commands">
                                                                                
                                                                                <div class="{if ! isset($admindata.access.$provisionPrivilege)}isForbidAccess{/if}">
                                                                                
                                                                                <input type="submit" name="synch" value="{$lang.Synchronize}" class="{if !$allowsynch}manumode{/if} btn btn-primary btn-sm" {if !$isSyncableExpire && (!$allowsynch && $details.manual!='1')}style="display:none"{/if}/>
                                                                                {if $allowregister}
                                                                                    <input type="submit"  name="register"  value="{$lang.Register}" class="{if !$showregister}manumode{/if} btn btn-primary btn-sm" {if !$showregister && $details.manual!='1'}style="display:none"{/if} onclick="return confirm('ยืนยันคำสั่ง ?');"  />
                                                                                {/if}
                                                                                {if $allowrenew}
                                                                                    <input type="submit"  name="renew" {if $isShortTermRenew}disabled="disabled"{/if} value="{$lang.Renew}" class="{if !$showrenew}manumode{/if} btn btn-default btn-sm" {if !$isRenewableExpire || (!$showrenew && $details.manual!='1')}style="display:none"{/if} onclick="return confirm('ยืนยันคำสั่ง ?');"  />
                                                                                    {if $isShortTermRenew}<sup style="color:red; font-size:6px;">*(1)</sup>{/if}
                                                                                {/if}
                                                                                {if $allowtransfer}
                                                                                    <input type="submit"  name="transfer"  value="{$lang.Transfer}" class="{if !$showtransfer}manumode{/if} btn btn-primary btn-sm" {if !$showtransfer && $details.manual!='1'}style="display:none"{/if}/>
                                                                                {/if}
                                                                                {if $allowdelete}
                                                                                    <input type="submit"  name="delete"  value="{$lang.Delete}" class="{if !$showdelete}manumode{/if} btn btn-danger btn-sm" {if !$showdelete && $details.manual!='1'}style="display:none"{/if}
                                                                                           onclick="return confirm('{$lang.deletedomconfirm}');"/>
                                                                                {/if}
                                                                                {if $allowrenew}
                                                                                    <input type="submit"  name="orderrenew"  value="{$lang.orderrenew}" class="{if !$showrenew}manumode{/if} btn btn-default btn-sm" {if !$showrenew && $details.manual!='1'}style="display:none"{/if}
                                                                                           onclick="return confirm('{$lang.orderrenewdomconfirm}');"/>
                                                                                {/if}
                                                                                {if $details.status == 'Pending'}
                                                                                    <input type="submit"  name="preparecontacts"  value="Edit registration contacts" class="toLoad  btn btn-default btn-sm" />
                                                                                {/if}
                                                                                
                                                                                {if $details.status == 'Active'}
                                                                                    <br />
                                                                                    <input type="submit" name="synch"  value="Updatenameservers" class="manumode" />
                                                                                {/if}
                                                                                
                                                                                {if $custom}<br />{/if}
                                                                                {foreach from=$custom key=c_name item=btn}
                                                                                    <input type="submit" name="regcommand" value="{$c_name}" {if !$btn.toload}onclick="call_regcommand(this); return false;"{/if} class=" btn btn-default btn-sm {if $btn.toload}toLoad{/if} {if !$allowcustom}manumode{/if}" {if !$allowcustom && $details.manual!='1'}style="display:none"{/if}/>
                                                                                {/foreach}
                                                                                
                                                                                </div>
                                                                                
                                                                            </td>
                                                                        </tr>
                                                                    {/if}
                                                                <tr>
                                                                    <td>{$lang.senddomainemail}</td>
                                                                    <td><select name="mail_id" id="mail_id">
                                                                            {foreach from=$domain_emails item=send_email}
                                                                                <option value="{$send_email.id}">{$send_email.tplname}</option>
                                                                            {/foreach}
                                                                            <option value="custom" style="font-weight:bold">{$lang.newmess}</option>
                                                                        </select>
                                                                        <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail" class=" btn btn-default btn-sm"/>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                            {if $details.custom}
                                                                <input type="hidden" name="arecustom" value="1"/>
                                                                <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                                                                    {foreach from=$details.custom item=c key=kk}
                                                                        {if $c.items}
                                                                            <tr>
                                                                                <td style="vertical-align: top" width="150" >{$c.name} </td>
                                                                                <td>
                                                                                    
                                                                                    <div class="{if ! isset($admindata.access.$provisionPrivilege)}isForbidAccess{/if}">
                                                                                    
                                                                                    {if $c.type=='select'}
                                                                                        <select name="custom[{$kk}]">
                                                                                            <option value="0" {if $c.value=='0'}selected="selected"{/if}>-</option>
                                                                                            {foreach from=$c.items item=itm}
                                                                                                <option value="{$itm.id}" {if $c.values[$itm.id]}selected="selected"{/if}>{$itm.name} {if $itm.price}({$itm.price|price:$currency}){/if}</option>
                                                                                            {/foreach}
                                                                                        </select>


                                                                                    {elseif $c.type=='qty'}
                                                                                        {foreach from=$c.items item=cit}
                                                                                            <input name="custom[{$kk}][{$cit.id}]"  size="2" value="{$c.qty}"/> {if $cit.name}x {$cit.name}{/if}  
                                                                                            {if $cit.price}({$cit.price|price:$currency})
                                                                                            {/if}
                                                                                        {/foreach}
                                                                                        
                                                                                    {elseif $c.variable=='reg_username'}
                                                                                        {foreach from=$c.items item=cit}
                                                                                          <input name="custom[{$kk}][{$cit.id}]"  value="{if $c.data[$cit.id]}{$c.data[$cit.id]|htmlspecialchars}{else}{$regUsername}{/if}"/> {$cit.name}  
                                                                                        {/foreach}
                                                                                    {elseif $c.variable=='reg_password'}
                                                                                        {foreach from=$c.items item=cit}
                                                                                          <input name="custom[{$kk}][{$cit.id}]"  value="{if $c.data[$cit.id]}{$c.data[$cit.id]|htmlspecialchars}{else}{$regPassword}{/if}"/> {$cit.name}  
                                                                                        {/foreach}
                                                                                        
                                                                                    {else}
                                                                                        {include file=$c.configtemplates.accounts}
                                                                                    {/if}
                                                                                    
                                                                                    </div>
                                                                                    
                                                                                </td>
                                                                            </tr>
                                                                        {/if}
                                                                    {/foreach}
                                                                </table>
                                                            {/if}
                                                        </td>
                                                        <td width="50%" style="padding-left:10px" valign="top">

                                                            {if $details.status!='Cancelled'}


                                                                <div id="autoqueue" >
                                                                    <i class="fa fa-circle-o-notch fa-spin  fa-fw"></i>
                                                                    <span class="sr-only">Loading...</span>
                                                                    Loading automation queue
                                                                        {literal}<script type="text/javascript">
                                                                    appendLoader('getAccQueue');

                                                                    function getAccQueue() {
                                                                    ajax_update("?cmd=domains&action=getqueue&id={/literal}{$details.id}&product_id={$details.tld_id}{literal}",false,'#autoqueue');
                                                                        }

                                                                    </script>{/literal}

                                                                </div>


                                                            {/if}


                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <ul class="accor" id="dommanager" style="display:none;margin-bottom:5px;">
                                        <li><a href="#" id="man_title"></a>
                                            <div class="sor" id="man_content"></div>
                                        </li>
                                    </ul>
                                    {literal}
                                        <script type="text/javascript">
                                            function add_ns(elem) {
                                                var limit = 10,
                                                    tr = $(elem).parents('tr').first(),
                                                    button = $('.add_ns'),
                                                    id = tr.children().last().children().first().data('id'),
                                                    clone = tr.clone(),
                                                    new_id = id + 1,
                                                    ip = $('input[name="nsips[nsip' + id + ']"]').parents('tr').first(),
                                                    new_ip = $('input[name="nsips[nsip' + new_id + ']"]').parents('tr').first();
                                        
                                                if (id < limit) {
                                                    clone = prepare_ns(clone, id);
                                                    if (new_id === limit)
                                                        clone.children().last().children().last().remove();
                                                    tr.after(clone);
                                                    button.remove();
                                                    if (ip.length > 0 && new_ip.length <= 0) {
                                                        var cloneip = ip.clone();
                                                        cloneip = prepare_ns(cloneip, id);
                                                        ip.after(cloneip);
                                                    }
                                                }
                                            }
                                            function prepare_ns(clone, id) {
                                                var input = clone.children().last().children().first(),
                                                    text = clone.children().first().html(),
                                                    new_id = id + 1,
                                                    name = input.prop('name');
                                                input.data('id', new_id);
                                                input.prop('name', name.replace(id, new_id));
                                                input.prop('value', '');
                                                text = text.replace(id, new_id);
                                                clone.children().first().html(text);

                                                return clone;
                                            }
                                function new_gateway(elem) {
                                    if($(elem).val() == 'new') {
                                        window.location = "?cmd=managemodules&action=payment";
                                        $(elem).val(($("select[name='"+$(elem).attr('name')+"'] option:first").val()));
                                    }
                                }function new_registrar(elem) {
                                    if($(elem).val() == 'new') {
                                        window.location = "?cmd=managemodules&action=domain";
                                        $(elem).val(($("select[name='"+$(elem).attr('name')+"'] option:first").val()));
                                    }
                                }
                                function ext_submit(el) {
                                    ajax_update('?cmd=domains&action=callcustom&id='+$('#domain_id').val()+'&command='+$(el).attr('name'), $('#dom_forms').serialize(),'#man_content',true);
                                    return false;
                                }
                                function call_regcommand(el) {
                                                window.location = '?cmd=domains&action=callcustom&regcommand=true{/literal}&security_token={$security_token}{literal}&refresh=true&id='+$('#domain_id').val()+'&command='+$(el).attr('value');

                                }

                                        </script>
                                    {/literal}
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    {include file='_common/noteseditor.tpl'}
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="blu">
                        <table border="0" cellpadding="2" cellspacing="0" >
                            <tr>
                                <td class="menubar"><a href="?cmd=domains&list={$currentlist}"><strong>&laquo; {$lang.backto} {$currentlist} {$lang.domains}</strong></a>&nbsp;
                                    {if isset($admindata.access.editAccounts)}
                                    <a class="menuitm" href="#" onclick="$('#formsubmiter').click();return false" ><span ><strong>{$lang.savechanges}</strong></span></a>
                                    {/if}
                                    {if isset($admindata.access.editAccounts)}
                                    <a class=" menuitm menu-auto" href="#" onclick="return confirm_delete()"><span style="color:#FF0000">{$lang.Delete} </span></a>
                                    {/if}
                                    <a class="setStatus menuitm menu-auto" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                                    {adminwidget module="domains" section="domainheader"}
                                </td>
                                <td></td>
                            </tr>
                        </table>

                        <ul id="hd1_m" class="ddmenu">
                            <li  class="{if ! isset($admindata.access.editAccounts)}disabled{/if}" ><a href="AdminNotes">{$lang.editadminnotes}</a></li>
                            <li ><a href="SendEmail">{$lang.senddomainemail}</a></li>

                        </ul>
                    </div>
                    {securitytoken}
                </form>
                {literal}
                    <script type="text/javascript">
                    
                    function confirm1() {

                        var c = confirm('{/literal}{$lang.confdomdel}{literal}');
                        if(c) {
                            window.location='?cmd=domains&action=edit&make=delete{/literal}&security_token={$security_token}{literal}&id='+$('#domain_id').val();
                        }
                        return false;

                    }
                    
                    </script>
                {/literal}
            {elseif $action=='sync'}
                {include file='domainsync.tpl'}
            {else}
                <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                    <div class="blu">
                        <div class="right"><div class="pagination"></div></div>
                        <div class="left menubar">
                            {$lang.withselected}
                            {if isset($admindata.access.editAccounts)}
                            <a class="menuitm menu-auto submiter renew confirm" name="renew" onclick="return false" href="#" {if $enablequeue}queue='push'{/if}><span>{$lang.Renew}</span></a>
                            <a class="menuitm menu-auto" onclick="$('#syncsubmit').click();return false" href="#"><span>{$lang.Synchronize}</span></a>
                            <a class="menuitm menu-auto" onclick="return confirm_delete_selected()" href="#"><span style="color:#FF0000">{$lang.Delete}</span></a>
                            {/if}
                            <a class="setStatus menuitm menu-auto" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>

                            <ul id="hd1_m" class="ddmenu">
                                <li ><a href="#">Send expiration notice</a></li>
                                <li ><a href="#" onclick="return send_msg('domains')">{$lang.SendMessage}</a></li>

                            </ul>
                            <input type="submit" name="sendmail" value="{$lang.SendMessage}" onclick="return send_msg('domains')" style="display:none"/>
                            <input type="submit" name="sync" value="1"  style="display:none" id="syncsubmit" />
                        </div>
                        <div class="clear"></div>
                    </div>

                    <a href="?cmd=domains&list={$currentlist}" id="currentlist" style="display:none"  updater="#updater"></a>
                    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                        <tbody>
                            <tr>
                                <th width="20"><input type="checkbox" id="checkall"/></th>
                                <th width="35" class="text-nowrap"><a href="?cmd=domains&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.idhash}</a></th>
                                <th><a href="?cmd=domains&list={$currentlist}&orderby=name|ASC"  class="sortorder">{$lang.Domain}</a></th>
                                <th><a href="?cmd=domains&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                                <th  width="110"><a href="?cmd=domains&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.Registrar}</a></th>
                                <th width="70"><a href="?cmd=domains&list={$currentlist}&orderby=period|ASC"  class="sortorder">{$lang.Period}</a></th>
                                <th width="90"><a href="?cmd=domains&list={$currentlist}&orderby=date_created|ASC"  class="sortorder">{$lang.estimate_date}</a></th>
                                <th width="90"><a href="?cmd=domains&list={$currentlist}&orderby=expires|ASC"  class="sortorder">{$lang.Expires}</a></th>
                                <th width="90"><a href="?cmd=domains&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                                <th width="100">{$lang.options}</th>
                                <th width="20">&nbsp;</th>
                            </tr>
                        </tbody>
                        <tbody id="updater">

                            {include file='ajax.domains.tpl'}
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

                    <div class="blu">
                        <div class="right"><div class="pagination"></div></div>
                        <div class="left menubar">
                            {$lang.withselected}   
                            {if isset($admindata.access.editAccounts)}
                            <a class="menuitm menu-auto submiter renew confirm" name="renew" onclick="return false" href="#" {if $enablequeue}queue='push'{/if}><span>{$lang.Renew}</span></a>
                            <a class="menuitm menu-auto" onclick="$('#syncsubmit').click();return false" href="#"><span>{$lang.Synchronize}</span></a>
                            <a class="menuitm menu-auto" onclick="return confirm_delete_selected()" href="#"><span style="color:#FF0000">{$lang.Delete}</span></a>
                            {/if}
                            <a class="setStatus menuitm menu-auto" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>

                        </div>
                        <div class="clear"></div>
                    </div>
                    {securitytoken}</form>
                {/if}
                {if ($action=='edit' || !$action || $action=='default') && !$ajax}
                    {literal}
                        <script type="text/javascript">
                            var _delete_multi = false;
                            function confirm_delete_selected() {
                                if ($("#testform input[class=check]:checked").length < 1) {
                                    alert('Nothing checked');
                                }else{
                                    confirm_delete();
                                    _delete_multi = true;
                                }
                                return true;
                            }
                            function confirm_delete() {
                                _delete_multi = false;
                                $('#confirm_ord_delete').trigger('show');
                            }
                            function confirm_delete2() {
                                var add = '';
                                if ($('.bootbox-body input.cc_hard').is(':checked'))
                                    add = '&harddelete=true';
                                if(_delete_multi){
                                    ajax_update('?cmd=domains&delete=1&' + $.param($("#testform input[class=check]:checked")) + add, {stack: 'push'});
                                }else{
                                    window.location.href = '?cmd=domains&action=edit&make=delete&id='+$('#domain_id').val()+add+'&security_token='+$('input[name=security_token]').val();
                                }

                                bootbox.hideAll()
                                return false;
                            }


                        </script>
                    {/literal}

                    <div id="confirm_ord_delete" hidden bootbox data-title="{$lang.deletedomain}" data-btnclass="btn-danger" data-callback="confirm_delete2">
                        <form action="?cmd=domains&action=edit&make=delete" method="post">
                            <p><strong>{$lang.deletedomattempt}</strong></p>

                            <input type="radio" checked="checked" name="harddelete" value="true" class="cc_hard"/> <span> {$lang.deletedomhard}</span><br />
                            <input type="radio"  name="harddelete" value="false" /> <span> {$lang.deletedomsoft}</span><br />
                            <input type="hidden" name="id" value="{$details.id}" />
                            {securitytoken}

                        </form>
                    </div>


                {/if}
        </div>
    </td>
</tr>
</table>