<h3>Submit report about this customer to Fraudrecord.com</h3>

<form action="?cmd=fraudrecord&action=report&client_id={$client_id}" method="post">
    <input type="hidden" name="make" value="submit" />
    {securitytoken}
    <h4>Client info</h4>
    <div class="tablebg">
        <table border="0" cellspacing="1" cellpadding="3" class="table table-bordered table-striped">
            <tr>
                <th width="250">Field</th>
                <th>Information</th>
                <th></th>
            </tr>

            {foreach from=$client item=v key=k}
                {if !$v}{continue}{/if}


            <tr>
                <td class="td_first">{if $lang[$k]}{$lang[$k]}{else}{$k}{/if}</td>
                <td>{if $k=='ccnumber'}**** **** **** {$v|substr:-4}{else}{$v}{/if}</td>
                <td><input type="checkbox" name="{$k}_check" checked="checked"/></td>
            </tr>
            {/foreach}

            <tr>
                <th colspan="3">Additional details</th>
            </tr>
            <tr>
                <td class="td_first">Domain Name or Hostname <input type="hidden" name="key1" value="domain"/></td>
                <td><input type="text" name="value1" size="40" value=""> e.g. domain.com</td>
                <td></td>
            </tr>

            <tr>
                <td class="td_first">Paypal Email <input type="hidden" name="key2" value="paypal"/></td>
                <td><input type="text" name="value2" size="40" value=""></td>
                <td></td>
            </tr>
            <tr>
                <td class="td_first">Secondary Email Address <input type="hidden" name="key3" value="email2"/></td>
                <td><input type="text" name="value3" size="40" value=""></td>
                <td></td>
            </tr>
            <tr>
                <td class="td_first">Other: <input type="hidden" name="key4" value="other"/></td>
                <td><input type="text" name="value4" size="40" value=""></td>
                <td></td>
            </tr>
        </table>
    </div>
    <br/><br/>
    <h4>Report Details</h4>
    <div class="tablebg">
        <table border="0" cellspacing="1" cellpadding="3" class="table table-bordered">
            <tr>
                <th width="250">Field</th>
                <th>Information</th>
            </tr>

            <tr>
                <td class="td_first">Report Type</td>
                <td>
                    <select name="type">
                        <option value=""></option>
                        {foreach from=$types item=t}
                            <option value="{$t}">{$t}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>

            <tr>
                <td class="td_first">Report Value</td>
                <td>
                    <select name="value">
                        <option value="0" >0</option>
                        <option value="1" >1</option>
                        <option value="2" >2</option>
                        <option value="3" >3</option>
                        <option value="4" >4</option>
                        <option value="5" >5</option>
                        <option value="6" >6</option>
                        <option value="7" >7</option>
                        <option value="8" >8</option>
                        <option value="9" >9</option>
                        <option value="10" >10</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="td_first">More Information</td>
                <td>
                    Please provide more information about the type of the misbehavior of the client.
                    <br/>
                    <textarea name="text" cols="80" rows="7"></textarea>


                </td>
            </tr>


        </table>


    </div>

    <div style="padding-left:250px; margin-top:20px;">
        <input type="submit" name="submit" class="btn btn-success" value="Submit report"/>
        <input type="hidden" name="action" value="report"/>
    </div>
</form>