

<div class="text-block clear clearfix">
  <h5>{$lang.cancellrequest}</h5>

  <div class="clear clearfix">
      <form action="" method="post" class="p19">
        <input type="hidden" value="cancel" name="make"/>


            <p class="bold" style="color:#7f7f7f">{$lang.cancel_for}<strong><a href="{$ca_url}clientarea&amp;action=services&amp;service={$service.id}">{$service.catname} - {$service.name}</a></strong></p>
        <table width="100%" align="center" class="checker">
            <tbody>
                <tr><td colspan="2">{$lang.cancel_describe}</td></tr>
                <tr><td colspan="2"><textarea style="width: 99%;" rows="6" name="reason"></textarea></td></tr>
                <tr><td >{$lang.canceltype}
                        <select name="type" style="margin-top:5px;">

                            <option value="Immediate">{$lang.immediate}</option>
                            <option value="End of billing period">{$lang.endofbil}</option>

                        </select></td>
                        <td align="right"> <input type="submit" value="{$lang.cancelrequest}" class="clearstyle btn red-custom-btn h-btn bold" />
            {$lang.or} <a href="{$ca_url}clientarea&amp;action=services&amp;service={$service.id}">{$lang.backtoservice}</a></td>
                </tr>
		        <tr><td><br /><a href="/knowledgebase/article/316/cancellations-and-refunds-policy/" style="color: red;" target="_blank">* Refund Policy</a></td></tr>
            </tbody></table>


        {securitytoken}
        </form>
        <br /><br /><br />
  </div>
</div>




<!--<div class="bordered-section article">
    <h2 class="bbottom">{$lang.cancellrequest}</h2>
    <form action="" method="post" class="p19">
        <input type="hidden" value="cancel" name="make"/>

        <p>{$lang.cancel_for}<strong><a href="{$ca_url}clientarea&amp;action=services&amp;service={$service.id}">{$service.catname} - {$service.name}</a></strong></p>
        <table width="100%" align="center">
            <tbody>
                <tr><td colspan="2">{$lang.cancel_describe}</td></tr>
                <tr><td colspan="2"><textarea style="width: 99%;" rows="6" name="reason"></textarea></td></tr>
                <tr><td >{$lang.canceltype}
                        <select name="type">

                            <option value="Immediate">{$lang.immediate}</option>
                            <option value="End of billing period">{$lang.endofbil}</option>

                        </select></td>
                        <td align="right"> <input type="submit" value="{$lang.cancelrequest}" class="btn btn-danger btn-large" />
            {$lang.or} <a href="{$ca_url}clientarea&amp;action=services&amp;service={$service.id}">{$lang.backtoservice}</a></td>
                </tr>
            </tbody></table>

        {securitytoken}
    </form>
</div>-->