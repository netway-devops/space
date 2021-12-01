<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;"> <form action="?cmd=dedimgr&do=newfloor&colo_id={$colocation_id}" method="post" id="addcolocation">

            <div class="tabb colo_floor">
                <h3 style="margin:0px;">Create new colocation floor</h3>

                <div class="form" style="margin:10px 0px">



                    <div class="form-group">

                        <label class="nodescr">Name</label>
                        <input name="name" type="text" class="form-control" value="{$floor.name}"/>
                    </div>
                    <div class="form-group">
                        <label class="nodescr">Floor number</label>
                        <input name="floor" type="text" class="form-control" size="10"  value="{$floor.floor}"/>
                    </div>





                </div>

                <div class="clear"></div>
            </div>


        </form></div>

    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#addcolocation').submit(); return false"><span><b>Add new floor</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>