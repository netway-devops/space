{if $embedded}
{literal}
    <style>
        #logs li {
            font-family: monospace;
            text-decoration: none;
        }

        #logs .log-item {
            cursor: pointer;
            border
        }

        #logs .log-item + li{
            border-top-color: #eee;
        }

        .progress {
            position: relative;
            height: 28px;
        }

        .msg {
            font: 12px/14px monospace;
            fill: #888;
        }

        .progress-bar .msg{
            fill: #eee
        }

        .progress svg {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            transition: clip-path 0.6s ease;
        }

        .foreground{
            position: relative;
        }

        .background-progress{
            position: absolute;
            opacity: 0.2;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        #progress-actions{
            display: none;
            margin-bottom: 17px;
        }

        .list-group-item.WARNING {
            background-color: #fcf8e3;
            border-top-color: #faebcc;
            border-bottom-color: #faebcc;
            color: #8a6d3b;
        }

        .list-group-item.ERROR {
            background-color: #f2dede;
            border-top-color: #ebccd1;
            border-bottom-color: #ebccd1;
            color: #a94442;
        }
    </style>
    <script type="text/x-handlebars" id="import-tasklog-item">
        <li id="{{data.token}}" class="list-group-item {{class}} log-item"
            data-href="?cmd=queue&action=tasklog&token={{data.token}}"
            data-title="{{body}}">
            <div class="background-progress">
                <div class="{{progressClass}}" role="progressbar"
                     style="width: {{data.percent}}%"></div>
            </div>
            <div class="foreground">
                {{body}}
            </div>
        </li>
    </script>
    <script type="text/x-handlebars" id="import-log-item">
        <li class="list-group-item {{level}}" >
               [{{date}}] {{body}}
        </li>
    </script>
{/literal}
<script src="{$template_dir}js/progress.js?v={$hb_version}" type="text/javascript"></script>
<div class="row">
    <div class="col-md-12">
        <div class="progress" id="progress-queue" data-id="{$id}" data-token="{$token}">
            <svg width="1" height="28" viewBox="0 0 2 28">
                <text class="msg" text-anchor="middle" alignment-baseline="middle" x="0" y="14"></text>
            </svg>
            <div class="progress-bar progress-bar-striped active" role="progressbar"
                 style="width: {$percent|max:1}%;">
                <svg width="1" height="28" viewBox="0 0 2 28">
                    <text class="msg" text-anchor="middle" alignment-baseline="middle" x="0" y="14"></text>
                </svg>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12" id="progress-actions"></div>
</div>
<div class="row">
    <div class="col-md-12">
        <ul id="logs" class="list-group"></ul>
    </div>
</div>
{else}
    <div id="bodycont">
        <div class="container-fluid" style="margin: 10px 0">
            {if $title}
                <h1>{$title}</h1>
            {/if}
            {include file="queue/progress.tpl" embedded=true}
        </div>
    </div>
{/if}