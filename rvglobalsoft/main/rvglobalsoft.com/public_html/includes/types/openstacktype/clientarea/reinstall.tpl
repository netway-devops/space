<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">Rebuild</h3>

    <div class="clear"></div>
</div>
<div class="content-bar nopadding">
    <div style="padding:0px 15px 15px">
        <h3><br />{$lang.ReinstallVPS}<br/></h3>
        {$lang.choose_template1} <font color="#cc0000">{$lang.choose_template2}</font>
    </div>
    {if $ostemplates}
    

        <form action="" method="post">
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">


            
                <tr>
                    <td colspan="2"><span class="slabel">Image</span>
                        <select style="min-width:250px;" required="required" name="os" id="virtual_machine_template_id" onchange="swapcheck($(this).val())" >

                            {foreach from=$ostemplates item=templa}
                            <option value="{$templa[0]}"  {if $VMDetails.images==$templa[0]}selected="selected"{/if}>{$templa[1]} {if $templa[2] && $templa[2]>0}( {$templa[2]|price:$currency} ){/if}</option>
                           {/foreach}


                        </select></td></tr>
                <tr><td colspan="2" align="center" style="border-bottom:none"> <input type="submit" value="{$lang.ReinstallVPS}" name="changeos" class="blue" /></td></tr>

            </table>
        {securitytoken}</form>
    {else}
    <div style="color: red; text-align: center; width:850px"><strong>{$lang.ostemplates_error}</strong></div>
    {/if}
</div>