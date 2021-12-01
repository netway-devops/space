{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'verifyrvlicense.tpl.php');
{/php}


<div align="center" style="padding-top:30px;" class="container">
 <!--  -----------------------------------------------------------------------------------------View search------------------------------------------------------------------------- -->
    <form action="{$system_url}" name="searchIP" method="get">
    <br>
    <div class="row-fluid">
        <div class="span1"></div>
        <div class="span10"> 
         <div class="validate-border">
             <table border="0" cellpadding="10" cellspacing="0" align="center" class="validate">
                <tr>
                    <td align="left" valign="middle" class="desktop-menu"><img src="{$template_dir}images/icon-validate.jpg" alt="validate" width="162" height="204" align="absmiddle" /></td>
                    <td align="left" valign="middle" class="padd">
                    <input type="hidden" name="cmd" value="verifyrvlicense" >
                    <h3><span>Validate IP: &nbsp;</span><input name="ip" type="text" size="20" class="bdrbox" value="{$ip}" />
                    <input type="submit"  class="btn-primary" value="Verify" /></h3>
                    
                    {if $error}
                    
                            <div style="background: #f9dcdc; color: #dc3b3b; height: auto; padding:10px 23px;">
                                {$error}
                            </div>  
                    {/if}
                
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="span1"></div>
</div>
</form> 


 
<div class="row-fluid">
    <div class="span1"></div>
    <div class="span12">
                    {if $dataskin}
                    
                         <div class="span6" style="text-align: left ;border: 1px solid rgba(0, 0, 0, 0.15);-webkit-border-radius: 4px;-moz-border-radius: 4px;border-radius: 4px;min-height: 345px;vertical-align: center; padding: 10px;padding-left: 20px;padding-top: 50px;">
                            {foreach from=$dataskin key=k item=p}
                            
                                 <div class="span12">{if $k==0}<h3>RVSkin</h3>{else}<hr>{/if}</div>
                                    {if $p.accid}<div class="span3"><b>Account id:</b></div><div class="span8">{$p.accid}</div>{/if}
                                    <div class="span3"><b>IP Address:</b></div><div class="span8">{if $p.mip}{$p.mip}{if $p.mip ne $p.sip and $p.sip}({$p.sip}){/if}{/if}</div>
                                    <div class="span3"><b>License Type:</b></div><div class="span8">{if $p.proname}{$p.proname}{/if}</div>
                                    <div class="span3"><b>Status:</b></div><div class="span8">{if $p.status eq 'yes'}Active{elseif $p.status eq 'no'}{if $p.cid ne 9}Suspended{else}Subscription expired{/if}{else}{$p.status}{/if}</div>
                                    
                                    {if $p.cid != 8 }
                                    <div class="span3"><b>{if $p.cid == 9}Subscription {/if}Expiration Date:</b></div><div class="span8">{if $p.cid ne 9}{$p.expdate}{else}{$p.duedate}{/if}(GMT+0)<br><br></div>
                                    {if $p.email}<div class="span3"><b>Email:</b></div><div class="span8">{$p.email}</div>{/if}
                                    {/if}
                                    
                            {/foreach}
                        </div>
                    {/if}
                   
                    {if $nodataskin}
                        <div class="span6" style="text-align: left ;border: 1px solid rgba(0, 0, 0, 0.15);-webkit-border-radius: 4px;-moz-border-radius: 4px;border-radius: 4px;min-height: 345px;vertical-align: center; padding: 10px;padding-left: 20px;padding-top: 50px;">

                            <div class="span12"><h3>RVSkin</h3></div>
                            <div class="span12">{$nodataskin}</div>
                        </div>
                    {/if}  
                
                    {if $datasite}
                         <div class="span6" style="text-align: left ;border: 1px solid rgba(0, 0, 0, 0.15);-webkit-border-radius: 4px;-moz-border-radius: 4px;border-radius: 4px;min-height: 345px;vertical-align: center; padding: 10px;padding-left: 20px;padding-top: 50px;">  

                            {foreach from=$datasite key=k item=p}
                            
                    
                                
                                <div class="span12">{if $k==0}<h3>RVSitebuilder</h3>{else}<hr>{/if}</div>
                                
                                    {if $p.accid}
                                        <div class="span3"><b>Account id:</b></div><div class="span8">{if $p.accid}{$p.accid}{/if}</div>

                                    {/if}
                                        <div class="span3"><b>IP Address:</b></div><div class="span8">{if $p.mip}{$p.mip}{if $p.mip ne $p.sip and $p.sip}({$p.sip}){/if}{/if}</div>
                                        <div class="span3"><b>License Type:</b></div><div class="span8">{if $p.proname}{$p.proname}{/if}</div>
                                        <div class="span3"><b>Status:</b></div><div class="span8">{if $p.status eq '1'}Active{elseif $p.status eq '0'}Suspended{else}{$p.status} {/if}</div>
                                    {if $p.cid != 8 }
                                        <div class="span3"><b>Expiration Date:</b></div><div class="span8">{if $p.expdate}{$p.expdate} (GMT+0){/if} &nbsp;</div>
                                    {if $p.email}
                                         <div class="span3"><b>Email:</b></div><div class="span8">{$p.email}</div>
                                    {/if}
                                 {/if}
                          
                            
                            {/foreach}
                        </div>
                    {/if}
                    {if $nodatasite}
                        <div class="span6" style="text-align: left ;border: 1px solid rgba(0, 0, 0, 0.15);-webkit-border-radius: 4px;-moz-border-radius: 4px;border-radius: 4px;min-height: 345px;vertical-align: center; padding: 10px;padding-left: 20px;padding-top: 50px;">  
                   
                            <div class="span12"><h3>RVSitebuilder</h3></div>
                            <div class="span12">{$nodatasite}</div>
                        </div>
                    {/if}
                  
        </div>
    </div>
    <div class="span1"></div>
</div>

</div>