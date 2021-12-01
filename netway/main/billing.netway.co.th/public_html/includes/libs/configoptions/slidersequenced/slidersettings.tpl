Slider will use minimum and maximum value from Validation tab. Note - price (if any) is set per 1 item.<br/>
<div class="clear">
 <label for="text-keyy">Slider steps<small>Enter steps separated by a comma. Example: 1,2,4,8,16</small></label>
    <textarea id="text-keyy" cols="70" name="config[steps]">{$field.config.steps}</textarea>
</div>

<div class="clear">
 <label for="text-keya">Default value<small>Set this initial value if nothing is set yet</small></label>
 <input id="text-keya" type="text" size="4" name="config[initialval]" value="{$field.config.initialval}" />
</div>

<div class="clear">
 <label for="text-keyx">Don't charge for default <small>With this option on default slider value will be free</small></label>
 <input id="text-keyx" type="checkbox"  name="config[dontchargedefault]" {if $field.config.dontchargedefault}checked="checked"{/if} value="1" />
</div>

<div class="clear">
 <label for="text-keyb">Show steps <small>Show the steps under the slider</small></label>
 <input id="text-keyb" type="checkbox"  name="config[showsteps]" {if $field.config.showsteps}checked="checked"{/if} value="1" />
</div>
