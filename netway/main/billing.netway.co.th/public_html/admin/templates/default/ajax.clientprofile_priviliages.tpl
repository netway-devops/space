<input type="hidden" name="current_page" value="{$current_page}">
<div id="privileges" >
    <div style="padding:5px 20px 0">
        {foreach from=$privilages item=privs key=group}
            {foreach from=$privs item=privopt}
                {if !$privopt.displaygroup || $privoptdisplaygroup==group || $group=='disabled_support_departments'}
                    {assign value=1 var=displaythis}
                {/if}
            {/foreach}
            {if $displaythis!=1}{continue}{/if}
            <h3 class="{$privs._type}_h3 {if $privs._type}privs_items{/if}">
                <input type="checkbox" class="privilege " id="{$group}_main" onclick="cUnc(this, '{$group}')"/>
                {if $group == 'disabled_support_departments'}
                    <label for="{$group}_main">{$lang.disable_access_to_departments}</label>
                {elseif $privs._type}
                    {if $privs._type == 'services'}
                        {foreach from=$services item=service}
                            {if $privs._id == $service.id}
                                <label for="{$group}_main">#{$service.id} {$service.catname} - {$service.name} {if $service.domain}({$service.domain}){/if}</label>
                            {/if}
                        {/foreach}
                    {elseif $privs._type == 'domains'}
                        {foreach from=$domains item=domain}
                            {if $privs._id == $domain.id}
                                <label for="{$group}_main">{$lang.domain|ucfirst} - {$domain.name}</label>
                            {/if}
                        {/foreach}
                    {elseif $privs._type == 'disabled_support_departments'}
                        {foreach from=$support_departments item=dept}
                            {if $privs._id == $dept.id}
                                <label for="{$group}_main">{$dept.name}</label>
                            {/if}
                        {/foreach}
                    {/if}
                {else}
                    <label for="{$group}_main"> {assign value="`$group`_main" var=groupmain}{$lang[$groupmain]}</label>
                {/if}
            </h3>
            <div class="{$privs._type}_div pgroup mb20 {if $privs._type}privs_items{/if}">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    {counter name=trp print=false start=0 assign=trp}
                    {foreach from=$privs item=privoptt key=priv name=loop}
                        {if $priv === '_id' || $priv === '_type'}
                            {continue}
                        {/if}
                        {if $group!='disabled_support_departments' && $privoptt.condition && !$privoptt.condition|checkcondition}{continue}{/if}
                        {if $trp != 0 && $trp % 3 == 0}</tr>{/if}
                        {if $trp % 3 == 0}<tr>{/if}
                        <td width="33%">
                            {if $privs._type}
                                <input type='hidden' value='0' name="privileges[{$privs._type}][{$privs._id}][{$priv}]">
                                <input type="checkbox" class="privilege {$group} {$privs._type}" id="{$group}_{$priv}" value="1"
                                       name="privileges[{$privs._type}][{$privs._id}][{$priv}]"
                                       {if $submit.privileges[$privs._type][$privs._id].$priv}checked="checked"{/if} />
                                <label for="{$group}_{$priv}" {if $privoptt.important}style="color:red"{/if}>
                                    {assign value="`$privs._type`_`$priv`" var=grouppriv}{if $lang[$grouppriv]}{$lang[$grouppriv]}{else}{$grouppriv}{/if}
                                </label>
                            {elseif $group=='disabled_support_departments'}
                                {foreach from=$support_departments item=dept}
                                    {if $dept.id == $privoptt}
                                        <input type='hidden' value='0' name="privileges[{$group}][{$dept.id}]">
                                        <input type="checkbox" class="privilege {$group}" id="{$group}_{$dept.id}" value="1" name="privileges[{$group}][{$dept.id}]" {if $submit.privileges[$group][$dept.id] == 1}checked="checked"{/if} />
                                        <label for="{$group}_{$dept.id}">
                                            {$dept.name}
                                        </label>
                                    {/if}
                                {/foreach}
                            {else}
                                <input type='hidden' value='0' name="privileges[{$group}][{$priv}]">
                                <input type="checkbox" class="privilege {$group}" id="{$group}_{$priv}" value="1" name="privileges[{$group}][{$priv}]" {if $submit.privileges.$group.$priv}checked="checked"{/if} />
                                <label for="{$group}_{$priv}" {if $privoptt.important}style="color:red"{/if}>
                                    {assign value="`$group`_`$priv`" var=grouppriv}{$lang[$grouppriv]}
                                </label>
                            {/if}
                        </td>
                        {counter name=trp}
                    {/foreach}
                    {assign value=0 var=displaythis}
                    {foreach from=$privilages item=privs2 key=group2}
                        {foreach from=$privs2 item=privopt key=priv name=loop}
                            {if $privopt.displaygroup == $group && (!$privopt.condition || $privopt.condition|checkcondition)}
                                {if $trp != 0 && $trp % 3 == 0}</tr>{/if}
                                {if $trp % 3 == 0}
                                    <tr>
                                {/if}
                                <td width="33%">
                                    <input type='hidden' value='0' name="privileges[{$group2}][{$priv}]">
                                    <input type="checkbox" class="privilege {$group2}" id="{$group2}_{$priv}" value="1"
                                           name="privileges[{$group2}][{$priv}]" {if $priv == 'full'}onclick="cHide(this, '{$group2}')"{/if}
                                            {if $submit.privileges.$group2.$priv}checked="checked"{/if} />
                                    <label for="{$group2}_{$priv}" {if $privopt.important}style="color:red"{/if}>
                                        {assign value="`$group2`_`$priv`" var=grouppriv}{$lang[$grouppriv]}
                                    </label>
                                </td>
                                {counter name=trp}
                            {/if}
                        {/foreach}
                    {/foreach}
                    <tr></tr>
                </table>
            </div>
        {/foreach}
    </div>
