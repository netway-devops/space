<script>var todo_place = "default";</script>
<div class="blu">
<strong>Add new task:</strong>
For: <select id="to_who" class="inp">
	<option value="Me">Only Me</option>
	<option value="All">All</option>
</select>
Todo:
<input id="description" class="inp" style="width:300px"/>
<a href="#" onclick="return addTask()" class="savebtn" style="display:inline-block !important;margin-left:-20px;">save</a>
</div>
{include file='ajax.default.tpl'}