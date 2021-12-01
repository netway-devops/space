{include file='cart_bookshelf/cart.progress.tpl'}
{include file='cart_bookshelf/cart.summary.tpl'}
<div class="left left-column">
    <div class="line-header clearfix first"><h3>{$lang.productconfig2}</h3></div>
    <form action="" method="post" id="cart3">
        <input type="hidden" name="make" value="domainconfig" />
        <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="checker form-horizontal product-items">
            <tbody>
                <tr class="domain-list">
                    <th width="75%" align="left">{$lang.domain}</th>
                    <th width="30%">{$lang.period}</th>
                    <th width="5%">&nbsp; </th>
                </tr>

                {foreach from=$domain item=doms key=kk name=domainsloop}
                    <tr class="domain-row-{$kk} domain-row {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                        <td style="border:none;">
                            <strong class="grey">{counter name=domainno}.</strong>
                            <strong>{$doms.name}</strong>
                            <input type="hidden" value="{$kk}" name="domkey[]" />
                        </td>
                        <td style="border:none;" align="center">
                            <select name="period[{$kk}]" id="domain-period-{$kk}" class="dom-period" onchange="if(typeof (simulateCart)=='function') simulateCart('#cart3')" >
                                {foreach from=$doms.product.periods item=period key=p}
                                    <option value="{$p}" {if $p==$doms.period}selected="selected"{/if}>{$p} {$lang.years}</option>
                                {/foreach}
                            </select>
                        </td>
                        <td style="border:none;" align="center">
                            <a href="#" class="remove-btn" onclick="return remove_domain('{$kk}', '{$lang.itemremoveconfirm}')" ></a>
                        </td>
                    </tr>

                    {if !$renewalorder && $doms.custom}
                        {foreach from=$doms.custom item=cf}
                            {if $cf.items}
                                <tr  class="domain-row-{$kk}  domain-row  {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                                    <td colspan="3" class="configtd" >
                                        <div class="cf-domain"><strong>{$cf.name} {if $cf.options & 1}*{/if}</strong></div>
                                        {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>
                                        {/if}
                                        {include file=$cf.configtemplates.cart}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                    {/if}
                    {if $doms.action=='transfer'}
                        {if $doms.product.epp=='1'}
                            <tr  class="domain-row-{$kk}  domain-row  {if $smarty.foreach.domainsloop.index%2==0}even{/if}" >
                                <td colspan="3"  style="border:none" class="configtd">
                                    <label for="epp{$kk}" class="styled"> {$lang.eppcode}*</label>
                                    <input name="epp[{$kk}]"  id="epp{$kk}" value="{$doms.epp}" class="styled" />

                                </td>
                            </tr>
                        {else}
                        <input name="epp[{$kk}]" type="hidden" value="not-required" />
                    {/if}
                {/if}
            {/foreach}
            </tbody>
        </table>

        {if !$renewalorder}

            <input type="hidden" name="usens" value="{if $usens=='1'}1{else}0{/if}" id="usens" />
            <div{if $usens && $product && !$periods}style="display:none"{/if}>
                    <div class="line-header clearfix"><h3>{$lang.edit_config}</h3></div>
                    <table cellspacing="0" cellpadding="0" border="0" class="styled" width="100%">
                        <colgroup class="firstcol"></colgroup>
                        <colgroup class="alternatecol"></colgroup>

                        <tr id="setnservers" {if $usens=='1'}style="display:none"{/if}>
                            <td ><b>{$lang.cart2_desc4}</b> <span title="{$lang.cart2_desc3} " class="vtip_description"></span></td>
                            <td width="240px"><a href="#" onclick="$(this).parents('tr').eq(0).hide();$('#usens').val(1);$('#nameservers').slideDown();return false"><strong>{$lang.iwantminens}</strong></a></td>
                        </tr>

                        {if $periods}
                            <tr >
                                <td><b>{$lang.cart2_desc5}</b> <span title="{$lang.cart2_desc2}" class="vtip_description"></span></td>
                                <td>
                                    <select onchange="bulk_periods(this)">
                                        {foreach from=$periods item=period key=p}
                                            <option value="{$p}">{$p} {$lang.years}</option>
                                        {/foreach}
                                    </select>
                                </td>
                            </tr>
                        {/if}
                        {if !$product}
                            <tr>
                                <td><b>{$lang.nohosting}</b> <span title="{$lang.cart2_desc1}" class="vtip_description"></span></td>
                                <td><a href="{$ca_url}cart&step=0&addhosting=1">{$lang.clickhere1}</a></td>
                            </tr>
                        {/if}
                    </table>
                </div>
                <div id="nameservers" {if !$usens}style="display:none"{/if}>
                    <div class="line-header clearfix"><h3>{$lang.nameservers}</h3></div>
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                        <colgroup class="firstcol"></colgroup>
                        <colgroup class="alternatecol"></colgroup>
                        <tr><td width="20%"><strong>{$lang.nameserver} 1</strong></td><td><input name="ns1" style="width:60%" value="{$domain[0].ns1}" class="styled"/></td></tr>
                        {if $domain[0].nsips}<tr><td width="20%"><strong>{$lang.nameserver} IP 1</strong></td><td><input name="nsip1" style="width:60%" value="{$domain[0].nsip1}" class="styled"/></td></tr>
                                {/if}
                        <tr><td><strong>{$lang.nameserver} 2</strong></td><td> <input name="ns2" style="width:60%" value="{$domain[0].ns2}"  class="styled"/></td></tr>
                        {if $domain[0].nsips}<tr><td width="20%"><strong>{$lang.nameserver} IP 2</strong></td><td><input name="nsip2" style="width:60%" value="{$domain[0].nsip2}" class="styled"/></td></tr>
                                {/if}
                        <tr><td><strong>{$lang.nameserver} 3</strong></td><td><input name="ns3" style="width:60%" value="{$domain[0].ns3}"  class="styled"/></td></tr>
                        {if $domain[0].nsips}<tr><td width="20%"><strong>{$lang.nameserver} IP 3</strong></td><td><input name="nsip3" style="width:60%" value="{$domain[0].nsip3}" class="styled"/></td></tr>
                                {/if}
                        <tr><td><strong>{$lang.nameserver} 4</strong></td><td><input name="ns4" style="width:60%" value="{$domain[0].ns4}" class="styled" /></td></tr>
                        {if $domain[0].nsips}<tr><td width="20%"><strong>{$lang.nameserver} IP 4</strong></td><td><input name="nsip4" style="width:60%" value="{$domain[0].nsip4}" class="styled"/></td></tr>
                                {/if}
                    </table>
                    <a href="#" onclick="$('#nameservers').slideUp();$('#setnservers').show();$('#usens').val(0);return false">{$lang.useourdefaultns}</a>
                </div>

                <input type="hidden" name="contactsenebled" value="1"  />
                <div >
                    <div class="line-header clearfix"><h3>{$lang.domcontacts}</h3></div>

                    <div class="contacts">
                        <input type="checkbox" name="contacts[usemy]" value="1" {foreach from=$cart_contents[2] item=doms}{if !$doms.extended}checked="checked"{else}{assign value=$doms.extended var=set_contacts}{/if}{break}{/foreach} onchange="if(!this.checked)$(this).next().slideDown('fast'); else $(this).next().slideUp('fast'); " />
                        {if $logged=="1"} {$lang.domcontact_loged}      
                        {else} {$lang.domcontact_checkout}
                        {/if}
                        <div {if !$set_contacts}style="display: none;"{/if}>
                            <div>
                                <select {if $logged!="1" || !$contacts}style="display:none"{/if} class="right" onchange="if( $(this).val() == 'new') insert_singupform(this); else $(this).siblings('.sing-up').html('');" name="contacts[registrant]">
                                    <option value="new">{$lang.definenew}</option>
                                    {if $logged=="1"}
                                        {foreach from=$contacts item=contact}
                                            <option {if $set_contacts.registrant == $contact.id}selected="selected"{/if} value="{$contact.id}">{if $contact.companyname}{$contact.companyname}{else}{$contact.firstname} {$contact.lastname}{/if}</option>
                                        {/foreach}
                                    {/if}
                                </select>
                                <strong class="lh28">{$lang.registrantinfo}</strong>
                                <div class="sing-up">
                                    {if is_array($set_contacts.registrant)}
                                        {include file="ajax.signup.tpl" submit=$set_contacts.registrant fields=$singupfields}
                                    {literal}<script type="text/javascript">$('.sing-up:first').find('input, select, textarea').each(function(){$(this).attr('name', 'contacts[registrant]['+$(this).attr('name')+']'); })</script>{/literal}
                                {elseif !is_numeric($set_contacts.registrant)}
                                    <script type="text/javascript">insert_singupform($('select[name="contacts[registrant]"]'));</script>
                                {/if}
                            </div>
                        </div>
                        <div class="clear">
                            <select class="right" onchange="if( $(this).val() == 'new') insert_singupform(this); else $(this).siblings('.sing-up').html('');" name="contacts[admin]">
                                <option value="registrant">{$lang.useregistrant}</option>
                                <option {if is_array($fields.contacts.admin)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                                {if $logged=="1"}
                                    {foreach from=$contacts item=contact}
                                        <option {if $set_contacts.admin == $contact.id}selected="selected"{/if} value="{$contact.id}">{if $contact.companyname}{$contact.companyname}{else}{$contact.firstname} {$contact.lastname}{/if}</option>
                                    {/foreach}
                                {/if}
                            </select>

                            <strong class="lh28">{$lang.admininfo}</strong>
                            <div class="sing-up">
                                {if is_array($fields.contacts.admin)}
                                    {include file="ajax.signup.tpl" submit=$set_contacts.admin fields=$singupfields}
                                {literal}<script type="text/javascript">$('.sing-up:eq(1)').find('input, select, textarea').each(function(){$(this).attr('name', 'contacts[admin]['+$(this).attr('name')+']'); })</script>{/literal}
                            {/if}
                        </div>
                    </div>
                    <div class="clear">
                        <select class="right" onchange="if( $(this).val() == 'new') insert_singupform(this); else $(this).siblings('.sing-up').html('');" name="contacts[tech]">
                            <option value="registrant">{$lang.useregistrant}</option>
                            <option {if is_array($fields.contacts.tech)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                            {if $logged=="1"}
                                {foreach from=$contacts item=contact}
                                    <option {if $set_contacts.tech == $contact.id}selected="selected"{/if} value="{$contact.id}">{if $contact.companyname}{$contact.companyname}{else}{$contact.firstname} {$contact.lastname}{/if}</option>
                                {/foreach}
                            {/if}
                        </select>
                        <strong class="lh28">{$lang.techinfo}</strong>
                        <div class="sing-up">
                            {if is_array($fields.contacts.tech)}
                                {include file="ajax.signup.tpl" submit=$set_contacts.tech fields=$singupfields}
                            {literal}<script type="text/javascript">$('.sing-up:eq(2)').find('input, select, textarea').each(function(){$(this).attr('name', 'contacts[tech]['+$(this).attr('name')+']'); })</script>{/literal}
                        {/if}
                    </div>
                </div>
                <div class="clear">
                    <select class="right" onchange="if( $(this).val() == 'new') insert_singupform(this); else $('.sing-up').html('');" name="contacts[billing]">
                        <option value="registrant">{$lang.useregistrant}</option>
                        <option {if is_array($fields.contacts.billing)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                        {if $logged=="1"}
                            {foreach from=$contacts item=contact}
                                <option {if $set_contacts.billing == $contact.id}selected="selected"{/if} value="{$contact.id}">{$contact.firstname} {$contact.lastname}</option>
                            {/foreach}
                        {/if}
                    </select>
                    <strong class="lh28">{$lang.billinginfo}</strong>
                    <div class="sing-up">
                        {if is_array($fields.contacts.billing)}
                            {include file="ajax.signup.tpl" submit=$set_contacts.billing fields=$singupfields}
                        {literal}<script type="text/javascript">$('.sing-up:eq(3)').find('input, select, textarea').each(function(){$(this).attr('name', 'contacts[billing]['+$(this).attr('name')+']'); })</script>{/literal}
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>
{/if}
</form>
</div>
<a href="#" onclick="$('#cart3').submit(); return false;" class="big-btn clear"> {$lang.continue} &raquo;</a>
{include file='cart_bookshelf/cart.footer.tpl'}