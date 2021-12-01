<div id="Flavor_b" {if $product.paytype!='Flavor'}style="display:none"{/if} class="p5 boption">

    <div id="Flavormgr">
        <div style="">
            {if $product.flav_inactive}
                <div style="padding:10px;color:red">
                    <b>This billing model requires Cloud Flavor Manager module to be active</b>
                </div>
            {/if}

            <div style="padding:10px">
                <b>
                    Client account total will be updated hourly or daily depending on used hosting module,
                    with prices set trough <a href='?cmd=flavormanager' target='_blank'>Cloud Flavor Manager</a>
                </b>
            </div>

            <div class="clear"></div>
            <table width="100%" cellspacing="0" cellpadding="6" border="0">
                {foreach from=$billingoptions.flavor.options item=flvopt key=flvkey}
                    <tr id="flavor_{$flvkey}"
                        {if $flvopt.ShowWhen}data-show="{$flvopt.ShowWhen|@json_encode|escape}"{/if}>
                        <td width="160">
                            {$flvopt.title}
                            {if $flvopt.tooltip}
                                <span class="vtip_description">
                                    <span>{$flvopt.tooltip}</span>
                                </span>
                            {/if}
                        </td>
                        <td>
                            {if $flvopt.type === 'select'}
                                <select name="config[{$flvkey}]" class="inp">
                                    {foreach from=$flvopt.items item=opt key=optkey}
                                        <option value="{$opt.value}"
                                                {if $configuration[$flvkey] == $opt.value}selected{/if}
                                        >{$opt.title}</option>
                                    {/foreach}
                                </select>
                            {elseif $flvopt.type === 'currency'}
                                {$currency.sign}
                                <input type="text" class="inp" size="6" name="config[{$flvkey}]"
                                       value="{$configuration[$flvkey]|default:0|price:$currency:false}"/>
                                {$currency.code}
                            {/if}
                        </td>
                        <td style="background:#F0F0F3" class="fs11">
                            {$flvopt.description}
                        </td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
</div>
{literal}
    <script type="text/javascript">
        $(function () {
            var root = $('#Flavormgr');

            $('[data-show]', root).each(function () {
                var self = $(this),
                    name = self.attr('id'),
                    depends_on = $();

                $.each(self.data('show'), function (key, value) {
                    var opt = $('[name="config[' + key + ']"]');
                    if (opt.length) {
                        opt.data(name, value);
                        depends_on = depends_on.add(opt);
                    }
                });

                if (!depends_on.length) {
                    return;
                }

                depends_on.on('init change', function () {
                    var state = true;
                    depends_on.each(function () {
                        var self = $(this);
                        state = state && (self.val() === self.data(name));
                    });
                    self.toggle(state);
                }).trigger('init')
            });
        })
    </script>
{/literal}