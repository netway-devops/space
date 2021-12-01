{if !$custom_automation}
    {foreach from=$supported_emails item=emllist key=emlfor}
        <div class="panel panel-default">
            <div class="panel-heading">
                <strng>{$emlfor} notifications</strng>
            </div>
            <ul class="list-group">

                {foreach from=$emllist item=em key=event name=llp}
                    <li class="list-group-item">
                        <div class="row">
                            <div class="col-sm-6 col-md-4 col-lg-2 text-sm-right">
                                <strong>
                                    {if $lang.$event}{$lang.$event}
                                    {elseif $em.name}{$em.name}
                                    {else}{$event}
                                    {/if}
                                </strong>
                                {if $em.description}
                                    <a class="vtip_description" title="{$em.description}"></a>
                                {/if}
                            </div>
                            <div class="col-md-4">
                                <div class="editor-container" id="{$event}_msg">
                                    <div class="no org-content ">
                                        <span class=" iseditable">
                                            <em>
                                                {if $product.emails.$event =='0' || !$product.emails.$event }
                                                    {$lang.none}
                                                {else}
                                                    {foreach from=$emails[$emlfor] item=emailtpl}
                                                        {if $product.emails.$event==$emailtpl.id}{$emailtpl.tplname}
                                                        {/if}
                                                    {/foreach}
                                                {/if}
                                            </em>
                                            <a href="#" class="editbtn  ">{$lang.Change}</a>
                                        </span>
                                        {if $product.emails.$event}
                                            <a href="?cmd=emailtemplates&action=edit&id={$product.emails.$event}"
                                               target="blank"
                                               class="editbtn directlink editgray orspace">{$lang.Edit}</a>
                                            <a href="?cmd=emailtemplates&action=preview&template_id={$product.emails.$event}"
                                               target="blank"
                                               class="editbtn directlink editgray orspace">{$lang.Preview}</a>
                                        {/if}
                                    </div>
                                    <div class="ex editor" style="display:none">
                                        <select name="emails[{$event}]" class="inp">
                                            <option value="0">{$lang.none}</option>
                                            {foreach from=$emails[$emlfor] item=emailtpl}
                                                <option value="{$emailtpl.id}"
                                                        {if $product.emails.$event ==$emailtpl.id}selected="selected" {/if}>
                                                    {$emailtpl.tplname}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                {/foreach}
            </ul>
        </div>
    {/foreach}
{else}
    {include file=$custom_automation}
{/if}