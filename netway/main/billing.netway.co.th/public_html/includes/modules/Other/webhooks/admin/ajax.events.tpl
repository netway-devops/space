<ul class="list-group list-events" id="events">
    {foreach from=$events item=event key=name}
        <li class="list-group-item" data-event="{$name}">
            <button class="btn btn-default btn-xs pull-right doc"
                    type="button">Docs</button>
            <strong>{$event.name}</strong>
            <pre>{$event.doc|escape}</pre>
        </li>
        {foreachelse}
        <li class="list-group-item">
            All events
        </li>
    {/foreach}
</ul>
<div id="hook-doc" style="display: none">
    <p>
        The system name for this event: <code class="event-name"></code>.
    </p>
    {if $hook.content == 'json'}
        Event data will be sent in
        <code>json</code>
        format. For example:
    {literal}
        <pre>{"id": 10, "email": "joe@example.com", "item": {"id": 1}}</pre>
    {/literal}
    {else}
        Event data will be sent in
        <code>x-www-form-urlencoded</code>
        format. For example:
    {literal}
        <pre>id=10&email=joe@example.com&item[id]=1</pre>
    {/literal}
    {/if}
        <p>
            Example PHP script.
        </p>
        <pre>
<div class="validate-code"></div>
{if $hook.content == 'json'}
$details = json_decode($data, true);
{else}
$details = $_POST;
{/if}

<div class="event-doc"></div></pre>
</div>