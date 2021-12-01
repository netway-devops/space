<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">


            {include file='configuration/leftmenu.tpl'}

        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="">
                {include file="configuration/nav.tpl" picked_tab='5' }
                <div class="nicerblu" id="ticketbody">
                    <div id="newtab">
                        <div class="tabb">


                            {if !$a_currencies}
                            <div class="blank_state blank_news">
                                <div class="blank_info">
                                    <h1>You need to have additional currencies defined first</h1>
                                    In order to use this feature please define additional currencies first.
                                    <div class="clear"></div>
                                    <a class="new_add new_menu" href="?cmd=configuration&picked_tab=5&picked_subtab=1" style="margin-top:10px">
                                        <span>Add currency</span></a>
                                    <div class="clear"></div>
                                </div>
                            </div>

                             {elseif !$rules}
                                <div class="blank_state blank_news">
                                    <div class="blank_info">
                                        <h1>Define currency to country rules</h1>
                                        If you need to force certain countries to use one currency use this feature to setup rules. <br/>
                                        Customer-selected currency will be automatically changed to one defined in currency ruleset
                                        <div class="clear"></div>
                                        <a class="new_add new_menu" href="#" style="margin-top:10px" onclick="$('#addnewtax').toggle();return false">
                                            <span>Add new rule</span></a>
                                        <div class="clear"></div>
                                    </div>
                                </div>
                            {/if}







                            <div class="rest" style="">
                                {if $rules}

                                    <h3>Current Currency to country rules</h3>
                                    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                                        <tbody>
                                        <tr>
                                            <th>{$lang.country}</th>
                                            <th>{$lang.currency}</th>
                                            <th width="20"></th>
                                        </tr>

                                        {foreach from=$rules item=tax}
                                            <tr>
                                                <td>{$countries[$tax.country]}</td>
                                                <td>{$all_currencies[$tax.currency_id].iso}</td>
                                                <td><a href="?cmd=currencytocountry&make=deleterule&country={$tax.country}&security_token={$security_token}" onclick="return confirm('{$lang.removetaxconfirm}')" class="delbtn">{$lang.Delete}</a></td></tr>
                                        {/foreach}



                                        <tr id="adtax_bt">
                                            <th colspan="6" align="left">
                                                <a href="#" class="btn btn-xs btn-success" onclick="$('#adtax_bt').hide();$('#addnewtax').show();return false;">Add new rule</a>&nbsp;
                                                <a href="?cmd=currencytocountry&make=addeur&security_token={$security_token}" class="btn btn-xs btn-default" >Set EUR as default for EU countries</a>&nbsp;
                                                <a href="?cmd=currencytocountry&make=rmallrules&security_token={$security_token}" class="btn btn-xs btn-danger" onclick="return confirm('Are you sure?');" >Remove all rules</a>&nbsp;
                                            </th>
                                        </tr>
                                        </tbody>

                                    </table>
                                {/if}
                                <div class="blu" id="addnewtax" style="display:none">
                                    <form action="" method="post">

                                        <table cellspacing="2" cellpadding="3" border="0">
                                            <tr>
                                                <td valign="middle"><strong>{$lang.country}:</strong></td>
                                                <td><select name="country" id="ct_"  class="inp" >
                                                        {foreach from=$countries key=k item=v}
                                                            <option value="{$k}">{$v}</option>
                                                        {/foreach}
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <table cellspacing="2" cellpadding="3" border="0">
                                            <tr>
                                                <td>{$lang.currency}:</td>
                                                <td> <select name="currency_id"  class="inp" >
                                                        {foreach from=$all_currencies key=k item=v}
                                                            <option value="{$v.id}">{$v.iso}</option>
                                                        {/foreach}
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <input type="hidden" value="addrule" name="make"/>
                                        <center> <input type="submit" style="font-weight: bold;padding:10px;" value="Add new rule" class="submitme"/> <span class="orspace">{$lang.Or} <a href="#" charset=" editbtn" onclick="$('#adtax_bt').show();$('#addnewtax').hide();return false;">{$lang.Cancel}</a> </span>

                                             <span class="orspace">{$lang.Or} <a href="?cmd=currencytocountry&make=addeur&security_token={$security_token}" class="editbtn" >Set EUR as default for EU countries</a>&nbsp;</span>
                                        </center>
                                        {securitytoken}</form>
                                </div>


                            </div>

                        </div>


                    </div>

                </div>








            </div>
            </div>
 </td></tr></table>