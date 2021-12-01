<tr {if $configuration.EnableProRata == 'off'}style="display:none"{/if} id="prorated_ctrl">

    <td align="right"><strong>{$lang.new_EnableProRata}</strong></td>
    <td>
        <input type="radio" {if $configuration.EnableProRata == 'off'}checked{/if}
               name="config[EnableProRata]" value="off" onclick="$('#prorated').hide();"
               id="prorata_off"/>
        <label for="prorata_off"><strong>{$lang.no}</strong></label>
        <input type="radio" {if $configuration.EnableProRata == 'on'}checked{/if}
               name="config[EnableProRata]" value="on" onclick="$('#prorated').ShowNicely();"
               id="prorata_on"/>
        <label for="prorata_on"><strong>{$lang.yes}</strong></label>
    </td>
</tr>
<tr id="prorated" {if $configuration.EnableProRata == 'off'}style="display:none"{/if}>
    <td></td>
    <td>
        <div class="row">
            <div class="form-group col-md-1">
                <label>{$lang.new_ProRataDay}</label>
                <input class="form-control" type="number" size="2" name="config[ProRataDay]"
                       value="{$configuration.ProRataDay}"/>
            </div>


            <div class="form-group col-md-3">
                <label>
                    {$lang.new_ProRataMonth}
                </label>
                <select class="form-control" name="config[ProRataMonth]">
                    <option value="disabled">{$lang.new_ProRataMonth_disabled}</option>
                    {assign var=months value='["January", "February", "March", "April", "May", "June", "July","August","September", "October", "November", "December"]'|json_decode:true}
                    {foreach from=$months item=mon}
                        <option value="{$mon}" {if $configuration.ProRataMonth == $mon}selected{/if}>{$lang[$mon]}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="form-group">
            <label>
                <input type="checkbox" {if $configuration.ProRataNextMonth>0}checked{/if} value="1" id="prorata-next"/>
                {$lang.new_ProRataNextMonth}
                <a class="vtip_description" title="{$lang.promonthdesc}"></a>
            </label>
            <input type="text" name="config[ProRataNextMonth]" id="prorata-next-day"
                    value="{$configuration.ProRataNextMonth}" class="config_val  inp" size="3"
                    {if $configuration.ProRataNextMonth==0}disabled{/if}/> day
        </div>
    </td>
</tr>
{literal}
<script>
    $(function(){
        $('#prorata-next').on('change', function(){
            $('#prorata-next-day').prop('disabled', !this.checked);
        }).trigger('change');
    })
</script>
{/literal}