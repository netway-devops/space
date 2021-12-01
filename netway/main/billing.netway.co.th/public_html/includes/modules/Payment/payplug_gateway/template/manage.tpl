{if $futurepay_id}
<h2>Your current Credit Card is active and securely stored</h2>
Thank you, your recurring invoices will be automatically marked as Paid, our billing system will debit your Credit Card.<br/>
All new purchases will also fall under your current agreement, there is no need for re-entering your credit card details.<br/><br/>
<form class="well" action="" method="post">
    <input type="hidden" name="do" value="cancel" />
    If your credit card is about to expire you can cancel and create new agreement with us: <br/>
    <button class="btn btn-danger" type="submit" onclick="return confirm('Are you sure you wish to cancel your agreement?');">Cancel your Credit Card token</button>
    {securitytoken}
</form>
{else}
<h2>You dont have active Credit Cards saved with us</h2>
    Pay one of due invoices to store card automatically
{/if}