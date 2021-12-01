{*
Manage worldpay futurepay agreements from clientarea
- cancel current agreement
- create new agreement (if no active agreement exists)
*}

{if $futurepay_id}
<h2>Your current WorldPay FuturePay agreement is active</h2>
Thank you, your recurring invoices will be automatically marked as Paid, our billing system will debit your WorldPay agreement.<br/>
All new purchases will also fall under your current agreement, there is no need for re-entering your credit card details.<br/><br/>
<form class="well" action="" method="post">
    <input type="hidden" name="do" value="cancel" />
    If your credit card is about to expire you can cancel and create new agreement with us: <br/>
    <button class="btn btn-danger" type="submit" onclick="return confirm('Are you sure you wish to cancel your agreement?');">Cancel your FuturePay agreement</button>
    {securitytoken}
</form>
{else}
<h2>You dont have active WorldPay FuturePay agreement with us</h2>

{$futurepay_form}

{/if}