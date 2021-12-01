<table border="0" cellpadding="0" cellspacing="0" style="margin-bottom:10px;" width="100%">
    <tbody><tr>
        <td class="logoLeftNav"></td>
        <td valign="top" >

            {if !$data}
            <h3>No data is cached from Cacti/Observium Yet</h3>
            {else}

            Show <a href="?cmd=topbandwidthlist&limit=10">10</a> <a href="?cmd=topbandwidthlist&limit=50">50</a>   <a href="?cmd=topbandwidthlist&limit=100">100</a>
            <br/><br/>
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                <tbody>
                <tr>

                    <th  align="left">Account</th>
                    <th  align="left">Customer</th>
                    <th  align="left">Device</th>
                    <th  align="left">Period</th>
                    <th  align="left">Total transfer</th>
                    <th  align="left">Average bandwidth</th>
                    <th  align="left">95th percentile</th>
                </tr>
                {foreach from=$data item=i name=fl}
                    <tr class="havecontrols {if $smarty.foreach.fl.index%2==0}even{/if}">

                        <td><a href="?cmd=accounts&action=edit&id={$i.rel_id}" target="_blank">#{$i.rel_id} {$i.domain}</a></td>
                        <td><a href="?cmd=clients&action=show&id={$i.client_id}" target="_blank">#{$i.client_id} {$i.firstname} {$i.lastname}</a></td>
                        <td>{$i.name}</td>
                        <td>{$i.cache.from} - {$i.cache.to}</td>
                        <td>{$i.formatted.total}</td>
                        <td>{$i.formatted.average}</td>
                        <td>{$i.formatted.95th}</td>
                    </tr>
                {/foreach}
                </tbody>
                {/if}
                </td>
                </tr>
                </tbody>
            </table>