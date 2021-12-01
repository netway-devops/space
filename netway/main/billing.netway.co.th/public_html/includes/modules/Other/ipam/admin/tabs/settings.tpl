<form action="?cmd=module&module={$moduleid}&setting=save" method="post" id="optform">
    <div style="padding:10px 1em">
        <div style="margin-bottom: 0px; font-weight: bold">
            <input name="emails" type="checkbox" value="1" {if $settings.email}checked="checked"{/if} />
            Send emails on IP list updates.
        </div>
        <div style="padding:10px 1em">
            For following admins:
            {if $adminlist}<br />
                {foreach from=$adminlist item=admin}
                    <input name="admins[{$admin.id}]" {if $admin.id|in_array:$settings.admins}checked="checked"{/if}type="checkbox" value="{$admin.id}" /> {$admin.username}
                {/foreach}
            {/if}
        </div>

        <div style="margin-bottom: 10px; font-weight: bold">
            <input name="autoterminate" type="checkbox" value="1" {if $settings.autoterminate}checked="checked"{/if} />
            Auto-unassign IPs from accounts on terminate
        </div>

        <div style="margin: 10px 0 ; font-weight: bold">
            <input name="reservation" type="checkbox" value="1" {if $settings.reservation}checked="checked"{/if} />
            Reservation rules
            <a href="#" class="vtip_description" title="When assigning whole IP list this option will automatically reserve IPs based on rules below. You can use 'n' and 'm' variables to define list starting & end points, example: <br/>&nbsp;&bull;&nbsp;&nbsp;'n+1' will reserve second ip<br/>&nbsp;&bull;&nbsp;&nbsp;'m' will reserve last ip" ></a>
        </div>

        {foreach from=$settings.reservations item=reserve key=kk}
            <p>
                IP number: <input name="reservations[{$kk}][ip]" type="text" class="inp" value="{$reserve.ip}" />
                Reserved for <input name="reservations[{$kk}][descr]" type="text" class="inp" value="{$reserve.descr}" />
                <a href="#delRule" class="editbtn fs11" onclick="delReservationRule(this); return false" >remove</a>
            </p>
        {/foreach}
        <a href="#addRule" class="editbtn" onclick="addReservationRule(this); return false" />Add new rule</a>
    </div>
    <div style="padding:10px 10px">
        <a class="new_dsave new_menu" href="#" onclick="$('#optform').submit();
                    return false;">
            <span>{$lang.savechanges}</span>
        </a>
        <div class="clear"></div>
    </div>
</form>