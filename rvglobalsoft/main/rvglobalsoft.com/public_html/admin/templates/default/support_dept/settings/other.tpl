<tr class="bordme">
    <td align="right" width="160"><strong>{$lang.tdinca}</strong></td>
    <td>
        <input type="radio" name="visible" value="1"
               {if $submit.visible=='1' || !$submit}checked="checked"{/if}/>
        <strong>{$lang.Yes}</strong>, {$lang.yesshowinca}<br/>
        <input type="radio" name="visible" value="0"
               {if $submit.visible=='0'}checked="checked"{/if}/> {$lang.noshowinca}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.ticketnotifies}</strong></td>
    <td>
        <input type="radio" name="ticketnotifies" value="3"
               {if $submit.ticketnotifies=='3'}checked="checked"{/if}/>
        <strong>High</strong>, Send notification to client, subscribed staff and all staff members
        in this
        department.
        <br/>
        <input type="radio" name="ticketnotifies" value="1"
               {if $submit.ticketnotifies=='1' || !$submit}checked="checked"{/if}/>
        <strong>Medium</strong>, Send notification to client and entitled staff members
        <a href="#" class="vtip_description"
           title="Notifications for assigned tickets will be sent only to assigned & subscribed support staff, notifications for unassigned tickets will be sent to all staff members"></a>
        <br/>
        <input type="radio" name="ticketnotifies" value="2"
               {if $submit.ticketnotifies=='2'}checked="checked"{/if}/>
        <strong>Low</strong>, Send notification to client and only to staff member subscribed to
        related
        ticket
        <a href="#" class="vtip_description"
           title="Emails to staff members won't be sent if ticket is not assigned"></a>
        <br/>
        <input type="radio" name="ticketnotifies" value="0"
               {if $submit.ticketnotifies=='0'}checked="checked"{/if}/>
        <strong>Off</strong>, {$lang.nosendnotifyaboutticket}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>Auto-subscribe</strong></td>
    <td>
        <input type="radio" name="autosubscribe" value="1"
               {if $submit.autosubscribe=='1' && $submit.autosubscribeempty!='1'}checked="checked"{/if}/>
        <strong>{$lang.Yes}</strong>, Subscribe staff members after they respond to a ticket<br/>
        <input type="radio" name="autosubscribe" value="2"
               {if $submit.autosubscribe=='1' && $submit.autosubscribeempty=='1'}checked="checked"{/if}/>
        <strong>{$lang.Yes}</strong>, Subscribe after response but only if no one is already
        subscribed<br/>
        <input type="radio" name="autosubscribe" value="0"
               {if $submit.autosubscribe=='0' || !$submit.autosubscribe || !$submit }checked="checked"{/if}/>
        <strong>{$lang.No}</strong>, Do not subscribe after response
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.allowedsub}</strong></td>
    <td>
        <input type="radio" name="allowedsub" value="0"
               {if $submit.allowedsub=='0' || !$submit}checked="checked"{/if}/> {$lang.allowedsuball}
        <br/>
        <input type="radio" name="allowedsub" value="1"
               {if $submit.allowedsub=='1'}checked="checked"{/if}/> {$lang.deptonlyforregistered}
        <br/>
        <input type="radio" name="allowedsub" value="2"
               {if $submit.allowedsub=='2'}checked="checked"{/if}/>
        Only staff members can open new trouble tickets in this department
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.ticketreopen}</strong></td>
    <td>
        <input type="radio" name="clientreopen" value="1"
               {if $submit.clientreopen=='1' || !$submit}checked="checked"{/if}/>{$lang.ticketreopenyes}
        <br/>
        <input type="radio" name="clientreopen" value="0"
               {if $submit.clientreopen=='0' }checked="checked"{/if}/>{$lang.ticketreopenno}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.staffticketclose}</strong></td>
    <td>
        <input type="radio" name="clientclosestaff" value="0"
               {if $submit.clientclosestaff=='0'|| !$submit}checked="checked"{/if}/>{$lang.staffticketcloseyes}
        <br/>
        <input type="radio" name="clientclosestaff" value="1"
               {if $submit.clientclosestaff=='1'}checked="checked"{/if}/>{$lang.staffticketcloseno}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.allowedadminsub}</strong></td>
    <td>
        <input type="radio" name="adminreply" value="1"
               {if $submit.adminreply=='1' }checked="checked"{/if}/>
        <strong>{$lang.Yes}</strong>, {$lang.allowedadminsub1}<br/>
        <input type="radio" name="adminreply" value="0"
               {if $submit.adminreply=='0' || !$submit}checked="checked"{/if}/>
        <strong>{$lang.No}</strong>, {$lang.allowedadminsub2}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.clientsetpriority}</strong></td>
    <td>
        <input type="radio" name="clientsetpriority" value="1"
               {if $submit.clientsetpriority=='1' }checked="checked"{/if}/> {$lang.yesclientsetpriority}
        <br/>
        <input type="radio" name="clientsetpriority" value="0"
               {if $submit.clientsetpriority=='0' || !$submit}checked="checked"{/if}/> {$lang.noclientsetpriority}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.ratesupport}</strong></td>
    <td>
        <input type="radio" name="supportrating" value="1"
               {if $submit.supportrating=='1' }checked="checked"{/if}/><strong>{$lang.Yes}</strong>, {$lang.supportrating_yes}
        <br/>
        <input type="radio" name="supportrating" value="0"
               {if $submit.supportrating=='0' || !$submit}checked="checked"{/if}/><strong>{$lang.No}</strong>, {$lang.supportrating_no}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.avgresptime}</strong></td>
    <td>
        <input type="radio" name="avgresptime" value="1"
               {if $submit.avgresptime=='1' }checked="checked"{/if}/><strong>{$lang.Yes}</strong>, {$lang.avgresptime_yes}
        <br/>
        <input type="radio" name="avgresptime" value="0"
               {if $submit.avgresptime=='0' || !$submit.avgresptime}checked="checked"{/if}/><strong>{$lang.No}</strong>, {$lang.avgresptime_no}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.overall_ticket_rating}</strong></td>
    <td>
        <input type="radio" name="ticketrating" value="1"
               {if $submit.ticketrating=='1' }checked="checked"{/if}/><strong>{$lang.Yes}</strong>, {$lang.overall_ticket_rating_yes}
        <br/>
        <input type="radio" name="ticketrating" value="0"
               {if $submit.ticketrating=='0' || !$submit.ticketrating}checked="checked"{/if}/><strong>{$lang.No}</strong>, {$lang.overall_ticket_rating_no}
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.EnableSuperVisorReviews}</strong></td>
    <td>
        <input type="radio" name="reviewticket" value="1" {if $submit.reviewticket=='1' }checked="checked"{/if}/><strong>{$lang.Yes}</strong>
        <br/>
        <input type="radio" name="reviewticket" value="0" {if $submit.reviewticket=='0' || !$submit.reviewticket}checked="checked"{/if}/><strong>{$lang.No}</strong>
    </td>
</tr>
<tr class="bordme">
    <td align="right"><strong>{$lang.TicketAutoClose}</strong></td>
    <td>
        <input type="checkbox" value="1" {if $submit.autoclose > 0}checked="checked"{/if} onclick="if (this.checked)
                                                $(this).next('input').removeAttr('disabled');
                                            else
                                                $(this).next('input').attr('disabled', true);"/>
        {$lang.after}
        <input type="text" size="3" class="config_val inp" {if $submit.autoclose <= 0}value="0"
               disabled="disabled" {else}value="{$submit.autoclose}"{/if}
               name="ticketautoclose"/> {$lang.hours}
    </td>
</tr>
<tr>
    <td align="right"><strong>{$lang.newticketemail}</strong></td>
    <td>
        <select class="inp" name="newticketemail"/>
        <option value="0" {if $submit.id && !$submit.newticketemail} selected="selected"{/if}>None,
            do not
            send initial notification
        </option>
        {foreach from=$templates item=temp}
            <option {if (!$submit.id && !$submit.newticketemail && $temp.tplname == 'Ticket:New') || $submit.newticketemail == $temp.id}selected="selected"{/if}
                    value="{$temp.id}">{$temp.tplname}</option>
        {/foreach}
        </select>
    </td>
</tr>