<div class="container-fluid clear tabs tab-dnsautomation" style="padding: 0;">

    <div class="row tab-automation tab-service-dnsautomation" style="padding: 0 15px;">
        <div class="col-md-12">

            <table style="margin-bottom: 20px;" width="100%" cellspacing="0" cellpadding="10">
                <tbody>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Apply DNS automation rules</strong></td>
                    <td>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="configuration[owndomain]" value="1"  {if $dns_config.owndomain == 1}checked="checked"{/if} />
                                On account creation when client selected to use his own domain
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="configuration[subdomain]" value="1"
                                       {if $dns_config.subdomain == 1}checked="checked"{/if} />
                                On account creation when client used free subdomain
                            </label>
                        </div>

                    </td>
                </tr>
                </tbody>
            </table>

        </div>

        <div class="col-md-12">
            <div class="nicerblu" style="text-align:center; margin-bottom: 15px;">
                <input type="submit" value="Save Changes" name="save[dnsautomation]" style="font-weight:bold" class="btn btn-primary">
            </div>
        </div>

        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>DNS automation rules</strong>
                </div>
                <div class="panel-body" style="padding: 0px;">

                    <table class="table table-striped" width="100%" cellspacing="0">
                        <tbody>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Products</th>
                            <th>DNS Package</th>
                            <th>DNS Template</th>
                            <th>Default IP</th>
                            <th style="width: 90px"></th>
                        </tr>
                        {foreach from=$rules item=rule}
                            <tr>
                                <td><a href="?cmd=dns_automation&action=edit&rule_id={$rule.id}">{$rule.name}</a></td>
                                <td>{$rule.description|truncate:40}</td>
                                <td>
                                    {foreach from=$products item=product}
                                        {assign var=pid value="c`$product.id`"}
                                        {if in_array($pid, $rule.products)}
                                        <a href="?cmd=services&action=category&id={$product.id}" style="text-decoration: none;" target="_blank">
                                            <span class="label label-warning">{$product.name}</span>
                                            </a>{continue}
                                        {else}
                                            {foreach from=$product.products item=pro}
                                                {assign var=pid value="p`$pro.id`"}
                                                {if in_array($pid, $rule.products)}
                                                    <a href="?cmd=services&action=product&id={$pro.id}" style="text-decoration: none;" target="_blank">
                                                        <span class="label label-primary">{$pro.name}</span>
                                                    </a>
                                                    {continue}
                                                {/if}
                                            {/foreach}
                                        {/if}
                                    {/foreach}
                                </td>
                                <td>
                                    {foreach from=$packages item=package}
                                        {if $package.id == $rule.dns_package_id}
                                            <a href="?cmd=services&action=product&id={$package.id}" target="_blank">{$package.name}</a>{break}
                                        {/if}
                                    {/foreach}
                                </td>
                                <td>
                                    {foreach from=$dns_templates item=dns_template}
                                        {if $dns_template[0].id == $rule.dns_template_id}
                                        <a href="?cmd=dns_automation&picked_tab=2&template_id={$dns_template[0].id}#tpl_{$dns_template[0].id}" target="_blank">
                                            {$dns_template[0].template}
                                            </a>{break}
                                        {/if}
                                    {/foreach}
                                </td>
                                <td>{$rule.default_ip}</td>
                                <td>
                                    <div class="pull-right">
                                        <a href="?cmd=dns_automation&action=edit&rule_id={$rule.id}" class="menuitm menu-auto">
                                            <span style="color: red">Edit</span>
                                        </a>
                                        <a href="?cmd=dns_automation&action=delete&rule_id={$rule.id}&security_token={$security_token}" class="menuitm menu-auto" onclick="return confirm('Are you sure you want to remove this rule?')">
                                            <span class="delsth"></span>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            {foreachelse}
                            <tr>
                                <td colspan="7" class="text-center">{$lang.nothingtodisplay}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>

                <div class="panel-footer">
                    <a href="?cmd=dns_automation&action=add" class="btn btn-sm btn-success">New DNS automation rule</a>
                </div>
            </div>
        </div>
    </div>
</div>