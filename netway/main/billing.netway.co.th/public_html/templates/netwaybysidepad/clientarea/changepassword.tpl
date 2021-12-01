

<div class="text-block clear clearfix">
    <h5>{$lang.account}</h5>
   
    <div class="clear clearfix">
        <div class="account-box">
        
			{include file='clientarea/leftnavigation.tpl'}
            
            <div class="account-content">
            <div class="content-padding">
                <h6>
                {if $clientdata.contact_id}
        			{$lang.changemainpass}
        		{else}
        			{$lang.changepass}
        		{/if}
                </h6>
                
                <form class="form-horizontal password-change" action='' method='post' >
                    <input type="hidden" name="make" value="changepassword" />
                    <div class="control-group">
                        <label class="control-label">{$lang.oldpass}:</label>
                        <div class="controls">
                            <input class="span3" type="password" name="oldpassword">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">{$lang.newpassword}:</label>
                        <div class="controls">
                            <input class="span3" type="password" name="password">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">{$lang.confirmpassword}:</label>
                        <div class="controls">
                            <input class="span3" type="password" name="password2">
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <button type="submit" class="clearstyle green-custom-btn btn l-btn">{$lang.savechanges}</button>
                    </div>
                    {securitytoken}
                </form>
                
            </div>

        </div>
        
        
    </div>
 </div>
 </div>