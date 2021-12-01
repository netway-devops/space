<div class="container-fluid" style="margin: 10px">
    <div class="row">
        <div class="col-md-12">
            <div id="listproducts">
                {if $profile}
                    <h3>Profile: <a href="?cmd=importaccounts&action=tld_profile&id={$profile.id}"><b>{$profile.name}</b></a></h3>
                    {foreach from=$profile_prices key=currency item=tlds}
                        <hr>
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                            <thead>
                            <tr>
                                <th colspan="6">Currency: <b>{$currency}</b></th>
                            </tr>
                            <thead>
                            <tr>
                                <th>TLD</th>
                                <th>Period</th>
                                <th>Register</th>
                                <th>Transfer</th>
                                <th>Renew</th>
                                <th>Redemption</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach from=$tlds key=tld item=prices}
                                {foreach from=$prices key=period item=price name=cat}
                                    <tr>
                                        <td><span><b>{$tld}</b></span></td>
                                        <td><span>{$period} year/s</span></td>
                                        <td>{$price.register|price:false:false|default:"n/a"} {$currency}</td>
                                        <td>{$price.transfer|price:false:false|default:"n/a"} {$currency}</td>
                                        <td>{$price.renew|price:false:false|default:"n/a"} {$currency}</td>
                                        <td>{$price.redemption|price:false:false|default:"n/a"} {$currency}</td>
                                    </tr>
                                {/foreach}
                            {/foreach}
                            </tbody>
                        </table>
                    {/foreach}
                {/if}
            </div>
        </div>
    </div>
</div>

