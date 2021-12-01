<script type="text/javascript">
    {literal}
        function disb_ns(e) {
            if (e) {
                $('.todisable').attr('disabled', 'disabled').addClass('disabled');
    {/literal}{if !$singledomain}$('.nsrow').slideUp();{/if}{literal}
            } else {
                $('.todisable').removeClass('disabled').removeAttr('disabled');
    {/literal}{if !$singledomain}$('.nsrow').slideDown();{/if}{literal}
            }
        }

    function add_ns(elem) {
        var limit = 10,
            tr = $(elem).parents('tr').first(),
            button = $('.add_ns'),
            id = tr.children().last().children().first().data('id'),
            clone = tr.clone(),
            new_id = id + 1,
            ip = $('input[name="nsips[nsip' + id + ']"]').parents('tr').first(),
            new_ip = $('input[name="nsips[nsip' + new_id + ']"]').parents('tr').first();

        if (id < limit) {
            clone = prepare_ns(clone, id);
            if (new_id === limit)
                clone.children().last().children().last().remove();
            if (ip.length > 0 && new_ip.length <= 0) {
                var cloneip = ip.clone();
                cloneip = prepare_ns(cloneip, id);
                ip.after(clone);
                clone.after(cloneip);
            } else {
                tr.after(clone);
            }
            button.remove();
        }
    }
    function prepare_ns(clone, id) {
        var input = clone.children().last().children().first(),
            text = clone.children().first().html(),
            new_id = id + 1,
            name = input.prop('name');
        input.data('id', new_id);
        input.prop('name', name.replace(id, new_id));
        input.prop('value', '');
        text = text.replace(id, new_id);
        clone.children().first().html(text);

        return clone;
    }

    {/literal}
</script>
<div class="wbox">
    <div class="wbox_header">{assign var=widg_name value="`$widget.name`_widget"}{if $lang[$widg_name]}{$lang[$widg_name]}{elseif $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div  class="wbox_content">
        <form action="" method="post" onsubmit="return confirm('{$lang.confirmnschange}');">
            <input type="hidden" name="widgetdo" value="updateNameServers"  />

            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped">
                {if $whosns}
                    <tr class="even">
                        <td align="right"><strong>{$lang.generalsettings}</strong></td>
                        <td>
                            <input type="radio" name="whosns" value="ours" onclick="disb_ns(true)" id="who_ours"
                                   {if $whosns=='ours'}checked="checked"{/if} /> <label for="who_ours">{$lang.ourns}</label>
                            <input type="radio" onclick="disb_ns(false)"   name="whosns" value="clients" id="who_clients"
                                   {if !$whosns || $whosns=='clients'}checked="checked"{/if} /> <label for="who_clients">{$lang.custom} </label>
                        </td>
                    </tr>
                {/if}
                {if $singledomain}
                    {foreach from=$details.nameservers item=nameserver key=number name=nsloop}
                        <tr class="nsrow {if $smarty.foreach.nsloop.iteration%2==0}even{/if}">
                            <td align="right">{$lang.nameserver} {$number+1}</td>
                            <td >
                                <input type="text" size="40" data-id="{$number+1}" value="{$nameserver}" name="nameservers[ns{$number+1}]"
                                       class="styled todisable form-control {if $whosns=='ours'}disabled{/if}" {if $whosns=='ours'}disabled="disabled"{/if}/>
                                {if $smarty.foreach.nsloop.last && ($number+1) != 10}<a class="add_ns" style="font-size: 11px;" href="#" onclick="add_ns(this); return false;">{$lang.add_more}</a>{/if}
                            </td>
                        </tr>
                        {if $details.nsips && $details.nsips|is_array}
                            <tr class="nsrow {if $smarty.foreach.nsloop.iteration%2==0}even{/if}" >
                                <td align="right">{$lang.nameserver} IP {$number+1}</td>
                                <td >
                                    <input type="text" size="40" value="{$details.nsips.$number}" name="nsips[nsip{$number+1}]" 
                                           class="todisable  {if $whosns=='ours'}disabled{/if}"  {if $whosns=='ours'}disabled="disabled"{/if}/>
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                {else}
                    {foreach item=i from=1|@range:10 name=mnsloop}
                        <tr class="nsrow  even">
                            <td align="right">{$lang.nameserver} {$i}</td>
                            <td ><input type="text" class="styled" size="40" data-id="{$i}" value="" name="nameservers[ns{$i}]" class="styled todisable"/>
                                {if $smarty.foreach.mnsloop.last && $i != 10}<a class="add_ns" href="#" style="font-size: 11px;" onclick="add_ns(this); return false;">{$lang.add_more}</a>{/if}
                            </td></tr>
                    {/foreach}
                    {/if}


                <tr  class="even"><td colspan="2" align="center"> <input type="submit"  value="{$lang.savechanges}" style="font-weight:bold" class=" btn btn-primary"/>
                        <span class="fs11">{$lang.or}</span> <a href="{$ca_url}clientarea/domains/{if $details}{$details.id}/{$details.name}/{/if}" class="fs11">{$lang.cancel}</a></td></tr>
            </table>




            {securitytoken}</form>
    </div>
</div>