</div>

<style>
    {literal}
        .privs_items {
            position: relative;
        }
        .privs_items.inactive:before {
            content: '';
            display: block;
            position: absolute;
            background: #fff;
            opacity: .6;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
        }
    {/literal}
</style>
<script type="text/javascript">
    var hide_services = {if $submit.privileges.services.full}true{else}false{/if};
    var hide_domains = {if $submit.privileges.domains.full}true{else}false{/if};
    {literal}
    $(function () {
        cHide($('#services_full'), 'services');
        cHide($('#domains_full'), 'domains');

        if (hide_services) {
            $('.services_h3').addClass('inactive');
            $('.services').closest('.privs_items').addClass('inactive');
        }
        if (hide_services) {
            $('.domains_h3').addClass('inactive');
            $('.domains').closest('.privs_items').addClass('inactive');
        }
    });

    function cUnc(el, target) {
        if ($(el).is(':checked')) {
            $('.' + target).attr('checked', 'checked');
        } else {
            $('.' + target).removeAttr('checked');

        }
    }

    function cHide(el, target) {
        if ($(el).is(':checked')) {
            $('.' + target + '_h3').addClass('inactive');
            $('.' + target).closest('.privs_items').addClass('inactive');
        } else {
            $('.' + target + '_h3').removeClass('inactive');
            $('.' + target).closest('.privs_items').removeClass('inactive');
        }
    }

    function loadProfile(val) {
        $('.privilege').removeAttr('checked');
        $('#priv_dom').show();
        $('#priv_serv').show();
        if (val == 0) {
            return false;
        }
        $.post('?cmd=profiles&action=loadpremade', {premade: val}, function (response) {
            if (response.all) {
                $('.privilege').attr('checked', 'checked');
                return;
            }
            if (response.billing) {
                if (response.billing.all) {
                    $('.billing').attr('checked', 'checked');
                }
            }
            if (response.domains) {
                if (response.domains.all) {
                    $('.domains').attr('checked', 'checked');
                }
            }
            if (response.services) {
                if (response.services.all) {
                    $('.services').attr('checked', 'checked');
                }
            }
            if (response.support) {
                if (response.support.all) {
                    $('.support').attr('checked', 'checked');
                }
            }
        });

        return false;
    }
    {/literal}
</script>