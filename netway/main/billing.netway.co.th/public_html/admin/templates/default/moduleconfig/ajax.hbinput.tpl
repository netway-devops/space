{if $default.$k!==false}
    {hbinput value=$default.$k name="options[`$k`]"}
{elseif $conf.default}
    {hbinput value=$conf.default name="options[`$k`]"}
{/if}