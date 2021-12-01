<p>
    Each name that is not defined in "Free domains" will add additional charges as defined in pricing tab.
</p>
<div class="clear"></div>
<div id="san-settings">
    <label>
        Maximum number
        <small>of additional names</small>
    </label>
    <input name="config[maxvalue]" value="{$field.config.maxvalue}" id="configMaxvalue" class="styled">

    <div class="clear"></div>
    
    <label>
        Default value
        <small> Initial list of subdomains</small>
    </label>
    <textarea id="sub-initialval" data-field="#hid-initialval" 
              style="width: 400px; height: 50px;">{$field.config.initialval|replace:'.$cn':''|escape}</textarea>

    <div class="clear"></div>
    <label>
        Free subdomains
        <small> List of subdomains that won't be charged</small>
    </label>
    <textarea id="sub-freenames" data-field="#hid-freenames" 
              style="width: 400px; height: 50px;">{$field.config.freenames|replace:'.$cn':''|escape}</textarea>
</div>

<input type="hidden" name="config[initialval]" id="hid-initialval" class="textareanames" value="{$field.config.initialval|escape}" />
<input type="hidden" name="config[freenames]" id="hid-freenames"  class="textareanames" value="{$field.config.freenames|escape}"/>
{literal}
    <script>
        $(function () {
            $('#san-settings textarea').on('input blur', function (e) {
                var self = $(this),
                    form = $(self.data('field')),
                    val = self.val().split(/[\s,;:]+/).filter(function (x) {
                    return x.length > 0
                }),
                    sparator = val.length > 1 ? self.val().match(/[\s,;:]+/)[0] : "\n";

                form.val(val.join(".$cn" + sparator) + (val.length > 0 ? ".$cn" : ''))
                if (e.type == 'blur')
                    self.val(val.join(sparator))

                if (self.is('#sub-initialval')) {
                    $('#configMaxvalue').val() < val.length && $('#configMaxvalue').val(val.length);
                }
            }).trigger('blur');

            $('#configMaxvalue').on('change', function () {
                $('#sub-initialval').trigger('blur');
            })
        })
    </script>
{/literal}