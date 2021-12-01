 <br><label class="nodescr">Item</label>
    <select class="chosen w250 form-control" name="p_ientity" id="p_ientity">
        {foreach from=$entities item=m}
            <option value="{$m.id}">#{$m.id} SN: {$m.sn} BY: {$m.manufacturer}</option>
        {/foreach}
    </select>
 {literal}
 <script>
     for (var property in items) {
         if (items.hasOwnProperty(property)) {
             $('option[value='+property+']','#p_ientity').attr('disabled','disabled');
         }
     }
     $('.chosen').chosen();
 </script>
 {/literal}