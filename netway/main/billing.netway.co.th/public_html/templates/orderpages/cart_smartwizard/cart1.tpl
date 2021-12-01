
{include file="cart_smartwizard/header.tpl"}
{include file="cart_smartwizard/cart.summary.tpl"}

<!-- Left Column -->
<div class="left-column left">
    <div class="cart-container-sw">

        <div id="t-settings">
            <div class="option-row center">
                <div class="option-box left">
                    <h4 class="openSansBold left">{$lang.mydomains}</h4>
                </div>

                <div class="domain-box clear" style="display:block">
                    <form action="" method="post" onsubmit="return step1.on_submit();" name="domainpicker" id="form1">
                        <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
                        <input type="hidden" value="{$cart_contents[0].recurring}" id="product_cycle" name="product_cycle" />
                        <input type="hidden" name="make" value="checkdomain" />
                        
                        <div id="options" class="domain-option">
                            <p class="openSansBold">{$lang.productconfig1_desc}</p>
                            <ul class="openSansRegular">
                                {if $allowregister}<li><input type="radio" name="domain" value="illregister" onclick="$('#add-domain').find('div.slidme').hide();$('#illregister').show();" checked="checked" id="illregister_input" />{$business_name|string_format:$lang.iwantregister}</li>
                                    {/if}
                                    {if $allowtransfer}<li><input type="radio" onclick="$('#add-domain').find('div.slidme').hide();$('#illtransfer').show();" value="illtransfer" name="domain"  id="illtransfer_input" />{$business_name|string_format:$lang.iwanttransfer}</li>
                                    {/if}
                                    {if $allowown}<li><input type="radio" onclick="$('#add-domain').find('div.slidme').hide();$('#illupdate').show();" value="illupdate" name="domain" id="illupdate_input" />{$lang.iwantupdate}</li>
                                    {/if}
                                    {if $subdomain}<li><input type="radio" onclick="$('#add-domain').find('div.slidme').hide();$('#illsub').show();" value="illsub" name="domain" id="illsub_input"  />{$lang.iwantsub}</li>
                                    {/if}
                            </ul>
                        </div>

                        <div id="add-domain" class="domain-option domain-option-nobg form-horizontal">
                            {if $allowregister}
                                <div align="center" id="illregister" class="t1 slidme">
                                    <div id="multisearch" class="left" style="margin-top:5px">
                                        <textarea name="sld_register" id="sld_register"></textarea>
                                    </div>
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-left:10px;width:400px;float:left">
                                        {foreach from=$tld_reg item=tldname name=ttld}
                                            {if $smarty.foreach.ttld.index % 4 =='0'}<tr>
                                                {/if}
                                                <td width="25%"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> {$tldname}</td>
                                                {if $smarty.foreach.ttld.index % 4 =='5'}</tr>
                                                {/if}
                                            {/foreach}
                                        <tr>
                                        </tr>
                                    </table>
                                    <div class="clear"></div>
                                    <div class="add-new-button">
                                        <a href="#" class="openSansBold text-center" onclick="if($('#form2 input:checked').length>0 && ( $('#illregister_input').is(':checked') ||  $('#illtransfer_input').is(':checked')) ) $('#form2').submit(); else $('#form1').submit(); return false;">{$lang.check}</a>
                                    </div>
                                </div>
                            {/if}
                            {if $allowtransfer}
                                <div align="center" id="illtransfer" style="display: none;" class="slidme">www.
                                    <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled span3"/>
                                    <select name="tld_transfer" id="tld_transfer" class="span2">
                                        {foreach from=$tld_tran item=tldname}
                                            <option>{$tldname}</option> 	
                                        {/foreach}
                                    </select>
                                </div>
                            {/if}
                            {if $allowown}
                                <div align="center" id="illupdate" style="display: none;" class="slidme">www.
                                    <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled span3"/>
                                    .
                                    <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span1"/>
                                </div>
                            {/if}
                            {if $subdomain}
                                <div align="center" id="illsub" style="display: none;" class="slidme">www.
                                    <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled span3"/>
                                    {$subdomain}
                                </div>
                            {/if}

                        </div>
                    </form>
                    <form method="post" action="" id="form2">
                        <div id="updater">{include file="ajax.checkdomain.tpl"} </div>
                    </form>
                    <div class="domain-hidden">
                        <div class="domain-option">
                            <p class="openSansBold">{$lang.productconfig2}:</p>
                            <div class="domain-row domain-row-hidden">
                                <p class="openSansSemiBold"></p>
                                <a href="#" class="openSansSemiBold">[{$lang.delete}]</a>
                                <div class="domain-input openSansSemiBold">
                                    <select>
                                        <option>1 Year/400 USD</option>
                                        <option>2 Year/600 USD</option>
                                    </select>
                                </div>
                                <input type="checkbox"> <span class="openSansSemiBold">ID Protection</span>
                            </div>

                        </div>

                        <div class="domain-option">
                            <p class="openSansBold">Edit configuration:</p>
                            <span class="question-mark"></span>
                            <span class="edit-domain openSansSemiBold">Set nameservers</span>
                            <a href="#" class="edit-nameservers openSansBold">I want to use my nameservers</a>
                        </div>

                        <div class="domain-option">
                            <p class="openSansBold">Domain contacts:</p>
                            <span class="domain-contact openSansSemiBold"><input type="checkbox"> Use main contact details I’ll provide during checkout </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end -->
    </div>

    <div class="pagination-box">
        {include file='cart_smartwizard/pagination.tpl'}

        <div class="pagination-right-button right" onclick="if($('#form2 input:checked').length>0 && ( $('#illregister_input').is(':checked') ||  $('#illtransfer_input').is(':checked')) ) $('#form2').submit(); else $('#form1').submit(); return false;">
            <span class="pag-arrow"></span>
            <span class="openSansBold" >Next</span>
        </div>
    </div>

</div>

<div class="clear"></div>