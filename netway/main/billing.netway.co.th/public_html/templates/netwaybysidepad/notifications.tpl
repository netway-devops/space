<div id="infos">
<div class="notifications alert alert-info" {if $info}style="display:block"{/if}>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    {if $info}
        {foreach from=$info item=infos}
        	<span>{$infos}</span>
        	
        {/foreach}
    {/if}
</div>
</div>

<div id="errors">
<div class="notifications alert alert-error" {if $error}style="display:block"{/if}>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    {if $error}
        {foreach from=$error item=blad}
        	<span>{$blad}</span>
        {/foreach}
    {/if}
</div>
</div>
<script language="javascript">
{literal}
$(document).ready( function () {
    if($('#infos').children().children('span').text() == 'Password confirmation was sent to the email you have provided, please check your mailbox.'){
        var height = $('.content-wrapper').height();
         console.log(height);
        $('.content-wrapper').hide();
        $('#infos').css('margin-bottom',height);
        
    }
    else if($('#infos').children().children('span').text() == 'Your new password was sent to the email you provided. Please check your mailbox.'){
        var height = $('.content-wrapper').height();
       
        $('.content-wrapper').hide();
        $('#infos').css('margin-bottom',height);
    }
});
{/literal}
</script>