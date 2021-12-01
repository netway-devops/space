<label class="nodescr">Days since registration</label>
<input type="text" class="w250" name="config[days]" value="{$widget.config.days}" style="width:450px" id="days"/>
<div class="clear"></div>

<br/>
<p>Note: EPP code will be available for customer this many days since domain registration.</p><br/>
<div class="clear"></div>
<div class="checkbox">
    <label>
        <input type="checkbox" name="config[send_epp]" value="1" {if $widget.config.send_epp}checked{/if}>
        Send EPP code to registrars email rather than displaying it on screen
    </label>
</div>
<div class="clear"></div>

