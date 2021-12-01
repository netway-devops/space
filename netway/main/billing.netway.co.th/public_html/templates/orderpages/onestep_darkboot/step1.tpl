<div class="left-side">
    <h3>{$lang.domains}</h3>
    <div class="underline-title">
        <div class="underline-bolder"></div>
    </div>
    <p>{$lang.productrequiresdomain}. </p>
    <div {if $contents[2]}style="display:none"{/if} id="domoptions11">
        <ul class="domain-config">
            {if $allowregister}   
                <li class="radio">
                    <input type="radio" name="domain" value="illregister" onchange="tabbme(this);  return false;" {if $contents[2].action=='register' || !$contents[2]}checked="checked"{/if} id="illregister_input" />
                    {$business_name|string_format:$lang.iwantregister}
                </li>
            {/if} {if $allowtransfer}
                <li class="radio">
                    <input type="radio" onchange="tabbme(this);  return false;" {if $contents[2].action=='transfer'}checked="checked"{/if} value="illtransfer" name="domain"  id="illtransfer_input" />
                    {$business_name|string_format:$lang.iwanttransfer}
                </li>
            {/if} {if $allowown}
                <li class="radio">
                    <input type="radio" onchange="tabbme(this);  return false;" {if $contents[2].action=='own' && !$subdomain}checked="checked"{/if} value="illupdate" name="domain" id="illupdate_input" />
                    {$lang.iwantupdate}
                </li>
            {/if} {if $subdomain}
                <li class="radio">
                    <input type="radio" onchange="tabbme(this);  return false;" {if $contents[2].action=='own' && $subdomain}checked="checked"{/if} value="illsub" name="domain" id="illsub_input"  />
                    {$lang.iwantsub}
                </li>
            {/if}
        </ul>

        {if $allowregister}
            <div id="illregister" class="t1 slidme">
                <textarea class="domain-textarea" name="sld_register" id="sld_register" style="resize: none"></textarea>
                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="domain-extension">
                    {foreach from=$tld_reg item=tldname name=ttld}
                        {if $smarty.foreach.ttld.index % 4 =='0'}<tr>
                            {/if}
                            <td width="25%" class="checkbox"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> {$tldname}</td>
                            {if $smarty.foreach.ttld.index % 4 =='5'}</tr>
                            {/if}
                        {/foreach}
                    <tr></tr>
                </table>
                <div class="clear"></div>
                <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
            </div>
        {/if}
        {if $allowtransfer}
            <div id="illtransfer" style="display: none;" class="slidme form-horizontal">www.
                <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled span3"/>
                <div class="select-list-fix">
                    <select name="tld_transfer" id="tld_transfer" class="span2">
                        {foreach from=$tld_tran item=tldname}
                            <option>{$tldname}</option> 	
                        {/foreach}
                    </select>
                </div>
                <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
            </div>
        {/if}
        {if $allowown}
            <div id="illupdate" style="display: none;" class="slidme form-horizontal">www.
                <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled span3"/>
                .
                <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span1"/>
                <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
            </div>
        {/if}
        {if $subdomain}
            <div id="illsub" style="display: none;" class="slidme form-horizontal">www.
                <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled span3"/>
                {$subdomain}
                <input type="submit" value="{$lang.check}" class="btn domain-check" onclick="domainCheck(); return false;"/>
            </div>
        {/if}
    </div>
    <div id="updater2" colspan="2" class="added-domains form-horizontal">
        {include file="ajax.checkdomain.tpl"} 
    </div>
    <div id="domoptions22">
        {if $contents[2]}
            {foreach from=$contents[2] item=domenka key=kk}
                <div class="domain-element">
                    <div class="domain-name">
                    {if $domenka.action!='own' && $domenka.action!='hostname'}
                        <strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
                        {$domenka.price|price:$currency}
                    {else}
                        {$domenka.name}
                    {/if}
                    </div>
                    {if $domenka.custom}
                        <form class="cartD" action="" method="post">
                            <table class="styled" width="100%" cellspacing="" cellpadding="6" border="0">
                                {foreach from=$domenka.custom item=cf}
                                    {if $cf.items}
                                        <tr>
                                            <td class="configtd config-fieldtld" >
                                                <label for="custom[{$cf.id}]" class="styled">
                                                    {$cf.name}
                                                    {if $cf.options & 1}*
                                                    {/if}
                                                </label>
                                                {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>
                                                {/if}
                                                {include file=$cf.configtemplates.cart cf_opt_formId=".cartD" cf_opt_name="custom_domain"}
                                            </td>
                                        </tr>
                                    {/if}   
                                {/foreach}
                            </table>
                        </form>
                    {/if}
                </div>
            {/foreach}
            <script type="text/javascript">wrapDomainCustomForms()</script>
            <a href="#" class="btn" onclick="$('#domoptions22').hide();$('#domoptions11').show();return false;">{$lang.change}</a>
        {/if}
    </div>

</div>
