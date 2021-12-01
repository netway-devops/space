{if $layer && $customfile}
{if !$do} {if $details.status!='Terminated' && $details.status!='Canceled'}
<link href="../includes/types/smartermailtype/style.css" rel="stylesheet" media="all" />
<div class="bcontainerx" id="SmarterMailContainer">
    <div class="ButtonBar">
        <span>Domain {if $details.status=='Pending'}pre-configuration{else}configuration{/if}</span>
    </div>

    <div id="newshelfnav" class="newhorizontalnav">
        <div class="list-2">
            <div class="subm1 haveitems">
                <ul>
                    <li class="active">
                        <a href="#"><span>Options</span></a>
                    </li>
                    <li>
                        <a href="#"><span>Technical</span></a>
                    </li>
                    <li>
                        <a href="#"><span>Features</span></a>
                    </li>
                    <li>
                        <a href="#"><span>Limits</span></a>
                    </li>
                    <li>
                        <a href="#"><span>Sharing</span></a>
                    </li>
                    <li>
                        <a href="#"><span>Throttling</span></a>
                    </li>

                </ul>

            </div>
        </div>
    </div>
    <div style="padding:10px" id="SmarterMailContainerloadable">


    </div>
</div>
{literal}
<script type="text/javascript" >
    function acc_ld_smartermail(sdo,dat) {

    $('#SmarterMailContainerloadable').addLoader();
        if(!sdo) {
            sdo = 'acc_cnf';
                dat = "";
        }

        $.post('?cmd=accounts&'+dat,{
            {/literal}
                'id':{$details.id},
                'action':'edit',
                'sdo':sdo
             {literal}
        },function(data) {
        var d = parse_response(data);
            if(!d || d===true) {
                $('#SmarterMailContainer').slideUp();
                return false;
            } else {
                $('#SmarterMailContainerloadable').html(d).find('.sectioncontent').hide();
                //append tabbed menu.
                 $('#newshelfnav').TabbedMenu({elem:'.sectioncontent',picker:'.list-2 li',aclass:'active'});

            }

        });
    };
    appendLoader('acc_ld_smartermail');
</script>
{/literal}{/if}
{elseif $do=='acc_cnf' ||  $do=='save_cnf'}

