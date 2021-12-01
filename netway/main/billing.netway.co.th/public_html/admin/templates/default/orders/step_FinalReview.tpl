{if $step.status=='Completed'}
  <span class="info-success">Order has been reviewed and set as Active</span>

{else}
    Order is awaiting manual review. <br/><br/>
    {if $canreview}
    <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=FinalReview&order_id={$details.id}&security_token={$security_token}&skip=true" ><span>Mark Order as Active</span></a> <span class="orspace">Note: This action change order status only</span>
        {else}
        Your current admin role does not allow to mark it as reviewed
    {/if}

{/if}