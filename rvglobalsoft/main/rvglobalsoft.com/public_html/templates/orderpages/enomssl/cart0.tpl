<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}enomssl/style.css" />
<script type="text/javascript">
    {literal}
        $(document).ready(function() {

            $("#nitems strong").click(function() {
                $(this).parent().find('input').click();
                return false;
            });

            $('#nitems input').click(function() {
                $('#nitems .nitem').removeClass('niselected');
                $(this).parent().addClass('niselected');
                var id = $(this).val();
                $('.oitem:visible').fadeOut('fast', function() {
                    $('.oitem_' + id).fadeIn('fast');
                });

            });
            $('.ocycles input:first-child').attr('checked', true);

        });
        function submitmform() {
            $('#product_cycle').val($('.ocycles:visible input:checked').val());
            $('#mform').submit();

        }

    {/literal}
</script>





<div id="celeft">
    {include file='enomssl/cprogress.tpl'}

    <h3>{$lang.en_step1}</h3>
    {if $products}

    <div class="table-responsive">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="ntable position-relative stackable enomssl-table">
            <tr>
                <td valign="top" width="33%" style="padding:10px 0px;" id="nitems">
                    <form id="mform" action="" method="post">
                        <input type="hidden" name="do" value="0" />
                        <input type="hidden" name="action" value="add" />
                        <input type="hidden" name="cycle" value="" id="product_cycle" />
                        {foreach from=$products item=i name=floop}
                            <div class="nitem {if $smarty.foreach.floop.first}niselected{/if}">
                                <input type="radio" name="id" value="{$i.id}" {if $smarty.foreach.floop.first}checked="checked"{/if}/> <strong>{$i.name}</strong>
                            </div>
                        {/foreach}
                    </form>

                </td>
                <td valign="top" class="orderbox1" id="orderitems">



                    {foreach from=$products item=i name=floop}      

                        <div class="oitem oitem_{$i.id}" {if $smarty.foreach.floop.first}{else}style="display:none"{/if} >
                            {$i.description}<br />
                        </div>

                    {/foreach}


                </td>
            </tr>
            <tr>
                <td></td>
                <td class="orderbox2">
                    <table width="100%" cellspacing="0">
                        <tr>
                            <td width="70%" class="orderbox3" >
                                {foreach from=$products item=i name=floop}
                                    <div class="oitem oitem_{$i.id} ocycles" {if $smarty.foreach.floop.first}{else}style="display:none"{/if} >
                                        <form id="oform_{$i.id}">
                                            {if $i.paytype=='Free'}
                                                {$lang.free}
                                            {else}
                                                {if $i.p5!=0}<input type="radio" name="cycle" value="p5"/><strong>5 {$lang.years}</strong> - {$i.p5|price:$currency} {if $i.p5_setup!=0} + {$i.p5_setup|price:$currency} {$lang.setupfee}{/if}<br />{/if}
                                                {if $i.p4!=0}<input type="radio" name="cycle" value="p4"/><strong>4 {$lang.years}</strong> - {$i.p4|price:$currency} {if $i.p4_setup!=0} + {$i.p4_setup|price:$currency} {$lang.setupfee}{/if}<br />{/if}
                                                {if $i.t!=0}<input type="radio" name="cycle" value="t"/><strong>3 {$lang.years}</strong> - {$i.t|price:$currency} {if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if}<br />{/if} 
                                                {if $i.b!=0}<input type="radio" name="cycle" value="b"/><strong>2 {$lang.years}</strong> - {$i.b|price:$currency} {if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if}<br />{/if}
                                            {if $i.a!=0}<input type="radio" name="cycle" value="a"/><strong>1 {$lang.years}</strong> - {$i.a|price:$currency} {if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                        {/if}
                                    </form>
                                </div>
                            {/foreach}

                        </td>
                        <td class="csubmit" style="cursor:pointer" onclick="submitmform();
                                return false;">
                            <a href="#" onclick="submitmform();
                                    return false;">{$lang.continue}</a>
                        </td>
                    </tr>
                </table>

            </td>
        </tr>

    </table>
    </div>

{else}
    <center>{$lang.nothing}</center>
    {/if}




</div>


<div class="clear">
</div>

<div style="padding:10px 0px;" class="left enomssl_products">
    <strong>{$lang.browseprod}:</strong>
    {foreach from=$categories item=i name=categories name=cats}
        {if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
        {else} <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id={$i.id}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
        {/if}
    {/foreach}
{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}


</div>

{if count($currencies)>1}
    <div class="right enomssl_currencies" style="padding:5px 0px;">
        <form action="" method="post" id="currform">
            <input name="action" type="hidden" value="changecurr">
            {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                {foreach from=$currencies item=crx}
                    <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                {/foreach}
            </select>
        </form></div>
{/if}<div class="clear">
</div>