<div class="fs11">

    <div  >
        <div   style="display: none;" class="sectioncontent">
            <span >
                <table border="0"  >
                    <tbody><tr > 
                            <td  >Folder Path</td><td ><input type="text"   size="45" value="{$msettings.Path}" name="smartermail[DomainPath]" autocomplete="off" {if $details.status=='Active'}disabled="disabled"{/if}></td>
                        </tr>
                    <tr >
                       
                            <td  >Mailing List Username</td><td ><input type="text"   size="45" value="{$msettings.listcommandaddress}" name="smartermail[listcommandaddress]" autocomplete="off" ></td>
                        </tr>
                      
                    </tbody></table>


                

                
            </span></div>

        <div style="display: none;" class="sectioncontent" >
            <span >
                <table border="0"  >
                    <tbody><tr >
                            <td  >Domain IP</td><td ><input  name="smartermail[serverip]" value="{$msettings.serverip}" /></td>
                        </tr><tr >
                            <td  >Logout URL</td><td ><input type="text" class="text"  name="smartermail[domainurl]" value="{$msettings.domainurl}" autocomplete="off"/></td>
                        </tr><tr >
                            <td  >Auto-Responder Exclusions</td><td ><select  name="smartermail[spamresponderoption]">
                                    <option value="None" {if $msettings.spamresponderoption=='None'}selected="selected"{/if}>No restriction - auto-respond to all mail</option>
                                    <option value="Low" {if $msettings.spamresponderoption=='Low'}selected="selected"{/if}>Do not auto-respond to Spam Level Low and above</option>
                                    <option value="Medium" {if $msettings.spamresponderoption=='Medium'}selected="selected"{/if}>Do not auto-respond to Spam Level Medium and above</option>
                                    <option value="High" {if $msettings.spamresponderoption=='High'}selected="selected"{/if}>Do not auto-respond to Spam Level High and above</option>

                                </select></td>
                        </tr><tr >
                            <td  >Forwarding Exclusions</td><td ><select  name="smartermail[spamforwardoption]">
                                    <option value="None" {if $msettings.spamforwardoption=='None'}selected="selected"{/if}>No restriction - forward all mail</option>
                                    <option value="Low" {if $msettings.spamforwardoption=='Low'}selected="selected"{/if}>Do not forward Spam Level Low and above</option>
                                    <option value="Medium" {if $msettings.spamforwardoption=='Medium'}selected="selected"{/if}>Do not forward Spam Level Medium and above</option>
                                    <option value="High" {if $msettings.spamforwardoption=='High'}selected="selected"{/if}>Do not forward Spam Level High and above</option>

                                </select></td>
                        </tr><tr >
                            <td  ></td><td ><input type="checkbox" value="1"  name="smartermail[requiresmtpauthentication]" {if $msettings.requiresmtpauthentication}checked="checked"{/if} ><label >Require SMTP Authentication</label></td>
                        </tr><tr >
                            <td  ></td><td ><input type="checkbox" value="1"  name="smartermail[autoresponderrestriction]" {if $msettings.autoresponderrestriction}checked="checked"{/if}><label >Enable once per day per sender autoresponder restriction</label></td>
                        </tr><tr >
                            <td  ></td><td ><input type="checkbox" value="1"  name="smartermail[bypassgreylisting]"  {if $msettings.bypassgreylisting}checked="checked"{/if}><label >Disable greylisting</label></td>
                        </tr>
                    </tbody></table>
            </span></div>

        <div style="display: none;" class="sectioncontent"  >
            <span >
                <table border="0"  >
                    <tbody><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[showcalendar]" {if $msettings.showcalendar}checked="checked"{/if}><label >Enable calendar</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[enablecatchalls]" {if $msettings.enablecatchalls!='Disabled'}checked="checked"{/if}><label >Enable catch-alls</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[showcontacts]" {if $msettings.showcontacts}checked="checked"{/if} ><label >Enable contacts</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[showcontentfilteringmenu]" {if $msettings.showcontentfilteringmenu}checked="checked"{/if}><label >Enable content filtering</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[enabledomainuserservicecontrol]" {if $msettings.enabledomainuserservicecontrol}checked="checked"{/if}><label >Enable control of service access</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[showdomainaliasmenu]" {if $msettings.showdomainaliasmenu}checked="checked"{/if}><label >Enable domain aliases</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[showdomainreports]" {if $msettings.showdomainreports}checked="checked"{/if}><label >Enable domain reports</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[showspammenu]" {if $msettings.showspammenu}checked="checked"{/if}><label >Enable domain spam options</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[enableemailreports]" {if $msettings.enableemailreports}checked="checked"{/if} ><label >Enable email reports</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[enableimapretrieval]" {if $msettings.enableimapretrieval}checked="checked"{/if}><label >Enable IMAP retrieval</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[enablemailsigning]" {if $msettings.enablemailsigning}checked="checked"{/if}><label >Enable mail signing</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[showlistmenu]" {if $msettings.showlistmenu}checked="checked"{/if}><label >Enable mailing lists</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[shownotes]" {if $msettings.shownotes}checked="checked"{/if} ><label >Enable notes</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[enablepopretrieval]" {if $msettings.enablepopretrieval}checked="checked"{/if}><label >Enable POP retrieval</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[showtasks]" {if $msettings.showtasks}checked="checked"{/if} ><label >Enable tasks</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[showuserreports]" {if $msettings.showuserreports}checked="checked"{/if}><label >Enable user reports</label></td>
                        </tr>
                    </tbody></table>
            </span></div>

        <div style="display: none;" class="sectioncontent" >
            <span >
                <table border="0"  >
                    <tbody><tr >
                            <td  >Disk Space</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxsize}" name="smartermail[maxsize]" autocomplete="off"> MB (0 = unlimited)</td>
                        </tr><tr >
                            <td  >Domain Aliases</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxdomainaliases}" name="smartermail[maxdomainaliases]" autocomplete="off"> (0 = unlimited)</td>
                        </tr><tr >
                            <td  >Users</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxusers}" name="smartermail[maxusers]" autocomplete="off"> (0 = unlimited)</td>
                        </tr><tr >
                            <td  >User Aliases</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxaliases}" name="smartermail[maxaliases]" autocomplete="off"> (0 = unlimited)</td>
                        </tr><tr >
                            <td  >Mailing Lists</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxlists}" name="smartermail[maxlists]" autocomplete="off"> (0 = unlimited)</td>
                        </tr><tr >
                            <td  >IMAP Retrieval Accounts</td><td ><input type="text" class="text"  size="3" value="{$msettings.maximapretrievalaccounts}" name="smartermail[maximapretrievalaccounts]" autocomplete="off"> (0 = unlimited)</td>
                        </tr><tr >
                            <td  >Max Message Size</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxmessagesize}" name="smartermail[maxmessagesize]" autocomplete="off"> KB (0 = unlimited)</td>
                        </tr><tr >
                            <td  >Recipients per Message</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxrecipients}" name="smartermail[maxrecipients]" autocomplete="off"> (0 = unlimited)</td>
                        </tr>
                    </tbody></table>
            </span></div>

        <div style="display: none;" class="sectioncontent" >
            <span >
                <table border="0"  >
                    <tbody><tr >
                            <td ><input type="checkbox" value="1"  name="smartermail[sharedgal]" {if $msettings.sharedgal}checked="checked"{/if}><label >Enable global address list</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[sharedcalendar]" {if $msettings.sharedcalendar}checked="checked"{/if} ><label >Enable shared calendars</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[sharedcontact]" {if $msettings.sharedcontact}checked="checked"{/if}><label >Enable shared contacts</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[sharedfolder]" {if $msettings.sharedfolder}checked="checked"{/if} ><label >Enable shared folders</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[sharednotes]" {if $msettings.sharednotes}checked="checked"{/if}><label >Enable shared notes</label></td>
                        </tr><tr >
                            <td ><input type="checkbox" value="1" name="smartermail[sharedtasks]" {if $msettings.sharedtasks}checked="checked"{/if} ><label >Enable shared tasks</label></td>
                        </tr>
                    </tbody></table>
            </span></div>

        

        <div style="display: none;" class="sectioncontent"  >
            <span >
                <table border="0"  >
                    <tbody><tr >
                            <td  >Outgoing Messages per Hour</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxmessagesperhour}" name="smartermail[maxmessagesperhour]" autocomplete="off"></td>
                        </tr><tr >
                            <td  >Outgoing Bandwidth per Hour</td><td ><input type="text" class="text"  size="3" value="{$msettings.maxsmtpoutbandwidthperhour}" name="smartermail[maxsmtpoutbandwidthperhour]" autocomplete="off"> MB</td>
                        </tr>
                    </tbody></table>
            </span></div>

        {if $details.status!='Pending'}
      <div style="margin-top:10px"><a onclick="acc_ld_smartermail('save_cnf',$('#SmarterMailContainer input, #SmarterMailContainer select').serialize());return false" href="#" class="new_control greenbtn"><span>Save Domain Configuration</span></a></div>
      {else}
      <div style="margin-top:10px"><a onclick="acc_ld_smartermail('save_cnf',$('#SmarterMailContainer input, #SmarterMailContainer select').serialize());return false" href="#" class="new_control greenbtn"><span>Save Domain Pre-configuration</span></a>
       <span class="orspace fs11">Note: Domain will be provisioned with settings above. If changed, save them before using Create option.</span>
      </div>
      {/if}
    </div>


</div>
{else} 
{/if}
{/if}