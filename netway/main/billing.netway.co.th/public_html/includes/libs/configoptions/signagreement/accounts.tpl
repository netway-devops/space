{foreach from=$c.items item=cit}
    <div class="form-file" id="custom_field_{$c.id}" >
        <div class="form-file-list">
            {foreach from=$c.data[$cit.id] key=fid item=field_data}
                <div class="upload-result">
                    <a class="attachment" href="?cmd=contracts&action=pdf_agreement&hash={$field_data}" target="_blank">{$c.contracts[$c.config.contract]}</a>
                    <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$c.id}][{$cit.id}]" value="{$field_data}" type="hidden"/>
                </div>
            {/foreach}
        </div>
    </div>
{/foreach}