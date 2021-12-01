<h1>Service monitoring</h1> 

{foreach from=$monitors item=host key=hostk}
<h3>{$hostk}</h3>

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="statustable table ">
    <tr>
        <th>Service</th>
        <th>Status</th>
        <th>Last Check</th>
        <th>Duration</th>
        <th>Attempt</th>
        <th>Info</th>
    </tr>

    {foreach from=$host.services item=s}
    <tr class="rowstatus-{$s.status}">
        <td>{$s.service}</td>
        <td>{$s.status}</td>
        <td>{$s.lastcheck}</td>
        <td>{$s.duration}</td>
        <td>{$s.attempt}</td>
        <td>{$s.info}</td>
    </tr>
    {/foreach}
</table>
    {foreachelse}
    No items assigned for this accoutn are available for monitoring
{/foreach}
{literal}
<style>
    .statustable td{
        border:solid 1px #fff;
        font-size:11px;

    }
    .statustable th{
        background-color: #E9E9E9;
    }
    .statustable .rowstatus-OK td {background-color: #F4F4F4;}
    .statustable .rowstatus-UNKNOWN td {background-color:#FFDA9F}
    .statustable .rowstatus-CRITICAL td {background-color:#FFBBBB;}
    .statustable .rowstatus-WARNING td {background-color: #FEFFC1;}

</style>
{/literal}