<div class="panel panel-default">
    <div class="panel-heading">
        <strong>{$lang.emailnotification}</strong>
    </div>
    <div class="panel-body" id="emnotify">
        <div class="subhead">
            <strong>{$lang.premadesett}</strong>
            <a href="#none" class="label label-default">{$lang.none}</a>
            <a href="#full" class="label label-default">{$lang.full_email}</a>
        </div>
        {foreach from=$notify key=group item=list}
            <div class="checkbox-group">
                <label class="legend">
                    <input type="checkbox"/>
                    {if $group == 'Notifications'}
                        <a href="?cmd=notifications"
                           target="_blank">{$lang.Notifications}</a>
                    {else}
                        {$lang[$group]}
                    {/if}
                </label>
                <div class="fieldset">
                    {foreach from=$list item=email}
                        <label>
                            <input class="checker1" type="checkbox" name="emails[]" value="{$email.event}"
                                   {if $details.emails && in_array($email.event, $details.emails)}checked="checked"{/if} />
                            {if $email.lang && $lang[$email.lang]}{$lang[$email.lang]}
                            {elseif $email.name}{$email.name}
                            {else}{$email.event}
                            {/if}
                        </label>
                    {/foreach}
                </div>
            </div>
        {/foreach}
    </div>
    <div class="panel-footer">
        <button type="submit" value="1" name="save"
                class="btn btn-primary">{$lang.savechanges}</button>
        <span
                class="orspace">{$lang.Or} <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
    </div>
</div>
