<label class="nodescr">Allow zones removal</label>
<select  name="config[removal]">
    <option value="0" {if !$widget.config.removal}selected="selected"{/if}>No</option>
    <option value="1" {if $widget.config.removal}selected="selected"{/if}>Yes</option>


</select>
<div class="clear"></div>

<br/>

<div class="clear"></div>
