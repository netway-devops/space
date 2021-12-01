<div class="container-fluid clear tabs tab-premium" style="margin-top:10px;">
    <div class="row">
        <div class="col-md-12">
            <table style="margin-bottom: 20px;" width="100%" cellspacing="0" cellpadding="10">
                <tr class="bordme">
                    <td align="right" width="205"><strong>Enable premium names</strong></td>
                    <td>
                        <input name="configuration[EnablePremiumDomains]" type="radio" value="on" {if $configuration.EnablePremiumDomains == 'on'}checked{/if}> <strong>Yes</strong>,
                        if searched domain is premium and available, offer it with margin


                        <br/>
                        <input name="configuration[EnablePremiumDomains]" type="radio" value="off" {if $configuration.EnablePremiumDomains != 'on'}checked{/if}> <strong>No</strong>,
                        if searched domain is premium and available, show as unavailable
                    </td>
                </tr>
                <tr class="bordme">
                    <td align="right" width="205"><strong>Active modules supporting premium names</strong> <i class="vtip_description" title="If there is no active module supporting premium names, or module is not selected as lookup engine in lookup settings, premium names will not be indicated as premium."></i></td>
                    <td>
                        {foreach from=$premium_engines item=md}<a href="?cmd=managemodules&action=domain" target="_blank" >{$md}</a> {foreachelse}
                            <label class="label label-danger">Warning</label> No <a href="?cmd=managemodules&action=domain" target="_blank" >active domain registrar</a> module supports this feature, if searched domain is premium, there is a risk that it will be registered at regular price{/foreach}
                    </td>
                </tr>


                <tr class="bordme">
                    <td align="right" width="205"><strong>Price margin</strong> <i class="vtip_description" title="Price coming from registry will be increased by this margin"></i></td>
                    <td>
                        <input name="configuration[PremiumDomainMargin]" type="number"  min="0" value="{$configuration.PremiumDomainMargin|default:0}" class="inp" size="3" /> %

                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="nicerblu" style="text-align:center">
        <input type="submit" value="Save Changes" name="save[premium]" style="font-weight:bold" class="btn btn-primary">
    </div>
</div>