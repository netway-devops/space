{if $step.status=='Completed'}
    <span class="info-success">Acceptation succeeded.</span>
    <br>
    {if $step.output}
        <br/>
        <b>Details:</b> {$step.output}
    {/if}
    <br>
    {if  $details.contract_accepted_date}
        <b>Accepted date:</b> {$details.contract_accepted_date} <br/>
    {/if}
    {if $details.contract_accepted_by_parsed}<br>
        <b>Accepted by:</b> {$details.contract_accepted_by_parsed} <br>
    {/if}
{else}
    {if $step.status=='Pending'}
        Contracts are awaiting to be accepted<br/>
        Client contract URL: {$system_url}?cmd=contracts&onumber={$details.number}
        <br/>
        <br/>
        <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=AcceptContract&order_id={$details.id}&security_token={$security_token}"><span>Accept Contract</span></a>
    {else}
        <span class="info-failed">Accept contract failed</span>
        <br/>
    {/if}
    {if $step.output}
        <br/>
        <br/>
        <b>Details:</b> {$step.output}
    {/if}
{/if}



