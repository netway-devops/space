<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            {include file='configuration/leftmenu.tpl'}
        </td>
        <td valign="top" class="bordered">
            <div id="bodycont" style="">
                {include file="configuration/nav.tpl" picked_tab='1'}
                <form method="post" action="">
                    <div class="nicerblu">
                        <input type="hidden" name="make" value="save" />
                        <table border="0" cellspacing="0" cellpadding="6" width="100%">
                            <tr class="bordme">
                                <td width="205" align="right" style="vertical-align: top;">
                                    <strong>{$lang.general_agreements}</strong>
                                    <a title="{$lang.terms_accept}" class="vtip_description"></a>
                                </td>
                                <td>
                                    {include file='configuration/terms.tpl' terms=$terms}
                                </td>
                            </tr>
                            <tr class="bordme">
                                <td width="205" align="right" style="vertical-align: top;">
                                    <strong>{$lang.contract_templates}</strong>
                                    <a title="Contracts are auto-generated documents that customer accepts after order. You can use contracts created here in product configuration in Other Settings tab" class="vtip_description"></a>
                                </td>
                                <td>
                                    {include file='configuration/contracts.tpl'}
                                </td>
                            </tr>

                            <tr class="bordme">
                                <td width="205" align="right"><strong>{$lang.contract_generation}</strong></td>
                                <td >
                                    <input name="ContractGeneration" type="radio" value="generate" class="inp" {if $configuration.ContractGeneration==='generate'}checked="checked"{/if} />
                                    {$lang.GenerateContractForEachNewClient}<br/>
                                    <input name="ContractGeneration" type="radio" value="default" class="inp" {if $configuration.ContractGeneration==='default'}checked="checked"{/if} />
                                    {$lang.AttemptToReuseDefaultContract} <br/>
                                </td>
                            </tr>

                            <tr class="bordme">
                                <td width="205" align="right" style="vertical-align: top;">
                                    <strong>{$lang.default_contract_template}</strong>
                                </td>
                                <td colspan="3" style="position: relative">
                                    <table class="table table-striped" cellspacing="0" cellpadding="3">
                                        <tr>
                                            <td width="10">
                                                <input class="left" type="radio" name="DefaultContractTemplate" value="0" {if !$configuration.DefaultContractTemplate}checked="checked"{/if} />
                                            </td>
                                            <td>
                                                {if !$configuration.DefaultContractTemplate}<strong>{/if}
                                                    None, do not generate contract if its not set in product
                                                    {if !$configuration.DefaultContractTemplate}</strong>{/if}
                                            </td>
                                        </tr>
                                        {foreach from=$contracts item=tpl}
                                            <tr>
                                                <td width="10">
                                                    <input class="left" type="radio" name="DefaultContractTemplate" value="{$tpl.id}" {if $configuration.DefaultContractTemplate==$tpl.id}checked="checked"{/if} />
                                                </td>
                                                <td>
                                                    {if $configuration.DefaultContractTemplate==$tpl.id}<strong>{/if}
                                                        {$tpl.name}
                                                    {if $configuration.DefaultContractTemplate==$tpl.id}</strong>{/if}
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                    <div class="def_contract_save_first" style="display:none;position:absolute;top:0;bottom:0;left:0;right:0;height:100%;justify-content:center;align-items:center;background: rgba(250,250,250,0.8);">
                                        <code>Save changes first!</code>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nicerblu" style="text-align: center">
                        <input class="btn btn-primary" style="font-weight: bold" type="submit" value="{$lang.savechanges}">
                        {securitytoken}
                    </div>
                </form>
            </div>
        </td>
    </tr>
</table>