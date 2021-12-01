<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{if $vpsdo=='editvm'}{$lang.scalevm}{else}{$lang.autoscaling}{/if}</h3>
 {if $service.options.option19=='Yes'}
    <ul class="sub-ul">
        <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=editvm&vpsid={$vpsid}" class="{if $vpsdo=='editvm'}active{/if}" ><span>{$lang.scale}</span></a></li>
        <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=autoscaling&vpsid={$vpsid}" class="{if $vpsdo=='autoscaling'}active{/if}" ><span>{$lang.autoscaling}</span></a></li>
    </ul>
 {/if}
    <div class="clear"></div>
</div>
<div class="content-bar nopadding" style="position:relative">


    <form method="post" action="">
        <input type="hidden" value="editmachine" name="make" />
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">



            <tr>
                 <td colspan="2"><span class="slabel">New Flavor</span><select style="min-width:350px;" required="required" name="CreateVM[flavor_id]" id="virtual_machine_flavor_id"  >

                    {foreach from=$flavors item=flavor}
                    <option value="{$flavor[0]}" {if $VMDetails.flavor==$flavor[0]}selected="selected"{/if}>{$flavor[1]}</option>
                   {/foreach}

                </select></td>

            </tr>


            <tr>
                <td align="center" style="border:none" colspan="2">
                    <input type="submit" value="Resize instance" class="blue"/>
                </td>
            </tr>
        </table>
   {securitytoken} </form>



</div>