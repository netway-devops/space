{if !$ajax}
    <script type="text/javascript" src="../includes/modules/Other/Todolist/admin/todolist.js"></script>

{/if}<link href="../includes/modules/Other/Todolist/admin/todolist.css" rel="stylesheet" media="all" />

<div id="todolist">

    <ul class="todo-list" >

        {foreach from=$todo item=task}<li class="task ti_{$task.id}">
                <div class="tools">
                    <i class="fa fa-edit"   onclick="return showEditor(this)"></i>
                    <i class="fa fa-trash-o" onclick="return deleteMe({$task.id})"></i>
                </div>   
                <span class="text {if $task.status=='Done'}done{/if}">
                    <input type="checkbox" {if $task.status=='Done'}checked="checked"{/if} onclick="return markMe(this)" id="{$task.id}" >
                    {$task.description}
                    <small class="label label-info"> Added by {if $task.addwho==$task.me}me{else}{$task.headdit}{/if}</small>
                </span>
                <span class="editor">
                    <input class="descr1 inp" value="{$task.description}"/> <a href="#" onclick="return editTask({$task.id})" class="savebtn">save</a>
                </span>

                {if $task.status=='Done'}
                    <small class="label label-success">Completed by {if $task.didwho==$task.me}me{else}{$task.hedidit}{/if}</small>
                {/if}

            </li>
        {/foreach}
    </ul>
    <div id="addnewtask">
        <form class="form-inline">
            <div class="form-group">
                <label class="sr-only" for="exampleInputEmail3">For whom</label>
                <select id="to_who" class="form-control" id="exampleInputEmail3">
                    <option value="Me">For: Me</option>
                    <option value="All">For: All</option>
                </select>
            </div>
            <div class="form-group">
                <label class="sr-only" for="exampleInputPassword3">Description</label>
                <input type="text" id="description" class="form-control" id="exampleInputPassword3" placeholder="Task Description">
            </div>

            <button type="submit" class="btn btn-default"  onclick="return addTask()">Add new task</button>
        </form>
    </div></div>