<style>
    {literal}
        #facebox .unblock-options tr:nth-child(2n) td{
            padding-bottom: 10px
        }
        #facebox .unblock-options input,
        #facebox .unblock-options textarea{
            vertical-align: middle; 
            float: none; 
            margin: 0;
        }
    {/literal}
</style>

<table style="width: 100%" class="unblock-options">
    <tr>
        <td> <strong>Widget description</strong></td>
    </tr>
    <tr>
        <td>
            <textarea name="config[wdescription]" class="inp" style="width: 90%"
                      placeholder="">{$widget.config.wdescription}</textarea>
        </td>
    </tr>
    <tr>
        <td> 
            <strong>Max recent unblocks</strong>
        </td>
    </tr>
    <tr>
        <td>
            Limit number of unblocks a user can requests to
            <input type="text" name="config[limit]" value="{$widget.config.limit|default:"1"}" class="inp" style="width: 50px;"/>
            in 
            <input type="text" name="config[period]" value="{$widget.config.period|default:"5"}" class="inp" style="width: 50px;"/>
            minute interval.
        </td>
    </tr>


    <tr>
        <td> <strong>Custom IP Address</strong></td>
    </tr>
    <tr>
        <td>
            <input type="checkbox" name="config[anyaddress]" value="1" {if $widget.config.anyaddress}checked="checked"{/if} class="inp" style=""/>
            Allow clients to request unblock for any IP addres.
        </td>
    </tr>


    <tr>
        <td> <strong>Protect ip addresses with specific comment</strong></td>
    </tr>
    <tr>
        <td>
            <input type="checkbox" name="config[protect]" value="1" {if $widget.config.protect}checked="checked"{/if} class="inp" style=""/>
            Do not allow clients to remove ip addresses with
            <input type="text" name="config[denycomment]" value="{$widget.config.denycomment|default:"do not delete"}" 
                   class="inp" style="width: 200px;"/>
            in the deny comment
        </td>
    </tr>

</table>