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