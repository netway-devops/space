{include file='cart_bookshelf/cart.progress.tpl'}
{include file='cart_bookshelf/cart.summary.tpl'}
<div class="left left-column">
    <div class="line-header clearfix first"><h3>{$lang.mydomains}</h3></div>
    <p>
        <strong>
            {$lang.productconfig1_desc}
        </strong>
    </p>
    <form action="" method="post" onsubmit="return step1.on_submit();" name="domainpicker" id="form1">
        <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
        <input type="hidden" value="{$cart_contents[0].recurring}" id="product_cycle" name="product_cycle" />
        <input type="hidden" name="make" value="checkdomain" />

        {if $allowregister}
            <p>
                <input type="radio" name="domain" value="illregister" onclick="$('#options').find('div.slidme').hide();$('#illregister').show();" checked="checked" id="illregister_input" />
                <label for="illregister_input">{$business_name|string_format:$lang.iwantregister}</label>
            </p>
        {/if} {if $allowtransfer}
            <p>
                <input type="radio" onclick="$('#options').find('div.slidme').hide();$('#illtransfer').show();" value="illtransfer" name="domain"  id="illtransfer_input" />
                <label for="illtransfer_input">{$business_name|string_format:$lang.iwanttransfer}</label>
            </p>
        {/if} {if $allowown}
            <p>
                <input type="radio" onclick="$('#options').find('div.slidme').hide();$('#illupdate').show();" value="illupdate" name="domain" id="illupdate_input" />
                <label for="illupdate_input">{$lang.iwantupdate}</label>
            </p>
        {/if} {if $subdomain}
            <p>
                <input type="radio" onclick="$('#options').find('div.slidme').hide();$('#illsub').show();" value="illsub" name="domain" id="illsub_input"  />
                <label for="illsub_input">{$lang.iwantsub}</label>
            </p>
        {/if}
        <br/>
        <div id="options" class="form-horizontal">

            {if $allowregister}
                <div align="center" id="illregister" class="t1 slidme">
                    <div id="multisearch" class="left" style="margin-top:5px">
                        <textarea name="sld_register" id="sld_register"></textarea>
                    </div>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-left:10px;width:405px;float:left">
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
    <br />
    <form method="post" action="" id="form2">
        <div id="updater">{include file="ajax.checkdomain.tpl"} </div>
    </form>
</div>
<div class="clear">
    <a href="#" class="big-btn" onclick="if($('#form2 input:checked').length>0 && ( $('#illregister_input').is(':checked') ||  $('#illtransfer_input').is(':checked')) ) $('#form2').submit(); else $('#form1').submit(); return false;">{$lang.continue} &raquo;</a>
    {*<input type="submit" value="{$lang.continue}" style="font-size:12px;font-weight:bold" class="padded btn btn-primary"/>*}
</div>
{include file='cart_bookshelf/cart.footer.tpl'}