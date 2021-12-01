<link href="{$system_url}templates/netwaybysidepad/css/bootstrap.css?v={$hb_version}" rel="stylesheet" media="all" />
<div id="loginbox_container">
    <div class="wbox">
        <br>
        {if !$enable}
        <div align="center">
            <input readonly="readonly" name="2fasecretadmin" class="2fasecretadmin"  value="{$secret}" class="inp"/>
        </div>
        {/if}
        <br>
        <div  class="wbox_content">
            <form name="" action="" method="post">
                <input type="hidden" name="make" value="submit"/>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="center" colspan="2" style="padding-bottom:10px;">
                            <input name="securitycode" value="" class="styled scc"  type="text" style="width:30%; height: 30px;" placeholder="Securitycode"/>
                        </td>
                    </tr>
                    {if $showRememberMe}
                    <tr>
                        <td>
                            <div class="row">
                                <div class="clo-md-12" align="center">
                                    <div class="checkbox" style="width: 170px;">
                                      <label><input type="checkbox" name="2facRemember7days" value="1">Remember me for 30 days. </label>
                                    </div>
                                </div>
                            </div>
                            <br>
                        </td>
                    </tr>
                    {/if}
                    <tr>
                        <td colspan="2" align="center">
                            <button type="submit" value="" class="btn btn-info btn-large" style="font-weight:bold"><i class="icon-ok icon-white"></i>Login</button>
                        </td>
                    </tr>
                </table>{securitytoken}</form>
        </div>
    </div>
</div>
{literal}
<script>
    $('.2fasecretadmin').change(function(){
        $.post( "?cmd=google2factorforadmins", { action: "saveSecret", secretData: $(this).val() },function(data){/*alert(data);*/} );
    });
    
    $('.scc').focus();
    
</script>
{/literal}