{literal}
    <script src="templates/default/js/json-formatter.js"></script>
    <script src="templates/default/hbchat/media/soundmanager2-nodebug-jsmin.js"></script>
    <script src="templates/default/js/jsonpath.js"></script>
    <script src="templates/default/js/debug.js"></script>
    <style>

        #logs-fixed {
            position: fixed;
            top: 80px;
            left: 0;
            width: 100%;
            bottom: 0;
            padding: 10px;
        }

        #logs-fixed .content {
            height: 80px;
            padding: 10px 0;
        }

        #debuglogs {
            height: calc(100% - 100px);
            width: 100%;
            font-family: monospace;
            overflow: scroll;
        }

        .log {
            padding: 4px 6px;
            border-top: 1px solid #d8d8d8;
        }

        .log:nth-child(2n) {
            background: #eee;
        }

        .log-date {
            color: #888
        }

        .log-trace,
        .log-context {
            display: block;
            white-space: pre-wrap;
        }

        .label-DEBUG {
            background: #4e79f5;
        }

        .label-INFO {
            background: #00bcd4;
        }

        .label-WARNING {
            background: orange;
        }

        .label-ERROR {
            background: red;
        }

        .log .json-formatter-row .json-formatter-toggler:after {
            font-family: sans-serif;
            font-size: 10px
        }

        .log .json-formatter-row .json-formatter-string {
            white-space: pre-wrap;
        }

        .log .json-formatter-row {
            position: relative;
        }

        .log .json-formatter-row > a > .json-formatter-preview-text {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            position: absolute;
        }

        .filer-out {
            display: none;
        }

        #debuglogs :focus{
            outline: none;
            background: #fff;
        }
    </style>
{/literal}
<div id="search_hooks" hidden bootbox data-title="Search module hooks" data-btnclass="btn-success">

    <div class="form-group">
        <label>Search active module for hook:</label>
        <input type="text" class="form-control" name="hookname" value="" />

        <div class="s-results"></div>
    </div>

</div>
<div id="logs-fixed">
    <h1>
        <div>Debugging page</div>
    </h1>
    <div class="content">
        <div class="pull-right col-md-3">
            <input class="form-control" id="filter" type="text" placeholder="Filter logs ...">
        </div>
        <div class="btn-group">
            <a href="#clear" class="btn btn-default" id="clear-logs">Clear</a>
            <a href="#pause" class="btn btn-default" id="pause-logs">Pause</a>
            <a href="#folow" class="btn btn-default active" id="follow-logs">Follow</a>
        </div>
        <a href="#Export" class="btn btn-default" id="hook-export">Export Log</a>
        <a href="#Hooks" class="btn btn-default" id="hook-logs">Procedural Hooks</a>
        <a href="#Modulehooks" class="btn btn-default" id="module-hooks">Module Hooks</a>
        <a href="?cmd=queue" class="btn btn-default">Queue</a>
        <a href="?cmd=root&action=phpinfo" class="btn btn-default" target="_blank">PHPInfo</a>
    </div>
    <div id="debuglogs"></div>
</div>