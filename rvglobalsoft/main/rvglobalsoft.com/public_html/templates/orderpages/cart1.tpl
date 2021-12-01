<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
<p>
    {$lang.productconfig1_desc}
</p>

<script type="text/javascript">
    {literal}
        function on_submit() {
            var data = {
                    layer: 'ajax', 
                    product_id: $('#product_id').val(),
                    product_cycle: $('#product_cycle').val()
                };
                
            if ($("input[value='illregister']").is(':checked')) {
                //own
                data.sld = $('#sld_register').val();
                data.tld = $('.tld_register:visible').serializeArray().map(function(a){return a.value;});
                ajax_update('?cmd=checkdomain&action=checkdomain', data, '#updater', true);
            } else if ($("input[value='illtransfer']").is(':checked')) {
                //transfer
                data.sld = $('#sld_transfer').val();
                data.tld = $('#tld_transfer').val();
                ajax_update('?cmd=checkdomain&action=checkdomain&transfer=true', data, '#updater', true);
            } else if ($("input[value='illupdate']").is(':checked') || $("input[value='illsub']").is(':checked')) {

                return true;
            }

            return false;
        }
    {/literal}
</script>
<div class="default-cart">
    <form action="" method="post" onsubmit="return on_submit();" name="domainpicker">
        <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
        <input type="hidden" value="{$cart_contents[0].recurring}" id="product_cycle" name="product_cycle" />
        <input type="hidden" name="make" value="checkdomain" />

        {if $allowregister}
            <p class="domain-action domain-action-register">
                <input type="radio" name="domain" value="illregister" onclick="$('#options').find('div.slidme').hide();
                        $('#illregister').show();" checked="checked" id="illregister_input" />
                <label for="illregister_input">{$business_name|string_format:$lang.iwantregister}</label>
            </p>
        {/if} {if $allowtransfer}
            <p class="domain-action domain-action-transfer">
                <input type="radio" onclick="$('#options').find('div.slidme').hide();
                        $('#illtransfer').show();" value="illtransfer" name="domain"  id="illtransfer_input" />
                <label for="illtransfer_input">{$business_name|string_format:$lang.iwanttransfer}</label>
            </p>
        {/if} {if $allowown}
            <p class="domain-action domain-action-own">
                <input type="radio" onclick="$('#options').find('div.slidme').hide();
                        $('#illupdate').show();" value="illupdate" name="domain" id="illupdate_input" />
                <label for="illupdate_input">{$lang.iwantupdate}</label>
            </p>
        {/if} {if $subdomain}
            <p class="domain-action domain-action-sub">
                <input type="radio" onclick="$('#options').find('div.slidme').hide();
                        $('#illsub').show();" value="illsub" name="domain" id="illsub_input"  />
                <label for="illsub_input">{$lang.iwantsub}</label>
            </p>
        {/if}
        <br/>
        <div id="options" class="form-horizontal">

            {if $allowregister}
                <div  id="illregister" class="t1 slidme">
                    <div class="domain-inputbox">
                        <div id="multisearch" class="left domain-input-bulk domain-input">
                            <textarea name="sld_register" id="sld_register"></textarea>
                        </div>
                        <div class="domain-tld-bulk domain-tld-multiselect" style="display: none;">
                            <select  name="tld[]" class="tld_register" multiple>
                                {foreach from=$tld_reg item=tldname name=ttld}
                                    <option value="{$tldname}" {if $smarty.foreach.ttld.first}selected{/if} >{$tldname}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="domain-tld-bulk domain-tld-checkbox" >
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                                <tr>
                                    {foreach from=$tld_reg item=tldname name=ttld}
                                        {if $smarty.foreach.ttld.index && $smarty.foreach.ttld.index % 4 == 0}</tr><tr>{/if}
                                        <td width="25%">
                                            <input type="checkbox" name="tld[]" value="{$tldname}" 
                                                   {if $smarty.foreach.ttld.first}checked="checked"{/if} 
                                                   class="tld_register"/> {$tldname}
                                        </td>
                                        
                                    {/foreach}
                                </tr>
                            </table>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            {/if}
            {if $allowtransfer}
                <div  id="illtransfer" style="display: none;" class="slidme form-horizontal">
                    <div class="domain-inputbox">
                        www.
                        <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled span3"/>
                        <select name="tld_transfer" id="tld_transfer" class="span2">
                            {foreach from=$tld_tran item=tldname}
                                <option>{$tldname}</option> 	
                            {/foreach}
                        </select>
                    </div>
                </div>
            {/if}
            {if $allowown}
                <div  id="illupdate" style="display: none;" class="slidme form-horizontal">
                    <div class="domain-inputbox">
                        www.
                        <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled span3"/>
                        .
                        <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span1"/>
                    </div>
                </div>
            {/if}
            {if $subdomain}
                <div  id="illsub" style="display: none;" class="slidme form-horizontal">
                    <div class="domain-inputbox">
                        www.
                        <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled span3"/>
                        {$subdomain}
                    </div>
                </div>
            {/if}
        </div>

        <div class="domain-submit">
            <input type="submit" value="{$lang.continue}" class="padded btn btn-primary"/>
        </div>
    </form>

    <form method="post" action="">
        <div id="updater">
            {include file="ajax.checkdomain.tpl"} 
        </div>
    </form>
</div>
