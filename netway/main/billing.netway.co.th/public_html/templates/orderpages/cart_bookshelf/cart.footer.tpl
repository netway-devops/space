<!-- Information -->
<div class="information clearfix">
    {if $opconfig.whyus}
    <h2>{$opconfig.whyus}</h2>
    {/if}
    {if $opconfig.footer1head || $opconfig.footer1text}
        <div class="information-box left">
            <div class="round-icon left">
            </div>
            <div class="information-details left">
                {if $opconfig.footer1head}
                    <h4 class="openSansBoldItalic">{$opconfig.footer1head}</h4>
                {/if}
                {if $opconfig.footer1text}
                    <p class="openSansRegular">
                        {$opconfig.footer1text}
                    </p>
                {/if}
            </div>
        </div>
        <div class="information-shadow left">
        </div>
    {/if}
    {if $opconfig.footer2head || $opconfig.footer2text}
        <div class="information-box left">
            <div class="round-icon support-icon left">
            </div>
            <div class="information-details left">
                {if $opconfig.footer2head}
                    <h4 class="openSansBoldItalic">{$opconfig.footer2head}</h4>
                {/if}
                {if $opconfig.footer2text}
                    <p class="openSansRegular">
                        {$opconfig.footer2text}
                    </p>
                {/if}
            </div>
        </div>
    {/if}
</div>

{if !$clientdata.id}
<!-- Contact Message -->
<div class="contact-msg clearfix">
    <p>{$lang.donthaveaccount}? </p>
    <a href="{$ca_url}signup" class="big-blue-btn"> {$lang.createaccount} &raquo;</a>
</div>
{/if}