{foreach from=$cf.items item=cit}
    <div class="control-group">
        <input type="hidden" name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]" value="{$contents[1][$cf.id][$cit.id].val}" />
        <textarea id="custom_field_{$cf.id}"  class="styled custom_field custom-san" style="width:99%; min-height: 100px; resize: vertical" 
                  data-max="{$cf.config.maxvalue}"
                  onchange="$(document).trigger('hbcart.changeform', [this]);
                          if (typeof (simulateCart) == 'function')
                              simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"
                  ></textarea> 
        <div class="help-block">You can enter up to {$cf.config.maxvalue} additional names</div>
    </div>
{/foreach}
{once}
{literal}
    <script>
        $(function () {
            function validateDomain(value) {
                if (value.length < 1
                    || value.length > 253
                    || value.split('.').length < 2
                    || !value.match(/^([a-z\d](-*[a-z\d])*)(\.([a-z\d](-*[a-z\d])*))*$/)
                    || !value.match(/^[^\.]{1,63}(\.[^\.]{1,63})*$/)) {
                    return false;
                }
                return true;
            }
            $('.custom-san').on('input change init', function (e) {
                var self = $(this),
                    input = self.prev(),
                    max = self.data('max'),
                    names, separator;

                if (e.type == 'init') {
                    var data = input.val().length ? JSON.parse(input.val()) : [];
                    names = [];
                    separator = "\n";
                    for(var i in data)
                        names.push(data[i].name);
                } else {
                    names = self.val().split(/[\s;,]+/).filter(function (a, index, self) {
                        return a.length !== 0 && self.indexOf(a) === index;
                    });
                    separator = self.val().match(/[\s;,]+/);
                    separator = separator && separator[0] || "\n";
                }

                if (e.type == 'change' || e.type == 'init') {
                    self.val(names.slice(0, max).join(separator)).trigger('input')
                } else if (names.length > max) {
                    self.parent().addClass('error');
                } else {
                    self.parent().removeClass('error');
                }

                input.val(JSON.stringify(names.map(function (a) {
                    return {name: a}
                })));
            }).trigger('init')
        })
    </script>
{/literal}
{/once}