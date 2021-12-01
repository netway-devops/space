
    <div class="toggle-slider domains" rel="domain" change-event="1">
        {if $allowregister}
            <div rel="illregister"  class="toggle-option-fix {if $contents[2].action=='register' || !$contents[2] || !$contents[2].action}active-toggle{/if}" onclick="tabbme(this); return false;">
                <span>{$lang.register}</span>
            </div>
        {/if}
        {if $allowtransfer}
            <div rel="illtransfer"  class="toggle-option-fix {if $contents[2].action=='transfer'}active-toggle{/if}" onclick="tabbme(this); return false;">
                <span>{$lang.transfer}</span>
            </div>
        {/if}
        {if $allowown}
            <div rel="illupdate"  class="toggle-option-fix {if $contents[2].action=='own' && !$subdomain}active-toggle{/if}" onclick="tabbme(this); return false;">
                <span>{$lang.alreadyhave}</span>
            </div>
        {/if}
        {if $subdomain}
            <div rel="illsub"  class="toggle-option-fix {if $contents[2].action=='own' && $subdomain}active-toggle{/if}" onclick="tabbme(this); return false;">
                <span>{$lang.subdomain}</span>
            </div>
        {/if}
    </div>

{if $contents[2]}
    <div id="domoptions22">
        {foreach from=$contents[2] item=domenka key=kk}
            <div>
            {if $domenka.action!='own' && $domenka.action!='hostname'}
                <strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
                {$domenka.price|price:$currency}<br />
            {else}
                {$domenka.name}<br />
            {/if}
            {if $domenka.custom}
                <table class="styled" width="100%" cellspacing="" cellpadding="6" border="0">
                    {foreach from=$domenka.custom item=cf}
                        {if $cf.items}
                            <tr>
                                <td class="configtd" >
                                    <label for="custom[{$cf.id}]" class="styled">{$cf.name}{if $cf.options & 1}*{/if}</label>
                                    {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>
                                    {/if}
                                    {include file=$cf.configtemplates.cart cf_opt_formId=".cartD" cf_opt_name="custom_domain"}
                                </td>
                            </tr>
                        {/if}   
                    {/foreach}
                </table>
            {/if}
            </div>
        {/foreach}
        <a href="#" class="btn" onclick="$('#domoptions22').hide();$('#domoptions11').show();return false;">{$lang.change}</a>
    </div>
{/if}
<div {if $contents[2]}style="display:none"{/if} id="domoptions11">
    <input type="hidden" name="make" value="checkdomain" />
    <div id="options">
        {if $allowregister}
            <div id="illregister" class="t1 slidme">
                <div class="left-section">
                    
                    <div class="domain-input-bulk domain-input" id="multisearch" class="left">
                        <textarea name="sld_register" id="sld_register" style="resize: none"></textarea>
                    </div>
                </div>
                <div class="addon-description">
                    <div class="domain-tld-bulk domain-tld" style="margin-left:10px;width:310px;float:left">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="" class="fs11">
                            {foreach from=$tld_reg item=tldname name=ttld}
                                {if !$smarty.foreach.ttld.first && $smarty.foreach.ttld.index % 3 == 0}</tr>
                                {/if}
                                {if !$smarty.foreach.ttld.last && $smarty.foreach.ttld.index % 3 == 0}<tr>
                                    {/if}
                                    <td width="33%"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> 
                                        {$tldname}
                                    </td>
                                    {if $smarty.foreach.ttld.last}</tr>
                                    {/if}
                                {/foreach}
                            <tr></tr>
                        </table>
                    </div>
                </div>
                <div class="clear"></div>
                <p class="align-right domain-check-bulk">
                    <input type="button" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
                </p>
            </div>
        {/if}
        {if $allowtransfer}
            <div id="illtransfer" style="{if $allowregister}display: none;{/if}"  class="t2 slidme align-center form-horizontal">
                www.
                <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled domain-input"/>
                <select name="tld_transfer" id="tld_transfer" class="span2 domain-tld">
                    {foreach from=$tld_tran item=tldname}
                        <option>{$tldname}</option> 	
                    {/foreach}
                </select>  
                <input type="button" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
            </div>
        {/if}
        {if $allowown}
            <div id="illupdate" style="{if $allowregister || $allowtransfer}display: none;{/if}"  class="t3 slidme align-center form-horizontal"> 
                www.
                <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled domain-input"/>
                .
                <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span2 domain-tld"/>  
                <input type="button" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
            </div>
        {/if}
        {if $subdomain}
            <div id="illsub" style="{if $allowregister || $allowtransfer || $allowown}display: none;{/if}"  class="t4 slidme align-center form-horizontal">
                www.
                <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled domain-input"/>  
                {$subdomain} <input type="button" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
            </div>
        {/if} 
    </div>
    <div id="updater2"></div>
</div>