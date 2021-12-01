{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <h2>  Account statistics</h2> 
    <br />
    {foreach from=$list item=stat}
        <div>
            <div id="stats_emailac_counts_text" class="stats_left">
                {$stat.item}
                <div class="pull-right">
                    <span id="stats_emailac_counts_count">{$stat.count}</span> /
                    <span id="stats_emailac_counts_max">{$stat.max}</span>
                    {$stat.unit}
                </div>
            </div>
            <div>

                <div class="progress {if $stat.percent>90}progress-danger{elseif $stat.percent>65}progress-warning{else}progress-success{/if}">
                    <div style="width: {$stat.percent}%;" title="0%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="{$stat.percent}" 
                         role="progressbar" class="progress-bar bar">
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
    <h3> Server Information </h3> 
    <table class="table">
        {foreach from=$infostat item=stat}
            <tr>
                <td>
                    {$stat.item}
                </td>
                <td>
                    {$stat.value}
                </td>
            </tr>
        {/foreach}
    </table>
{/if}