<div class="form">
    <input type="radio" style="margin: 0px" name="configs[DefaultNameservers][switch]"
           value="off" {if $option.selected.switch == 'off' || $option.selected.switch == ''}checked{/if}>
    {$lang.settings_nameservers_title1}
    <br>
    <input type="radio" style="margin: 0px" name="configs[DefaultNameservers][switch]"
           value="on" {if $option.selected.switch == 'on'}checked{/if}>
    {$lang.settings_nameservers_title2}
    <br>
    <br>
    <div class="settings-nameservers" {if $option.selected.switch == 'on'} style="display: block;" {else} style="display: none;" {/if}>
        <div class="settings-nameservers-items">
            {foreach item=i from=0|@range:9}
                <input type="text" name="configs[DefaultNameservers][items][{$i}]" value="{$option.selected.items.$i}">
                <br><br>
            {/foreach}
        </div>
    </div>
</div>

{literal}
    <script type="text/javascript">
        $('input[type="radio"][name="configs[DefaultNameservers][switch]"]').change(function () {
            var el = $(this);
            if ($(el).val() == 'on') {
                $('.settings-nameservers').show();
            } else {
                $('.settings-nameservers').hide();
            }
        });
    </script>
{/literal}