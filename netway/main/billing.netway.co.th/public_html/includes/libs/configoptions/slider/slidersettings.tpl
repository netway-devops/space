Slider will use minimum and maximum value from Validation tab. Note - price (if any) is set per 1 item.<br/>
<div class="clear">
 <label for="text-keyy">Slider step<small>Minimum slider value increase/decrease</small></label>
 <input id="text-keyy" type="text" size="4" name="config[step]" value="{$field.config.step}" />
</div>

<div class="clear">
 <label for="text-keya">Default value<small>Set this initial value if nothing is set yet</small></label>
 <input id="text-keya" type="text" size="4" name="config[initialval]" value="{$field.config.initialval}" />
</div>

<div class="clear">
 <label for="text-keyb">Unit name<small>Name that will display next to form value</small></label>
 <input id="text-keyb" type="text" size="4" name="items[0][name]" value="{$field.items[0].name}" />
</div>

<div class="clear">
 <label for="text-keyx">Don't charge for default <small>With this option on default slider value will be free</small></label>
 <input id="text-keyx" type="checkbox"  name="config[dontchargedefault]" {if $field.config.dontchargedefault}checked="checked"{/if} value="1" />
</div>

<div class="clear">
    <label for="text-keyr">Show steps <small>Show the steps under the slider</small></label>
    <input id="text-keyr" type="checkbox"  name="config[showsteps]" {if $field.config.showsteps}checked="checked"{/if} value="1" />
</div>
