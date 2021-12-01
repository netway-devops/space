{if $steps[4].status != 'Completed' && $steps[2].status == 'Completed'}
<div class="p5"><b>เจ้าหน้าที่สามารถดำเนินการทำ Provision โดยการกด Accept Order ได้เลย</b></div>
{/if}

{if $step.status=='Completed'}
   <span class="info-success">Payment for order has been captured</span>
    {if $step.output}
    <br/><br/><b>Capture return:</b> {$step.output}
    {/if}<br/><br/>


    <a class="menuitm" href="?cmd=orders&action=edit&id={$details.id}&markcancelledrefund=true&security_token={$security_token}" onclick="return confirm('Are you sure? It will call module terminate command')"><span style="color:red">Cancel &amp; refund order</span></a>

    <span class="orspace fs11">Note: You will be able to review refund before issuing it.</span>
{else}
    {if $step.status=='Pending'}
       Payment is awaiting to be captured. {if $step.auto=='1'}Capture should happen automatically with cron run, if it fails try button below{/if}<br/><br/>
    {else}
        <span class="info-failed">Payment capture failed</span><br/>
    {/if}
    <br/><br/>

         <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=Capture&order_id={$details.id}&security_token={$security_token}"><span>{$details.module}: Capture</span></a>


    
    {if $step.output}
    <br/><br/><b>Capture return:</b> {$step.output}
    {/if}
{/if}



