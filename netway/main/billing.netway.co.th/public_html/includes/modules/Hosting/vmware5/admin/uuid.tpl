<div class="{if $value && $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  
     {if $value && $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}>
    <input name="extra_details[VmUuid]" value="{$value}" />
    <button class="btn btn-default btn-sm" onclick="return load_servers()">Load VMs</button>
</div>
<span class="{if $value && $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" 
      {if !$value || $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>
    {$value}
</span>
<script type="text/javascript">
    {literal}
            function load_servers() {
                var url ={/literal} '?cmd=accounts&action=edit&id={$details.id}&service={$details.id}';{literal}
                var inp = $('[name="extra_details[VmUuid]"]');
                inp.wrap('<div class="left" />');
                inp.parent().addLoader();
                $.post(url, {vpsdo: 'listvms', 'current': inp.val()}, function (data) {
                    var r = parse_response(data);
                    inp.parent().replaceWith(r);
                });
                return false;
            }
    {/literal}
</script> 