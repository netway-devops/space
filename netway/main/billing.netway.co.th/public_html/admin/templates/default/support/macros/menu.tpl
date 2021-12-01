<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li {if $picketdtab || $pickedtab == 0}class="active"{/if}>
                <a href="?cmd=predefinied">{$lang.listcats}</a>
            </li>
            <li class="">
                <a href="?cmd=predefinied&pickedtab=1">{$lang.mymacros}</a>
            </li>
            <li class="last">
                <a href="?cmd=predefinied&pickedtab=2">{$lang.browseintree}</a>
            </li>
        </ul>
    </div>

    {if ($action=="default" || $action=="myreplies" || !$action)}
        <div class="list-2">
            <div class="navsubmenu haveitems">
                <ul>
                    <li class="list-2elem"><a href="?cmd={$cmd}&action=newcat{if $category.id}&category_id={$category.id}{/if}" ><span>{$lang.addcat}</span></a></li>
                    <li class="list-2elem"><a href="?cmd={$cmd}&action=new{if $category.id}&category_id={$category.id}{/if}" ><span>{$lang.addmacro}</span></a></li>
                </ul>
            </div>
            <div class="navsubmenu haveitems" style="display:none">
                <ul>
                    <li class="list-2elem"><a href="?cmd={$cmd}&action=new&mine" ><span>{$lang.addmacro}</span></a></li>
                </ul>
            </div>
        </div>
    {/if}
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="?cmd={$cmd}">Ticket macros</a></li>
        {foreach from=$category.breadcrumbs item=item}
            <li class="breadcrumb-item"><a href="?cmd={$cmd}&cid={$item.id}">{$item.name|escape}</a></li>
        {/foreach}
        <li class="breadcrumb-item active"><a href="?cmd={$cmd}&cid={$category.id}"><strong>{$category.name|escape}</strong></a></li>
    </ol>
</div>
{literal}
    <style>
        .treeview ul{
            background-color: transparent
        }
        a.sorter-handler{
            cursor:n-resize
        }
        a.sorter-handler:active{
            border-color:#B0B0B0!important;
            background:#f2f2f2!important
        }
        ul.grab-sorter{
            border:solid 1px #ddd;
            border-bottom:none;
            position: relative;
            margin-bottom: 5px;
        }
        ul.grab-sorter li{
            border-bottom:solid 1px #ddd;
            clear: both;
            background: #fff;
            width: 100%
        }

        ul.grab-sorter li div.actions,
        ul.grab-sorter li div.lastitm,
        ul.grab-sorter li div.name{
            float:left;
            padding: 10px 5px;
        }

        ul.grab-sorter li:after{
            content: ".";
            display: block;
            clear: both;
            visibility: hidden;
            line-height: 0;
            height: 0;
        }
        ul.grab-sorter li div.lastitm{
            width:150px;
            float:right;
            padding: 3px 5px;
            background:#F0F0F3;
            color:#767679;
        }
        ul.grab-sorter li div.actions{
            height: 15px;
            width: 120px;
        }
        ul.grab-sorter li:hover div.lastitm, ul.grab-sorter li:hover{
            background: #FFFED1;
        }
        ul.grab-sorter li.placeHolder{
            height:35px;
            border:dashed 1px #999
        }
        .macros{
            background: #FFFFFF;
            border: 1px solid #DDDDDD;
            padding: 2px 5px 10px;
        }
        .actions label{
            display:block
        }
    </style>
{/literal}