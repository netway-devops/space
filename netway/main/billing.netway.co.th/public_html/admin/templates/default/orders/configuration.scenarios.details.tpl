{if $do=='add'}
    <form action="" method="post">
        <input type="hidden" name="make" value="add"/>
        <table width="760" cellspacing="0" cellpadding="6" border="0">
            <tbody>
            <tr>
                <td width="205" align="right"><b>Scenario Name</b></td>
                <td><input type="text" name="name" class="inp" size="30"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
                        <tbody>
                        <tr>
                            <th align="left" width="20"><b>On/Off</b></th>
                            <th align="left"><b>Step</b></th>
                            <th align="left" width="70"></th>
                            <th align="left" width="160"></th>
                        </tr>
                        {foreach from=$defaults item=step name=scloop}
                            <tr>
                                <td>
                                    <input value="1" type="checkbox" name="steps[{$step.name}][enabled]" {if !($step.options & 8)}disabled="disabled" checked="checked" {else}{if $step.enabled}checked="checked"{/if}{/if} />

                                    {if $step.name === 'FraudCheck'}
                                        <input type="hidden" name="steps[{$step.name}][config][enabled_modules][]" value="all" >
                                    {/if}
                                </td>
                                <td class="lastitm">{$lang[$step.name]}</td>
                                <td><img src="templates/default/img/question-small-white.png" alt="" class="left"><a href="#" class="fs11" onclick="$('#description_{$step.name}').toggle();return false;">About</a>
                                </td>
                                <td class="lastitm">
                                    <input type="radio" {if !($step.options & 1)}disabled="disabled"{/if} {if $step.auto=='1'}checked="checked"{/if}name="steps[{$step.name}][auto]" value="1"/> Automated
                                    <input type="radio" {if !($step.options & 2)}disabled="disabled"{/if} {if $step.auto!='1'}checked="checked"{/if}name="steps[{$step.name}][auto]" value="0"/> Manual
                                </td>
                            </tr>
                            <tr class="even">
                                <td colspan="4" style="display:none" class="fs11" id="description_{$step.name}">{$step.description}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="Add scenario" style="font-weight:bold" class="submitme"/>
                </td>
            </tr>
            </tbody>
        </table>
        {securitytoken}
    </form>
{elseif $do=='edit'}
    <form action="" method="post">
        <input type="hidden" name="make" value="edit"/>
        <table width="760" cellspacing="0" cellpadding="6" border="0">
            <tbody>
            <tr>
                <td width="205" align="right"><b>Scenario Name</b></td>
                <td><input type="text" name="name" class="inp" size="30" value="{$scenario.name}"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
                        <tbody>
                        <tr>
                            <th align="left" width="20"><b>On/Off</b></th>
                            <th align="left"><b>Step</b></th>
                            <th align="left" width="70"></th>
                            <th align="left" width="160"></th>
                            <th align="left" width="70"></th>
                        </tr>
                        {foreach from=$scenario.steps item=step name=scloop}
                            <tr>
                                <td>
                                    <input value="1" type="checkbox" name="steps[{$step.id}][enabled]" {if !($step.options & 8)}disabled="disabled" checked="checked" {else}{if $step.enabled}checked="checked"{/if}{/if} />
                                </td>
                                <td class="lastitm">{$lang[$step.name]}</td>
                                <td><img src="templates/default/img/question-small-white.png" alt="" class="left"><a href="#" class="fs11" onclick="$('#description_{$step.name}').toggle();return false;">About</a></td>
                                <td class="lastitm">
                                    <input type="radio" {if !($step.options & 1)}disabled="disabled"{/if} {if $step.auto=='1'}checked="checked"{/if}name="steps[{$step.id}][auto]" value="1"/> Automated
                                    <input type="radio" {if !($step.options & 2)}disabled="disabled"{/if} {if $step.auto!='1'}checked="checked"{/if}name="steps[{$step.id}][auto]" value="0"/> Manual
                                </td>
                                <td class="lastitm">
                                    {assign var='steps_configure' value=','|explode:"FraudCheck"}
                                    {if in_array($step.name, $steps_configure)}
                                        <a href="#" class="fs11" data-toggle="modal" data-target="#configureModal-{$step.name}">Configure</a>
                                        <div class="modal fade" id="configureModal-{$step.name}" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Configure step: <b>{$lang[$step.name]}</b></h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        {if $step.name === 'FraudCheck'}
                                                            <label>Enabled Fraud Protection modules</label>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id="configEnabledModules-All" type="checkbox" name="steps[{$step.id}][config][enabled_modules][]" value="all" {if in_array('all', $step.config.enabled_modules)}checked="checked"{/if} onchange="if ($(this).is(':checked')) $('.configEnabledModule').prop('checked',true).prop('disabled',true); else $('.configEnabledModule').prop('disabled',false);">
                                                                <label class="form-check-label" for="configEnabledModules-All">All modules</label>
                                                            </div>
                                                            {foreach from=$fraud_modules item=modd}
                                                                <div class="form-check">
                                                                    <input class="form-check-input configEnabledModule" id="configEnabledModules-{$modd.id}" type="checkbox" name="steps[{$step.id}][config][enabled_modules][]" value="{$modd.id}" id="config" {if in_array($modd.id, $step.config.enabled_modules) || in_array('all', $step.config.enabled_modules)}checked="checked"{/if} {if in_array('all', $step.config.enabled_modules)}disabled="disabled"{/if}>
                                                                    <label class="form-check-label" for="configEnabledModules-{$modd.id}">{$modd.modname}</label>
                                                                </div>
                                                            {/foreach}
                                                        {/if}
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    {/if}

                                    <input type="hidden" name="steps[{$step.id}][options]" value="{$step.options}"/>
                                </td>
                            </tr>
                            <tr class="even">
                                <td colspan="4" style="display:none" class="fs11" id="description_{$step.name}">{$step.description}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class="submitme"/>
                </td>
            </tr>
            </tbody>
        </table>
        {securitytoken}
    </form>
{else}
    <table border="0" cellspacing="0" cellpadding="6" width="100%">
        <tr>
            <td width="33%" valign="top">
                <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
                    <tbody>
                    <tr>
                        <th align="left" colspan="2"><b>Available scenarios</b></th>
                    </tr>
                    {foreach from=$scenarios item=scenario name=scloop}
                        <tr {if $smarty.foreach.scloop.index%2==0}class="even"{/if}>
                            <td>
                                <a href="?cmd=configuration&action=orderscenarios&do=edit&id={$scenario.id}">{$scenario.name}</a>
                            </td>
                            <td width="20" class="lastitm">
                                {if $scenario.id!=1} <a onclick="return confirm('Do you really want to delete this scenario?')" class="delbtn" href="?cmd=configuration&action=orderscenarios&make=delete&security_token={$security_token}&id={$scenario.id}">Delete</a>{/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
                <br/>
                <div>
                    <a href="?cmd=configuration&action=orderscenarios&do=add" class=" new_control greenbtn"><span>Create new scenario</span></a>
                </div>
            </td>
            <td valign="top">
                <div class="blank_state blank_news" style="padding:30px 0px">
                    <div class="blank_info">
                        <h1>Keep orders life cycle under control</h1>
                        Order scenarios allows you to set HostBill order processing steps to best suit your business
                        model.<br/>
                        You can choose and control which parts in order life cycle should happen automatically, and
                        which requires staff review.<br/>
                        Each order page can have different scenario set
                        <div class="clear"></div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
{/if}