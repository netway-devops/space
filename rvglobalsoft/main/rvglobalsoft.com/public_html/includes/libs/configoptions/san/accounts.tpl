{once}
{literal}
    <style>
        .san.form-group {
            padding: 0;
            width: auto;
            margin-bottom: 5px;
            float: none;
        }
    </style>
{/literal}
    <script src="{$system_url}includes/libs/configoptions/san/admin.js?v={$hb_version}" type="text/javascript"></script>
{/once}
{foreach from=$c.items item=cit}{if $cit.name}{$cit.name}<br/>{/if}
    <div class="san-form-box custom_field_{$c.copy_of}">
        <input name="custom[{$kk}][{$cit.id}]" type="hidden" value="{$c.data[$cit.id]|escape}" class="san-form-json"/>
        <div class="san-form-list"></div>
        <div class="san">
            <a class="btn btn-primary btn-sm san-add"><i class="fa fa-plus"></i> Add additional SAN</a>
        </div>
    </div>
{literal}
    <script>
        $(function () {
            $('.custom_field_{/literal}{$c.copy_of}{literal}').SanForm();
        })
    </script>
{/literal}
{/foreach}