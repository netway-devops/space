<select name="css[]" class="inp hardwareicon" onchange="change_css(this)" >
    <option {if $css=='default_1u.png'}selected="selected"{/if} value="default_1u.png">default_1u</option>
    {foreach from=$hardwareimg item=img}
        {if $img!='default_1u.png'}
            <option {if $css==$img}selected="selected"{/if}>{$img}</option>
        {/if}
    {/foreach}
</select> Or
<input type="file" name="files" class="fileupload"/>