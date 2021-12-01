<div class="clear">
 <label for="check-required">Add empty option<small>When enabled select will have default-preselected empty option, rather than first available in Items</small></label>
 <input id="def-text-key" type="checkbox" name="config[addemptyoption]" value="1" {if $field.config.addemptyoption}checked="checked"{/if}/>
</div>
{if $field.config.addemptyoption}
{literal}
 <script>
     $(function () {
         $('#customitemseditor > li:nth-child(1) > .form-option-config').children().each(function () {
             $(this).hide();
         });
     });
 </script>
{/literal}
{/if}