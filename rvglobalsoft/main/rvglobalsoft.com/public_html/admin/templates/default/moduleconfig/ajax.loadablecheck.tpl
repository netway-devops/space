    {if is_array($conf.default)}
        {foreach from=$conf.default item=cs}
            {if $cs|is_array}
                <input type="checkbox" name="options[{$k}][]" {if is_array($default.$k) && in_array($cs[0],$default.$k)}checked="checked"{/if} value="{$cs[0]}" /> {$cs[1]} <br />
            {else}
                <input type="checkbox" name="options[{$k}][]" {if is_array($default.$k) && in_array($cs,$default.$k)}checked="checked"{/if} value="{$cs}" /> {$cs} <br />
            {/if}
        {/foreach}
    {else}
        <span>
                {if $default.$k|is_array}
                    {foreach from=$default.$k item=opt name=multicheck}
                        {if $opt != '' || $smarty.foreach.multicheck.iteration == 1}
                            <input name="options[{$k}][]" value="{$opt}" /><br />
                        {/if}
                    {/foreach}
                {else}
                            <input name="options[{$k}][]" value="" /><br />
                {/if}
                        </span>
        <a href="" onclick="addmultifield(this, '{$k}');return false;" style="font-size:9px;" >Add next value</a>
    {/if}
