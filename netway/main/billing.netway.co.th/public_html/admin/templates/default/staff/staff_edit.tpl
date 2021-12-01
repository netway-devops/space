{* custom code เพิ่ม ?cmd=servicecataloghandle&action=assignTeam *}

<form name="" action="" method="post" style="padding: 10px" id="{$action}">
    <input name="make" value="{$action}" type="hidden"/>

    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>{$lang.generalsettings}</strong>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="form-group col-md-6">
                    <label>{$lang.firstname}</label>
                    <input type="text" name="firstname" value="{$details.firstname}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.lastname}</label>
                    <input type="text" name="lastname" value="{$details.lastname}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.Email}</label>
                    <input type="text" name="email" value="{$details.email}" class="form-control"/>
                </div>

                <div class="form-group col-md-6">
                    <label>{$lang.Username}</label>
                    <input type="text" name="username" value="{$details.username}" class="form-control"/>
                </div>
                <div class="form-group col-md-6">
                    <label>{$lang.Password}</label>
                    <input type="password" name="password" value="{$details.repeatpass}" class="form-control"/>

                </div>
                <div class="form-group col-md-6">
                    <label>{$lang.repeatpass}</label>
                    <input type="password" name="password2" value="{$details.repeatpass}" class="form-control"/>
                </div>
            </div>

{* custom code เพิ่ม Service Catalog *}

            <div class="form-group">
                <label>{$lang.Signature}</label>
                {if !$details.signature}<a href="#" onclick="$(this).hide();
                    $('#signature').show();
                    return false;"><strong>{$lang.signatureadd}</strong></a>
                {/if}
                <textarea name="signature" id="signature" class="form-control"
                          style="{if !$details.signature};display:none;{/if}">{$details.signature}</textarea>

            </div>

            {if $fields}
                {foreach from=$fields key=f item=fv}
                    {if $fv.type=='input' || $fv.type=='encrypted'}
                        <div class="form-group">
                            <label>{$fv.name}</label>
                            <input type="text" name="{$f}" value="{$details[$f]}" class="form-control"/>
                        </div>
                    {elseif $fv.type=='checkbox'}
                        <div class="checkbox">
                            <label>
                                <input name="{$f}" type="checkbox"
                                       value="1" {if $details[$f]=='1'} checked="checked "{/if} />
                                {$fv.name}
                            </label>
                        </div>
                    {elseif $fv.type=='select'}
                        <div class="form-group">
                            <label>{$fv.name}</label>
                            <select name="{$f}" class="form-control">
                                {foreach from=$fv.default item=i}
                                    <option value="{$i}" {if $details[$f]==$i}selected="selected"{/if}>{$i|lang}</option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}
                {/foreach}
            {/if}

            {if $action!='myaccount'}
                {if $teams}
                    <div class="form-group">
                        <label>Assigned Team</label>
                        <input name="teams[]" value="-1" type="hidden"/>
                        <select name="teams[]" multiple class="form-control group-assign">
                            {foreach from=$teams item=team}
                                <option value="{$team.id}"
                                        {if in_array($team.id, $details.teams)}selected{/if}>{$team.name}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
                {if $details.id}
                    <div class="form-group">
                        <label>{$lang.Status}</label>
                        <div style="font-size: 1.2em">
                            <label>
                                <input type="radio" name="status" value="Active"
                                       {if $details.status == 'Active'}checked{/if} hidden="">
                                <span class="label-livemode label label-success-invert"
                                      data-value="Active">Active</span>
                            </label>
                            <label>
                                <input type="radio" name="status" value="Inactive"
                                       {if $details.status == 'Inactive'}checked{/if} hidden="">
                                <span class="label-livemode label label-default-invert"
                                      data-value="Inactive">Inactive</span>
                            </label>
                        </div>
                    </div>
                {/if}
            {/if}

            {if $action==='myaccount'}
                <hr>

                <div class="form-group">
                    <label>Client-related tabs</label>
                    <span class="vtip_description" title="Select list of tabs related to customer which should appear across your admin UI"></span>
                    <div class="">
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Contacts', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Contacts"> Contacts</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Contracts', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Contracts"> Contracts</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Orders', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Orders"> Orders</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Services', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Services"> Services</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Domains', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Domains"> Domains</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Invoices', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Invoices"> Invoices</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Estimates', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Estimates"> Estimates</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Recurring Invoices', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Recurring Invoices"> Recurring Invoices</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Transactions', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Transactions"> Transactions</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Tickets', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Tickets"> Tickets</label>
                        <label class="checkbox-inline"><input name="ui_config[clienttabs_visible][]" type="checkbox" {if in_array('Logs', $details.ui_config.clienttabs_visible)}checked="checked"{/if} value="Logs"> Logs</label>
                    </div>
                </div>

                <div class="form-group">
                    <label>Default search areas</label>
                    <span class="vtip_description" title="Select smart-search areas that are by default enabled for you"></span>

                    <div class="">
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Clients', $details.ui_config.search_on)}checked="checked"{/if} value="Clients"> Clients</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Contacts', $details.ui_config.search_on)}checked="checked"{/if} value="Contacts"> Contacts</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Orders', $details.ui_config.search_on)}checked="checked"{/if} value="Orders"> Orders</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Accounts', $details.ui_config.search_on)}checked="checked"{/if} value="Accounts"> Accounts</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Domains', $details.ui_config.search_on)}checked="checked"{/if} value="Domains"> Domains</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('DNS', $details.ui_config.search_on)}checked="checked"{/if} value="DNS"> DNS</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Invoices', $details.ui_config.search_on)}checked="checked"{/if} value="Invoices"> Invoices</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Estimates', $details.ui_config.search_on)}checked="checked"{/if} value="Estimates"> Estimates</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Transactions', $details.ui_config.search_on)}checked="checked"{/if} value="Transactions"> Transactions</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Tickets', $details.ui_config.search_on)}checked="checked"{/if} value="Tickets"> Tickets</label>
                        <label class="checkbox-inline"><input name="ui_config[search_on][]" type="checkbox" {if in_array('Products', $details.ui_config.search_on)}checked="checked"{/if} value="Products"> Products</label>
                    </div>
                </div>
            {/if}
        </div>
        <div class="panel-footer">
            <button type="submit" value="1" name="save" class="btn btn-primary">{$lang.savechanges}</button>
            <span
                    class="orspace">{$lang.Or} <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
        </div>
    </div>

    <div class="staff-options">
        {if $action!='myaccount'}
            {include file="staff/acl.tpl"}
            {include file="staff/notify.tpl"}
        {/if}

    </div>


    {securitytoken}
</form>