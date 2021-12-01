<h4>Edit Security Group Rules for {$firewall.name}</h4>
<table class="data-table backups-list"  id="rules" width="100%">
    <thead>

      <tr>

          <th class="">IP Protocol</th>
          <th class="">From Port</th>
          <th class="">To Port</th>
          <th class="">Source</th>
          <th class="actions_column">Actions</th>

      </tr>
    </thead>
    <tbody>

     {foreach item=rule from=$firewall.rules name=ruleloop}

        <tr>
            <td>{$rule.ip_protocol|strtoupper}</td>
            <td>{$rule.from_port}</td>
            <td>{$rule.to_port}</td>
            <td>{$rule.ip_range.cidr} (CIDR)</td>
            <td  style="text-align:right">
                <a class="small_control small_delete fs11" onclick="return  confirm('Are you sure you want to remove this rule')" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=securitygroup&vpsid={$vpsid}&rule={$rule.id}&do=ruledrop&security_token={$security_token}&security_group_id={$firewall.id}">{$lang.remove}</a>
            </td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="5">{$lang.nothing}</td>
        </tr>
        {/foreach}





    </tbody>

  </table>



<div class="clear"></div>


<form action="" method="post" id='formaddrule'>
    <input type="hidden" name="do" value="addrule"/>

    <br/><h3> {$lang.addrule}: </h3>
    <table class="data-table backups-list"  width="100%" cellspacing="0" style="border-top:solid 1px #DDDDDD;">

        <tr>
              <td>
                <b>{$lang.protocol}:</b><br/>
                <select name="ip_protocol" style="width:auto">
                    <option >TCP</option>
                    <option  >UDP</option>
                    <option  >ICMP</option>
                </select></td>
                <td>
                <b>From Port: <a class="vtip_description" title="TCP/UDP: Enter integer value between 1 and 65535. ICMP: enter a value for ICMP type in the range (-1: 255)"></a></b><br/>
                 <input type="text" id="id_from_port" name="from_port" ></td>
                <td>
                <b>To Port: <a class="vtip_description" title="TCP/UDP: Enter integer value between 1 and 65535. ICMP: enter a value for ICMP code in the range (-1: 255)"></a></b><br/>
               <input type="text" id="id_to_port" name="to_port" ></td>
                <td>
                <b>CIDR:</b><br/>
               <input type="text" id="id_cidr" value="0.0.0.0/0" name="cidr"></td>
           

            <td colspan="2" align="center" valign="middle">

                <input type="submit" value="{$lang.submit}" style="font-weight:bold;padding:2px 3px;"  class="blue" />
            </td>
        </tr>


    </table>
    {securitytoken}</form>