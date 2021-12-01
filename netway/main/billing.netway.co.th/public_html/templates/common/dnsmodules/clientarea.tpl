<link media="all" type="text/css" rel="stylesheet" href="{$type_dir}style.css" />
<div id="dns-service">
{if $widget.replacetpl}
    {include file=$widget.replacetpl}

{else}


    {if $act=='dns_manage' || $act=='add_record' || $act=='edit_record'}
        {include file='../common/dnsmodules/tpl/record_def.tpl'}
    {/if}

    {if $act=='add_domain'}
        {include file='../common/dnsmodules/tpl/zone_add.tpl'}
    {elseif $act=='clone_record'}
        {include file='../common/dnsmodules/tpl/record_clone.tpl'}
    {elseif $act=='import_records'}
        {include file='../common/dnsmodules/tpl/record_import.tpl'}
    {elseif $act=='add_record'}
        {include file='../common/dnsmodules/tpl/record_add.tpl'}
    {elseif $act=='edit_record'}
        {include file='../common/dnsmodules/tpl/record_edit.tpl'}
    {elseif $act=='dns_manage'}
        {include file='../common/dnsmodules/tpl/records.tpl'}
    {elseif $act=='dns_templates'}
        {include file='../common/dnsmodules/tpl/templates.tpl'}
    {elseif $act=='progress'}
        {include file='../common/dnsmodules/tpl/progress.tpl'}
    {elseif $act=='default' || !$act}
        {include file='../common/dnsmodules/tpl/zones.tpl'}
    {/if}
{/if}
</div>