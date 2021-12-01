
<h3>{$lang.cert_san_title}</h3>
<p>{$lang.cert_san_descr} </p>

<div id="san" class="form-horizontal">
    {foreach from=$san.names item=host key=key}
        <div class="san-host form-group  {if $san.config.requirelimit}required{/if}">
            <label>
                {if $host.free && $san.freeoptions}
                    <select name="san[]" class="san-free">
                        {foreach from=$san.freeoptions item=fname}
                            <option value="{$fname}" {if $host.name==$fname}selected{/if}>{$fname}</option>
                        {/foreach}
                    </select>
                {else}
                    <input name="san[]" type="text" value="{$host.name}" {if $host.free}readonly{/if} placeholder="mail.exemple.com" {if $san.config.requirelimit}required{/if}>
                {/if}
                {$lang.san_item} {$key+1}
                {if $host.free}({$lang.free}){/if}
            </label>
        </div>
    {/foreach}
</div>
{literal}
    <script>
        $(function () {
            var sanfree = $('.san-free'),
                sanvals = {};

            sanfree.on('change', function () {
                var self = $(this),
                    value = self.val(),
                    prev = self.data('prev-val');

                if (sanvals[value]) {
                    console.log(value, sanvals[value]);
                    $(sanvals[value]).val(prev);
                    sanvals[prev] = sanvals[value];
                }
                sanvals[value] = this;
                self.data('prev-val', value);
            }).each(function () {
                var self = $(this),
                    value = self.val();
                sanvals[value] = this;
                self.data('prev-val', value);
            });
        })
    </script>
{/literal}
