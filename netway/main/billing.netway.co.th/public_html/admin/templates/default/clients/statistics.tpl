
<div class="client-settings">

    {if $stats.accounts}
        {foreach from=$stats.accounts item=acct key=k}
            {assign var="descr" value="_hosting"}
            {assign var="baz" value="$k$descr"}

            <div class="client-setting-row">
                <div class="client-setting-title">
                    {if $lang.$baz}{$lang.$baz}{else}{$k}{/if}:
                </div>
                <div class="client-setting-value ">
                    <strong>{$acct}</strong>

                </div>
            </div>


        {/foreach}
    {/if}
    <div class="client-setting-row">
        <div class="client-setting-title">
            {$lang.Domains}:
        </div>
        <div class="client-setting-value ">
            <strong>{$stats.domain}</strong>

        </div>
    </div>
    <div class="client-setting-row">
        <div class="client-setting-title">
            {$lang.supptickets}:
        </div>
        <div class="client-setting-value ">
            <strong>{$stats.ticket}</strong>

        </div>
    </div>

</div>