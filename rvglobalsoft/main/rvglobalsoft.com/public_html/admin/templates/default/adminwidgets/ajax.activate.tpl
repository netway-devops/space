{if !$available}
    <h3>No new widget is available</h3>
    Widgets features can be added trough
    <a href="?cmd=managemodules"><b>Extras->Plugins</b></a>
    and
    <a href="?cmd=reports"><b>Extras->Statistics & Reports</b></a>
    <br/>
    <br/>
    Make sure to check/activate following free widgets/plugins:
    <ul>
        <li><b>Calendar</b> - schedule and track events in time</li>
        <li><b>To-do list</b> - create team to-do's</li>
        <li><b>Admin notes</b> - create and manage personal notes</li>
    </ul>
{else}
    <form method="post" action="?cmd=adminwidgets&action=enable">
        <select name="widget" class="form-control" id="exampleInputName2">
            {foreach from=$available item=widget}
                <option value="{$widget.id}">{if $lang[$widget.name]}{$lang[$widget.name]}{else}{$widget.name}{/if}</option>
            {/foreach}
        </select>
        {securitytoken}
    </form>
{/if}