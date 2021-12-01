
{if $enableFeatures.netstat!='off'}
    <!-- Server Status -->
    <article>
        <h2><i class="icon-s-status"></i> {$lang.netstat|capitalize}</h2>
        <p>{$lang.showscurrentstatusyourservers}</p>

        <div class="server-status">
            <p>{$lang.netstat}</p>
            <div class="padding" id="netstat_update">
                {include file="ajax.netstat.tpl"}
            </div>
        </div>
    </article>
{/if}