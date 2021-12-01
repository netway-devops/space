<div class="wbox">
    <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div class="wbox_content">
        {if $license}
            <table width="100%" class="checker table" cellpadding="0" cellspacing="0">
                {counter name=alter start=0 print=false assign=alter}
                {foreach from=$license item=data key=key name=alter}
                    {if $data && $key!='isenkompass' && $key!='status' && $key!='updateexpiretime' && $key!='valid' && $key!='valid'}
                        <tr {if $alter%2==0}class="even"{/if}>
                            <td {if $smarty.foreach.alter.laast}style="border:none" {/if}align="right" width="200">{if $lang[$key]}{$lang[$key]}{else}{$key}{/if}:</td>
                            <td {if $smarty.foreach.alter.laast}style="border:none" {/if}><b>{$data}</b></td>
                        </tr>
                        {counter name=alter}
                    {/if}
                {/foreach}
            </table>
        {/if}
    </div>
</div>