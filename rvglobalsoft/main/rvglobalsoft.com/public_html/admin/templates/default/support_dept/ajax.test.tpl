{if $result}
    <p>
        <strong style="color: {if $result.result == 'Success'}#009900{elseif $result.result == 'Error'}#990000{/if}">
            {if $action == 'test_connection' && $method === 'PIPE' && $result.ticket}
                Check test status here
                <a href="?cmd=tickets&action=view&num={$result}">[{$lang.tickethash}{$result.ticket}]</a>
            {elseif $lang[$result.result]}
                {$lang[$result.result]}
            {else}
                {$result.result}
            {/if}
            {if $result.error}: {$result.error}{/if}
        </strong>
    </p>
    {if $result.log}
        <pre>{$result.log}</pre>
    {/if}
{/if}