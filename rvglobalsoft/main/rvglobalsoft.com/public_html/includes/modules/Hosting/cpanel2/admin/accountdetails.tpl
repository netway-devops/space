{literal}

    <style type="text/css">
        .progress_1 {
            background:#f0f0f0;padding:10px 15px;
        }

        .progress_1 div.p {
            float: left;
            margin-right: 15px;
            color: #c4bdbc;
        }

        .progress_1 div.act, .progress_1 div.p.act {
            font-weight: bold;
            color: #0162a0;
        }

        .progress_1 div.done, .progress_1 div.p.done {

            color: #727272;
        }

        .progress_2 {
            padding: 5px 15px;
            background: #f7f7f7;
            color: #565656;
        }

        .alert, .progress_2.alert {
            background: #FFFBCC;
            color: #FF6600;
        }

        .progress_2 .inf {
            color: #0162a0;
        }

        .alert .inf, .progress_2.alert .inf {
            color: red;
        }
    </style>    {/literal}
{if $url.whm || $url.cpanel}
<div style="margin:10px 0px;">
    <ul class="accor">
        <li>
            <a>Login</a>
            <div class="sor">
                <form action="" method="post" class="form-inline">
                    <div style="float: left; padding: 2px">
                            {if $url.whm}
                        <a href="{$url.whm}" target="_blank" class="btn btn-sm btn-default">WHM</a>
                            {/if}
                            {if $url.cpanel}
                        <a href="{$url.cpanel}" target="_blank" class="btn btn-sm btn-default">cPanel</a>
                            {/if}
                    </div>
                </form>
            </div>
        </li>
    </ul>
</div>
{/if}
