{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'contacts/add_edit.tpl.php');
{/php}

{literal}
    <script type="text/javascript" >
        $(function () {
            $('input#services_full').change(function() {
                if ($(this).is(':checked'))
                    $('#priv_serv').slideUp();
                else
                    $('#priv_serv').slideDown();
            }).change();
            $('input#domains_full').change(function() {
                if ($(this).is(':checked'))
                    $('#priv_dom').slideUp();
                else
                    $('#priv_dom').slideDown();
            }).change();
        });
    </script>
{/literal}

<section class="section-account-header">
    <h1>{if $action=='add'} {$lang.addnewprofile} {else} {$lang.profiledetails}{/if}</h1>
</section>

<section class="section-account">
    <form class="m20" action='' method='post' data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], [disabled], :hidden">
        <input type="hidden" name="make" value="{if $action=='add'}addprofile{else}editprofile{/if}"/>

        {include file="ajax.signup.tpl"}

        <div class="row">
            <div class="col-12 col-md-6">
                <input name="notifyclient" value="yes" type="checkbox" id="notifyclient" {if $submit.notifyclient}checked="checked"{/if}/>
                <label for="notifyclient">{$lang.notifycontact}</label>
            </div>
        </div>

        <div class="d-flex flex-row justify-content-center align-items-center my-5">
            <button type="submit" class="btn btn-primary btn-lg w-25 my-2">{$lang.submit}</button>
        </div>
        <hr>
        <h3 class="mt-5">{$lang.privileges}</h3>
        <p>
            <b>{$lang.premadepriv}</b>
            <a href="0" onclick="return loadProfile($(this).attr('rel'))" rel="{$p.file}" class="badge badge-info">{$lang.none}</a>
            {foreach from=$premade item=p}
                <a href="#" rel="{$p.file}" onclick="return loadProfile($(this).attr('rel'))" class="badge badge-info">
                    {if $lang[$p.lang]}{$lang[$p.lang]}
                    {else}{$p.name}
                    {/if}
                </a>
            {/foreach}
        </p>
        <div>
            {foreach from=$privilages item=privs key=group}
                {foreach from=$privs item=privopt}
                    {if !$privopt.displaygroup || $privoptdisplaygroup==group}
                        {assign value=1 var=displaythis}
                    {/if}
                {/foreach}
                {if $displaythis!=1}{break}{/if}
                <br/>
                <strong>
                    <input type="checkbox" class="privilege " id="{$group}_main" onclick="cUnc(this, '{$group}')"/>
                    <label for="{$group}_main">
                        {assign value="`$group`_main" var=groupmain}
                        {$lang[$groupmain]}
                    </label>
                </strong>
                <div class="mb-2">
                    <div class="row">
                        {foreach from=$privs item=privopt key=priv name=loop}
                            {if $privopt.condition && !$privopt.condition|checkcondition}{continue}{/if}
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege {$group}" id="{$group}_{$priv}" value="1" name="privileges[{$group}][{$priv}]" {if $submit.privileges.$group.$priv}checked="checked"{/if} />
                                <label for="{$group}_{$priv}" {if $privopt.important}style="color:red"{/if}>
                                    {assign value="`$group`_`$priv`" var=grouppriv}{$lang[$grouppriv]}
                                </label>
                            </div>
                        {/foreach}
                    </div>
                    <div class="row">
                        {assign value=0 var=displaythis}
                        {foreach from=$privilages item=privs2 key=group2}
                            {foreach from=$privs2 item=privopt key=priv name=loop}
                                {if $privopt.displaygroup == $group && (!$privopt.condition || $privopt.condition|checkcondition)}
                                    <div class="col-12 col-md-6 col-lg-4">
                                        <input type="checkbox" class="privilege {$group2}" id="{$group2}_{$priv}" value="1" name="privileges[{$group2}][{$priv}]" {if $submit.privileges.$group2.$priv}checked="checked"{/if} />
                                        <label for="{$group2}_{$priv}" {if $privopt.important}style="color:red"{/if}>
                                            {assign value="`$group2`_`$priv`" var=grouppriv}{$lang[$grouppriv]}
                                        </label>
                                    </div>
                                {/if}
                            {/foreach}
                        {/foreach}
                    </div>
                </div>
            {/foreach}
            <div id="priv_supportdepts">
                <br />
                <input type="checkbox" class="privilege" id="dpmain" onclick="cUnc(this, 'dp_parmtents')" />
                <label for="dpmain" class="font-weight-bold">{$lang.disable_access_to_departments}</label>
                <div class="mb-2">
                    <div class="row row_priv_supportdepts">
                        {foreach from=$support_departments item=dept name=dptw}
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege dp_parmtents" id="support_department{$dept.id}" value="1" name="privileges[disabled_support_departments][{$dept.id}]" {if $submit.privileges.disabled_support_departments[$dept.id]} checked="checked"{/if}/>
                                <label for="support_department{$dept.id}">{$dept.name}</label>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div id="priv_serv" {if $submit.privileges.services.full}style="display:none"{/if}>
                {foreach from=$services item=o}
                    <br />
                    <strong>
                        <input type="checkbox" class="privilege " id="smain_{$o.id}" onclick="cUnc(this, 's{$o.id}')" />
                        <label for="smain_{$o.id}">
                            {$o.catname} - {$o.name}
                            {if $o.domain}
                                <em>( {$o.domain} )</em>
                            {/if}
                            {if $o.label}
                                <i class="label label-default">{$o.label}</i>
                            {/if}
                        </label>
                    </strong>
                    <div class="mb-2">
                        <div class="row row_priv_supportdepts">
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege s{$o.id} services" id="services_{$o.id}_basic" value="1" name="privileges[services][{$o.id}][basic]" {if $submit.privileges.services[$o.id].basic}checked="checked"{/if}/>
                                <label for="services_{$o.id}_basic">{$lang.services_basic}</label>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege  s{$o.id} services" id="services_{$o.id}_billing" value="1" name="privileges[services][{$o.id}][billing]" {if $submit.privileges.services[$o.id].billing}checked="checked"{/if}/>
                                <label for="services_{$o.id}_billing">{$lang.services_billing}</label>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege  s{$o.id} services" id="services_{$o.id}_cancelation" value="1" name="privileges[services][{$o.id}][cancelation]" {if $submit.privileges.services[$o.id].cancelation}checked="checked"{/if} />
                                <label for="services_{$o.id}_cancelation">{$lang.services_cancelation}</label>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege s{$o.id} services" id="services_{$o.id}_upgrade" value="1" name="privileges[services][{$o.id}][upgrade]" {if $submit.privileges.services[$o.id].upgrade}checked="checked"{/if}/>
                                <label for="services_{$o.id}_upgrade">{$lang.services_upgrade}</label>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege s{$o.id} services" id="services_{$o.id}_notify" value="1" name="privileges[services][{$o.id}][notify]" {if $submit.privileges.services[$o.id].notify}checked="checked"{/if}/>
                                <label for="services_{$o.id}_notify">{$lang.services_notify}</label>
                            </div>
                            {if $o.widgets}
                                {foreach from=$o.widgets item=w name=wl}
                                    <div class="col-12 col-md-6 col-lg-4">
                                        <input type="checkbox" class="privilege s{$o.id} services" id="services_{$o.id}_{$w.name}" value="1" name="privileges[services][{$o.id}][{$w.name}]" {if $submit.privileges.services[$o.id][$w.name]}checked="checked"{/if}/>
                                        <label for="services_{$o.id}_{$w.name}">{$w.fullname|lang}</label>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                {/foreach}
            </div>
            <div id="priv_dom" {if $submit.privileges.domains.full}style="display:none"{/if}>
                {foreach from=$domains item=o}
                    <br />
                    <strong>
                        <input type="checkbox" class="privilege " id="dmain_{$o.id}" onclick="cUnc(this, 'd{$o.id}')" />
                        <label for="dmain_{$o.id}">{$lang.domain} - {$o.name}</label>
                    </strong>
                    <div class="mb-2">
                        <div class="row row_priv_supportdepts">
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege d{$o.id} domains" id="domains_{$o.id}_basic" value="1" name="privileges[domains][{$o.id}][basic]" {if $submit.privileges.domains[$o.id].basic}checked="checked"{/if}/>
                                <label for="domains_{$o.id}_basic">{$lang.domains_basic}</label>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege  d{$o.id} domains" id="domains_{$o.id}_renew" value="1"  name="privileges[domains][{$o.id}][renew]" {if $submit.privileges.domains[$o.id].renew}checked="checked"{/if}/>
                                <label for="domains_{$o.id}_renew">{$lang.domains_renew}</label>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <input type="checkbox" class="privilege  d{$o.id} domains" id="domains_{$o.id}_notify" value="1"  name="privileges[domains][{$o.id}][notify]" {if $submit.privileges.domains[$o.id].notify}checked="checked"{/if}/>
                                <label for="domains_{$o.id}_notify">{$lang.services_notify}</label>
                            </div>
                            {if $o.widgets}
                                {foreach from=$o.widgets item=w name=wl}
                                    <div class="col-12 col-md-6 col-lg-4">
                                        <input type="checkbox" class="privilege d{$o.id} domains" id="domains_{$o.id}_{$w.name}" value="1" name="privileges[domains][{$o.id}][{$w.name}]" {if $submit.privileges.domains[$o.id][$w.name]}checked="checked"{/if}/>
                                        <label for="domains_{$o.id}_{$w.name}">{$w.fullname|lang}</label>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
        <div class="d-flex flex-row justify-content-center align-items-center my-5">
            <button type="submit" class="btn btn-primary btn-lg w-25 my-2">{$lang.submit}</button>
        </div>
        {securitytoken}
    </form>
</section>

{literal}
    <script type="text/javascript">
        function cUnc(el, target) {
            if ($(el).is(':checked')) {
                $('.' + target).prop('checked', true);
            } else {
                $('.' + target).removeAttr('checked');
            }
        }
        function loadProfile(val) {
            $('.privilege').removeAttr('checked');
            $('#priv_dom').show();
            $('#priv_serv').show();
            if (val == 0) {
                return false;
            }
            $.post('?cmd=profiles&action=loadpremade', {premade: val}, function(response) {
                if (response.all) {
                    $('.privilege').prop('checked', true).change();
                    return;
                }
                if (response.billing) {
                    if (response.billing.all) {
                        $('.billing').prop('checked', true).change();
                    }
                }
                if (response.domains) {
                    if (response.domains.all) {
                        $('.domains').prop('checked', true).change();
                    }
                }
                if (response.services) {
                    if (response.services.all) {
                        $('.services').prop('checked', true).change();
                    }
                }
                if (response.support) {
                    if (response.support.all) {
                        $('.support').prop('checked', true).change();
                    }
                }
            });
            return false;
        }
    </script>
{/literal}