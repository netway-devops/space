{assign var="descr" value="_hosting"}
 {assign var="baz" value="$plist$descr"}

 <form action="" method="post" id="account_form" >

     <input type="hidden" name="account_id" value="{$details.id}" id="account_id" />
     <div class="blu">
         <table border="0" cellpadding="2" cellspacing="0" >
             <tr>
                 <td class="menubar"><a href="?cmd=accounts&list={$currentlist}"><strong>&laquo; {$lang.backto} {$lang.accounts}</strong></a>&nbsp;
                     <input type="submit" name="save" value="{$lang.savechanges}" style="font-weight:bold;display:none"  id="formsubmiter"/>
                     <a   class="menuitm"   href="#" onclick="$('#formsubmiter').click();return false" ><span ><strong>{$lang.savechanges}</strong></span></a>
                     <a   class=" menuitm menuf"    href="#" onclick="confirm1();return false;"><span style="color:#FF0000">{$lang.Delete}</span></a><a   class="setStatus menuitm menul" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                    <td><input type="checkbox" name="manual" value="1" {if $details.manual == '1'}checked="checked" {/if}  id="changeMode" style="display:none"/></td>
             </tr>
         </table>
         <ul id="hd1_m" class="ddmenu">
             <li ><a href="AdminNotes">{$lang.editadminnotes}</a></li>
             <li ><a href="ChangeOwner">{$lang.changeowner}</a></li></ul>
     </div>

     <div class="lighterblue" id="ChangeOwner" style="display:none;padding:5px;">
     </div>



     <div id="ticketbody">
         <h1>{$lang.accounthash}{$details.id}</h1>

        {include file='_common/accounts_cancelrequest.tpl'}


         <div id="client_nav">
             <!--navigation-->
             <a class="nav_el nav_sel left" href="#">{$lang.accountbdetails}</a>
             <a class="nav_el  left" href="?cmd=accounts&action=log&id={$details.id}" onclick="return false">{$lang.accountlog}</a>
             <div class="left">
                 <span class="left" style="padding-top:5px;padding-left:5px;"><strong>{$details.firstname} {$details.lastname}'s:</strong>&nbsp;&nbsp;</span>

                 {if $enableFeatures.profiles=='on'}<a class="nav_el  left"  href="?cmd=clients&action=clientcontacts&id={$details.client_id}" onclick="return false" >{$lang.Contacts}</a> {/if}
                 <a class="nav_el  left"  href="?cmd=orders&action=clientorders&id={$details.client_id}" onclick="return false">{$lang.Orders}</a>
                 <a class="nav_el  left"  href="?cmd=accounts&action=clientaccounts&id={$details.client_id}" onclick="return false">{$lang.Services}</a>
                 <a class="nav_el  left" href="?cmd=domains&action=clientdomains&id={$details.client_id}" onclick="return false">{$lang.Domains}</a>
                 <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$details.client_id}" onclick="return false">{$lang.Invoices}</a>
                 <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={$details.client_id}&currentlist=recurring" onclick="return false">{$lang.Recurringinvoices}</a>

		  {if $enableFeatures.estimates=='on'}<a class="nav_el  left" href="?cmd=estimates&action=clientestimates&id={$details.client_id}" onclick="return false">{$lang.Estimates}</a>{/if}

                 <a class="nav_el  left" href="?cmd=transactions&action=clienttransactions&id={$details.client_id}" onclick="return false">{$lang.Transactions}</a>
                 <a class="nav_el  left" href="?cmd=tickets&action=clienttickets&id={$details.client_id}" onclick="return false">{$lang.Tickets}</a>
                 <a class="nav_el  left" href="?cmd=emails&action=clientemails&id={$details.client_id}" onclick="return false">{$lang.Emails}</a>
                 <a class="nav_el direct left" href="?cmd=clients&action=show&id={$details.client_id}">{$lang.Profile}</a>

             </div>


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

                                 </select></td>
                         </tr>
                         <tr>
                             <td >{$lang.Client}</td>
                             <td ><a href="?cmd=clients&action=show&id={$details.client_id}">{$details.firstname} {$details.lastname}</a> </td>
                             <td >{$lang.Period}</td>
                             <td ><select name="billingcycle">
                                     <option value="Free" {if $details.billingcycle=='Free'}selected='selected'{/if}>{$lang.Free}</option>
                                     <option value="One Time" {if $details.billingcycle=='One Time'}selected='selected'{/if}>{$lang.OneTime}</option>
                                     <option value="Annually" {if $details.billingcycle=='Annually'}selected='selected'{/if}>1 {$lang.Year} </option>
                                     <option value="Biennially" {if $details.billingcycle=='Biennially'}selected='selected'{/if}>2 {$lang.Years} </option>
                                     <option value="Triennially" {if $details.billingcycle=='Triennially'}selected='selected'{/if}>3 {$lang.Years} </option>
									 <option value="Quadrennially" {if $details.billingcycle=='Quadrennially'}selected='selected'{/if}>4 {$lang.Years} </option>
									 <option value="Quinquennially" {if $details.billingcycle=='Quinquennially'}selected='selected'{/if}>5 {$lang.Years} </option>
                                 </select></td>
                         </tr>
                         <tr>
                             <td >{$lang.regdate}</td>
                             <td ><input type="text" class="haspicker" value="{$details.date_created|dateformat:$date_format}" name="date_created" size="12" /></td>
                             <td >{$lang.next_due}</td>
                             <td ><input type="text" class="haspicker" value="{$details.next_due|dateformat:$date_format}" name="next_due" size="12" /> <a class="editbtn" href="?cmd=invoices&filter[item_id]={$details.id}&filter[type]=Hosting" >{$lang.findrelatedinv}</a></td>
                         </tr>
                         <tr>
                             <td >{$lang.Addons}</td>
                             <td ><span id="numaddons">{$details.addons}</span> {$lang.addons_plu}</td>
                             <td >{$lang.firstpayment}</td>
                             <td ><input type="text" value="{$details.firstpayment}" name="firstpayment" size="10"/></td>
                         </tr>

                         <tr>
                             <td >{$lang.Status}</td>
                             <td >
                                 <select name="status" {if $details.manual != '1'}style="display:none"{/if} class="manumode">
                                         <option {if $details.status == 'Pending'}selected="selected" {/if} value="Pending">{$lang.Pending}</option>
                                     <option {if $details.status == 'Active'}selected="selected" {/if} value="Active">{$lang.Active}</option>
                                     <option {if $details.status == 'Suspended'}selected="selected" {/if}  value="Suspended">{$lang.Suspended}</option>
                                     <option {if $details.status == 'Terminated'}selected="selected" {/if}  value="Terminated">{$lang.Terminated}</option>
                                     <option {if $details.status == 'Cancelled'}selected="selected" {/if}  value="Cancelled">{$lang.Cancelled}</option>
                                     <option {if $details.status == 'Fraud'}selected="selected" {/if}  value="Fraud">{$lang.Fraud}</option>
                                 </select>

                                 <span class="{$details.status} livemode" {if $details.manual == '1'}style="display:none"{/if}><strong>{$lang[$details.status]}</strong></span>
                             </td>
                             <td >{$lang.recurring}</td>
                             <td ><input type="text" value="{$details.total}" name="total" size="10"/></td>
                         </tr>

                     </tbody>
                 </table>
             </div>
             {if $enableFeatures.profiles=='on'}<div class="slide">Loading</div>{/if}
             <div class="slide">Loading</div>
             <div class="slide">Loading</div>
             <div class="slide">Loading</div>
		  {if $enableFeatures.estimates=='on'}<div class="slide">Loading</div>{/if}
             <div class="slide">Loading</div>  <div class="slide">Loading</div><div class="slide">Loading</div>
             <div class="slide">Loading</div> <div class="slide">Loading</div><div class="slide">Loading</div>
         </div>




         <table border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td width="100%" valign="top">
                     <ul class="accor">
                         <li><a href="#">{$lang.accountdetails}</a>
                             <div class="sor">

                                  {include file='_common/accounts_details.tpl'}
                             </div>
                         </li>
                     </ul>
                     <ul class="accor" id="dommanager" style="display:none;margin-bottom:5px;">
                         <li><a href="#" id="man_title"></a>
                             <div class="sor" id="man_content"></div>
                         </li>
                     </ul>


                 </td></tr>
             <tr>


                 <td  valign="top" width="100%">

                    {if $custom_template}
                            {include file=$custom_template}
                    {/if}
                    <ul class="accor">
                        <li><a href="#">{$lang.accaddons}</a>
                            {include file='_common/accounts_addons.tpl'}
                        </li>
                    </ul>
                    <br />
                    {include file='_common/accounts_multimodules.tpl'}
                    {include file='_common/noteseditor.tpl'}
                 </td>
             </tr>
         </table>
     </div>
     <div class="blu">{include file='_common/accounts_nav.tpl'}</div>
     {securitytoken}
</form>
