
<div class="clear"><label for="text-key">Start date<small>Minimum date available</small></label>
 <input id="text-key" type="text" size="9" name="config[start_date]" value="{if $field.config.start_date}{$field.config.start_date|dateformat:$date_format}{/if}" class="haspicker3" />
</div>
<div class="clear"><label for="text-key">End date<small>Maximum date available</small></label>
 <input id="text-key" type="text" size="9" name="config[end_date]" value="{if $field.config.end_date}{$field.config.end_date|dateformat:$date_format}{else}{/if}" class="haspicker3"  />
</div>
 <script type="text/javascript">
    {literal}
       setTimeout(function(){
         $('.haspicker3').datePicker({
            startDate:'01/01/1900'
        });
             },200);
     {/literal}
 </script>