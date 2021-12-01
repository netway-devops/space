<div class="tdetails invoice-edit active">
    <table border="0" width="600" cellspacing="5" cellpadding="0">
        <tr>
            <td width="100"  align="right" class="light">{$lang.Subject}</td>
            <td colspan="3"><span class="livemode">{$estimate.subject}</span> </td>
        </tr>
        <tr>
            <td width="100" align="right" class="light">
                {$lang.Date}:
            </td>
            <td width="200" align="left">
                <span class="livemode">
                    {$estimate.date_created|dateformat:$date_format}
                </span>
            </td>
            <td width="100" align="right" class="light">
                {$lang.taxlevel1}:
            </td>
            <td width="200" align="left">
                <span class="livemode">
                    {$estimate.taxrate|default:0} %
                </span>
            </td>

        </tr>
        <tr>
            <td width="100" align="right" class="light">
                {$lang.validuntil}:
            </td>
            <td width="200" align="left">
                <span class="livemode">
                    {$estimate.date_expires|dateformat:$date_format}
                </span>
            </td>
            <td width="100" align="right" class="light">
                {$lang.taxlevel2}:
            </td>
            <td width="200" align="left">
                <span class="livemode">
                    {$estimate.taxrate2|default:0} %
                </span>
            </td>


        </tr>
        <tr>
            <td width="100" align="right" class="light">
                {$lang.Amount}:
            </td>
            <td width="200" align="left">
                <strong>{$estimate.total|price:$currency}</strong>
            </td>

            <td width="100" align="right" class="light">
                {$lang.Discount}:
            </td>
            <td width="200" align="left">
                <span class="livemode">{$estimate.credit|price:$currency}</span>
            </td>
        </tr>
    </table>
</div>
<div class="secondtd invoice-edit">
    <form action="" method="post" id="detailsform">
        <input type="hidden" name="make" value="editdetails" />
        <table border="0" width="700" cellspacing="3" cellpadding="0">
            <tr>
                <td width="100"  align="right" class="light">{$lang.Subject}</td>
                <td colspan="3">
                    <input name="estimate[subject]" size="64" maxlength="64" value="{$estimate.subject}" />
                </td>
            </tr>
            <tr>
                <td width="100" align="right" class="light">{$lang.Date}:</td>
                <td width="200" align="left">
                    <input name="estimate[date_created]" 
                           value="{$estimate.date_created|dateformat:$date_format}" 
                           class="haspicker" size="12"/>
                </td>
                <td width="100" align="right" class="light">{$lang.taxlevel1}:</td>
                <td width="120" align="left">
                    <input name="estimate[taxrate]" size="7" 
                           value="{$estimate.taxrate}" /> %
                </td>
            </tr>
            <tr>
                <td width="100" align="right"  class="light">{$lang.validuntil}:</td>
                <td width="200" align="left">
                    <input name="estimate[date_expires]" 
                           value="{$estimate.date_expires|dateformat:$date_format}" 
                           class="haspicker" size="12"/>
                </td>


                <td width="100" align="right" class="light">{$lang.taxlevel2}:</td>
                <td width="200" align="left" >
                    <input name="estimate[taxrate2]" size="7" 
                           value="{$estimate.taxrate2}" /> %
                </td>



            </tr>
            <tr>
                <td width="100" align="right"  class="light">{$lang.Amount}:</td>
                <td width="200" align="left" >
                    <strong>{$estimate.total|price:$currency}</strong></td>

                <td width="100" align="right" class="light">{$lang.Discount}:</td>
                <td width="200" align="left" colspan="2">
                    <input name="estimate[credit]" size="7" value="{$estimate.credit}" /> </td>

            </tr>

        </table>
        {securitytoken}
    </form>
</div>

{include file="_common/estimate_address_notification.tpl"}