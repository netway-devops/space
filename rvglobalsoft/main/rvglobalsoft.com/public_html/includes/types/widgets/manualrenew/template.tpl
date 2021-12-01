<div class="wbox">
    <div class="wbox_header">
        {$lang.manualrenew}
    </div>
    <div class="wbox_content">

        {if $notsupportedcycle}
            <p>{$lang.manualrenew_notsupported}</p>
        {else}
            {if $unpaidinvoice}
                <p>
                    {$lang.manualrenew_unpaidinvoice}
                    <a href="{$ca_url}clientarea/invoice/{$unpaidinvoice.id}/">{$unpaidinvoice|@invoice}</a>
                </p>
            {/if}
            {if $pendingorder}
                <p>
                    {$lang.manualrenew_pendingorder|sprintf:$pendingorder}
                </p>
            {/if}
        {/if}
        </p>

        {if !$notsupportedcycle && !$unpaidinvoice && !$pendingorder}
            <form action="" method="post">
                <input type="hidden" name="make" value="issueinvoice"/>
                <p>
                    {$lang.manualrenew_guide}
                </p>
                <input type="submit" class="btn btn-primary btn-w-100 btn-md-w-auto" value="{$lang.manualrenew_now}" onclick="return confirm('{$lang.manualrenew_confirm}');"/>
                {securitytoken}
            </form>
        {/if}

    </div>
</div>

