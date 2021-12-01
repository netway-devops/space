{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') 
         no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </div>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">
        <h2>
            <span id="pageHeading">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</span>
        </h2>
        <div class="body-content">
            <p class="description">
                {$widgetopt.wdescription}
            </p>

            <div>
                {if $block.blocked}
                    {if $block.ttl}
                        <div class="alert alert-warning">
                            <p>{$lang.tempblocked|sprintf:$myip}</p>
                            <code class="code"><strong>{$lang.reason}: </strong>{include file="`$widget_dir`reason.tpl"}</code>
                        </div>
                    {else}
                        <div class="alert alert-danger">
                            <p>{$lang.permblocked|sprintf:$myip:$block.date}</p>
                            <code class="code"><strong>{$lang.reason}: </strong>{include file="`$widget_dir`reason.tpl"}</code>
                        </div>
                    {/if}
                    {if $block.unlock && !$block.protected}
                        <a href="{$widget_url}&act=unblock" class="btn btn-primary">{$lang.removeblock}</a>
                    {else}
                        <p>{$lang.cantremovecontactsupport}</p>
                    {/if}
                {else}
                    <p class="alert alert-success">{$lang.notblocked|sprintf:$myip}</p>
                {/if}
            </div>

            {if $widgetopt.anyaddress}
                <br />
                <form method='POST' action="{$widget_url}&act=check">
                    <div class="form-group">
                        <label for="ipaddress"  class="control-label">{$lang.checkotherip}</label>
                        <input type="text" size="25" name="ipaddress"  value="{if $block.unlock && !$block.protected}{$myip}{/if}"
                               pattern="{literal}((^|\.)((25[0-5])|(2[0-4]\d)|(1\d\d)|([1-9]?\d))){4}${/literal}" class="form-control">
                    </div>
                    <input class="btn btn-primary" type="submit" name="unblock" value="{$lang.checkforip}" />
                    {securitytoken}
                </form>
            {/if}
        </div>
    </div>
{/if}
