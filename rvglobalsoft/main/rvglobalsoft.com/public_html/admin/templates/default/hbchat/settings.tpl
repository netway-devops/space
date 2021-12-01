<div class="nicerblu">
    <form action="" method="post" id="submitform">
        <input type="hidden" name="make" value="updateconfig"/>
        <table width="100%" cellspacing="0" cellpadding="6">
            <tbody class="sectioncontent">

                <tr>
                    <td width="210" align="right">
                        <strong>Auto-switch operators
                            <a title="If operator is not able to pick up chat request HostBill will switch to another
                             operator from this department. <br> Enter number of seconds to auto-switch.
                             Disable this option if you plan to use mobile notifications about pending chats"
                               class="vtip_description"></a>
                        </strong>
                    </td>
                    <td class="editor-container">
                        <input type="checkbox" class="styled inp" name="config[ChatRoundRobinEnable]" value="on"
                               {if $configuration.ChatRoundRobinEnable=='on'}checked="checked"{/if}
                               onclick="$('.roundrobinrow').toggle()"/>
                    </td>
                </tr>

                <tr class="roundrobinrow" {if  $configuration.ChatRoundRobinEnable!='on'}style="display: none;" {/if}>
                    <td width="180" align="right"><strong>Switch operator every </strong></td>
                    <td class="editor-container">
                        <input type="text" class="styled inp" size="4" name="config[ChatRoundRobinInterval]"
                               value="{$configuration.ChatRoundRobinInterval}"/>
                        seconds
                    </td>
                </tr>

                <tr class="roundrobinrow" {if  $configuration.ChatRoundRobinEnable!='on'}style="display: none;" {/if}>
                    <td align="right"><strong>Max operator switches
                            <a title="If no operator pick up chat request after n-changes chat will be automatically closed"
                               class="vtip_description"></a>
                        </strong>
                    </td>
                    <td class="editor-container">
                        <input type="text" class="styled inp" size="4" name="config[ChatRoundRobinMiss]"
                               value="{$configuration.ChatRoundRobinMiss}"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <strong>Chat invitation timeout
                            <a title="If operator invites visitor to chat, and conversation wont start
                            after n-seconds, it will be timed out"
                               class="vtip_description"></a>
                        </strong>
                    </td>
                    <td class="editor-container">
                        <input type="text" class="styled inp" size="4" name="config[ChatInvitationTimeout]"
                               value="{$configuration.ChatInvitationTimeout}"/>
                        seconds
                    </td>
                </tr>

                <tr>
                    <td align="right" valign="top">
                        <strong>
                            Add tracking to clientarea
                            <a title="With this option footprint tracking/invitation code will be integrated with
                            HostBill client interface automatically"
                               class="vtip_description"></a>
                        </strong>
                    </td>
                    <td class="editor-container">
                        <input type="checkbox" class="styled inp" name="config[ChatTrackHostBill]" value="on"
                               {if $configuration.ChatTrackHostBill=='on'}checked="checked"{/if} />
                    </td>
                </tr>

                <tr>
                    <td align="right" valign="top">
                        <strong>
                            Pre-fill client details
                            <a title="Pre fill client name and email with details gathered in previous chat sessions if user is not logged in"
                               class="vtip_description"></a>
                        </strong>
                    </td>
                    <td class="editor-container">
                        <input type="checkbox" class="styled inp" name="config[ChatPreFillGuest]" value="on"
                               {if $configuration.ChatPreFillGuest=='on'}checked="checked"{/if} />
                    </td>
                </tr>

                <tr>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a onclick="$('#submitform').submit();return false;" href="#"
                                       class="new_dsave new_menu">
                            <span>Save Changes</span>
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
        {securitytoken}

    </form>
</div>