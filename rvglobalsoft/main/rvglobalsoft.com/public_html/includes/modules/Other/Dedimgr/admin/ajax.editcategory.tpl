<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;"> <form action="?cmd=module&module={$moduleid}&do=inventory&subdo=category&make=editcategory&id={$category.id}" method="post" id="addcolocation">

            <div class="tabb colo_floor">
                <h3 style="margin:0px;">Edit inventory category {$category.name}</h3>

                <div class="form" style="margin:10px 0px">


                    <label class="nodescr">Name</label>
                    <input name="name" type="text" class="w250" value="{$category.name}"/>



                </div>

                <div class="clear"></div>
            </div>


        </form></div>

    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#addcolocation').submit(); return false"><span><b>Save category</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>