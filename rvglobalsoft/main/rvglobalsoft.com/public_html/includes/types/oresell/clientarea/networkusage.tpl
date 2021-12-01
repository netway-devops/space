<br/>
<center><iframe width="680" height="300" src="{$ca_url}clientarea&action=services&service={$service.id}&vpsdo=shownetworkusage&vpsid={$vpsid}" scrolling="no" frameborder="0" style="background:url('ajax-loading.gif') no-repeat center center"></iframe></center>

<div align="center" style="padding:10px;">{if $network_speed}{$lang.networkspeed} <strong>{$network_speed}</strong>{/if}</div>