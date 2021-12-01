{if $action=='passreminder'}
<div id="loginbox_container">
    <div class="wbox">
        <div class="wbox_header">{$lang.didyouforget} <a href="{$ca_url}clientarea/" class="right btn btn-mini"><i class="icon-chevron-left"></i> {$lang.login}</a><div class="clear"></div></div>
        <div  class="wbox_content">
            <div class="alert alert-info">{$lang.forgetintro}</div>

            {if $thanks}


            {else}



            <form name="" action="" method="post" >

                <table border="0" cellpadding="3" cellspacing="0" width="100%">
                    <tr>
                        <td >
                            <label for="email_remind" class="styled">{$lang.forgetenter}</label>
                            <input name="email_remind"  value="{$sub_email}" class="styled"  style="width:96%"/>

                        </td>
                      
                    </tr>
                     <tr>
                        <td >
                            <div class="form-actions">
                                <div class="right">
                                    <input type="submit" value="{$lang.sendmepass}" class="btn btn-info btn-large" />
                                </div>
                                <div class="clear"></div>
                            </div>

                        </td>
                    </tr>


                </table>{securitytoken}</form>
            {/if}
        </div>
    </div>
</div>
{elseif $action=='passreset'}
    <div id="loginbox_container">
        <div class="wbox">
            <div class="wbox_header">{$lang.providenewpassword} <a href="{$ca_url}clientarea/" class="right btn btn-mini"><i class="icon-chevron-left"></i> {$lang.login}</a><div class="clear"></div></div>
            <div  class="wbox_content">
                <form name="" action="" method="post" >
                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                        <tr>
                            <td >
                                <label for="new_password" class="styled">{$lang.newpassword}</label>
                                <input required="required" type="password" name="new_password"  class="styled"  style="width:96%"/>
                            </td>
                        </tr>
                        <tr>
                            <td >
                                <label for="new_password_confirmation" class="styled">{$lang.newpasswordconfirm}</label>
                                <input required="required" type="password" name="new_password_confirmation"  class="styled"  style="width:96%"/>
                            </td>
                        </tr>
                        <tr>
                            <td >
                                <div class="form-actions">
                                    <div class="right">
                                        <input type="submit" value="{$lang.changepass}" class="btn btn-warning" />
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    {if $enableFeatures.logincaptcha =='on'}
                        <div class="form-groups">
                            <label for="captcha">{$lang.captcha}</label>
                            <br>
                            <small>{$lang.typethecharacters}</small>
                            <div class="d-flex flex-row justify-content-start align-items-center">
                                <img class="capcha" style="width: 120px; height: 60px;" onclick="return singup_image_reload();" src="?cmd=root&action=captcha#{$timestamp}" alt="Image" />
                                <input type="text" id="captcha" name="captcha" class="form-control" autocomplete="off" required>
                            </div>
                            {literal}
                                <script>
                                    function singup_image_reload() {
                                        var d = new Date();
                                        $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
                                        return false;
                                    }
                                </script>
                            {/literal}
                        </div>
                    {/if}
                    <input type="hidden" name="activate" value="{$activate}">
                    {securitytoken}
                </form>
            </div>
        </div>
    </div>

{else}
<div id="loginbox_container">
    <div class="wbox">
        <div class="wbox_header">{$lang.restricted}</div>
        <div  class="wbox_content">
            <div class="alert alert-info">{$lang.restrictedarea}</div>

            <form name="" action="" method="post">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" colspan="2" style="padding-bottom:10px;"><label for="username" class="styled">{$lang.email}</label>
                            <input name="username" value="{$submit.username}" class="styled"  type="text" style="width:98%"/>
                        </td>
                    </tr>

                    <tr>

                        <td align="left" colspan="2" style="padding-bottom:10px;"><label for="password"  class="styled">{$lang.password}</label>
                            <input name="password" type="password" autocomplete="off" class="styled"  style="width:98%"/>
                        </td>
                    </tr>
                    {if $enableFeatures.logincaptcha =='on'}
                   <tr>   
                        <td align="left" colspan="2">
                            
                            <label for="captcha" class="styled">{$lang.captcha}</label>
                            <input name="captcha" type="text" class="styled" autocomplete="off" style="width:98%"/>
                             <div style="white-space: nowrap; padding-top: 5px;">
                                 <span style="display: inline-block; width: 65%; white-space: normal;float:right">
                                     <small>{$lang.typethecharacters}<br /></small>
                                      <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                                 </span>
                                 <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" /> 
                             </div>
                        </td>
                  </tr>
                  {/if}

                    <tr>
                        <td colspan="2">
                            <div class="form-actions">
                                <div class="left"  >
                                    <a href="{$ca_url}root&amp;action=passreminder" class="list_item">{$lang.passreminder}</a><br />
                                    <a href="{$ca_url}signup/" class="list_item">{$lang.createaccount}</a>
                                </div>
                                <div class="right">
                                    <input type="hidden" name="action" value="login"/>
                                    <button type="submit" value="" class="btn btn-info btn-large" style="font-weight:bold"><i class="icon-ok icon-white"></i> {$lang.login}</button>
                                </div>
                                <div class="clear"></div>
                            </div>

                        </td>
                    </tr>



                </table>{securitytoken}</form>
        </div>
    </div>
</div>
{literal}
    <script>
       
        function singup_image_reload(){
            var d = new Date();    
            $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
            return false;
        }
    </script>

{/literal}

{/if}