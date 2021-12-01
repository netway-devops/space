<label class="nodescr">Days since registration</label>
<input type="text" class="w250" name="config[days]" value="{$widget.config.days}" style="width:450px" id="days"/>
<div class="clear"></div>
<hr>
<p>Note: EPP code will be available for customer this many days since domain registration.</p>
<div class="clear"></div>
<div class="checkbox">
    <label>
        <input type="checkbox" name="config[send_epp]" value="1" {if $widget.config.send_epp}checked{/if}>
        Send EPP code to registrars email rather than displaying it on screen
    </label>
</div>
<div class="clear"></div>
<hr>
<b>Show/send EPP code</b>
<div class="checkbox">
    <input type="radio" name="config[show_send_epp]" value="1" {if $widget.config.show_send_epp == '1' || !$widget.config.show_send_epp}checked{/if}>
    Whenever requested
    <br>
    <input type="radio" name="config[show_send_epp]" value="2" {if $widget.config.show_send_epp == '2'}checked{/if}>
    Only to clients without unpaid invoices for related domain
    <br>
    <input type="radio" name="config[show_send_epp]" value="3" {if $widget.config.show_send_epp == '3'}checked{/if}>
    Only to clients without any unpaid invoice
    <br>
</div>