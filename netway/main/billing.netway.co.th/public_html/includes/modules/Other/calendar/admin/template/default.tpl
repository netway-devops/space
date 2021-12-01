{literal}
    <style>
        #content_tb > tbody > tr:first-child{
            display: none;
        }
        td.bordered {
            border: none;
            display: block;
            left: 0;
            margin: 0px;
            position: absolute;
            width: 100%;
        }
        #bodycont{
            padding: 0 2px;
        }
        #bodycont > .blu{
            display: none;
        }
    </style>
{/literal}

<div>
    {if $action == 'config'}
        {include file="config.tpl"}
    {else}
        <div id="calendar-root" style="margin: 0"></div>
        <div id="calendar-settings" >
            {*}{include file="config.tpl"}{*}
        </div>
        <script>var root = $('#calendar-root');
            root.height(Math.max($(window).height() - root.offset().top -5, 500))
        </script>
        {include file="widget.tpl"}
    {/if}
</div>


