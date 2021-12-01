{if $lang[$block.reason_mask]}{$lang[$block.reason_mask]}{*}
{*}{elseif $block.protected}{$lang.donotunblock}{*}
{*}{else}{$block.reason}{/if}