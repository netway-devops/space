<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;"> <form action="?cmd=dedimgr&do=newcolo" method="post" id="addcolocation">

            <div class="tabb colocation">
                <h3 style="margin:0px;">Create new colocation</h3>

                <div class="form" style="margin:10px 0px">

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">

                                <label class="nodescr">Name</label>
                                <input name="name" type="text" class="form-control" required/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="nodescr">Phone</label>
                                <input name="phone" type="text " class="form-control"/>
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="nodescr">Address</label>
                                <textarea name="address" class="form-control" rows="5"></textarea>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="nodescr">Emergency Contact</label>
                                <textarea name="emergency_contact" class="form-control" rows="5"></textarea>
                            </div>
                        </div>

                    </div>


                    <div class="row">
                        <div class="col-md-4">

                            <div class="form-group">
                                <label class="nodescr">Price / GB</label>
                                <input name="price_per_gb" type="text"  class="form-control"/>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="nodescr">Price / IP</label>
                                <input name="price_per_ip" type="text" class="form-control" />
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label  class="nodescr">Price / reboot</label>
                                <input name="price_reboot" type="text"  class="form-control"/>
                            </div>
                        </div>


                    </div>





                    <div class="clear"></div>
                </div>

                <div class="clear"></div>
            </div>


        </form></div>

    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#addcolocation').submit(); return false"><span><b>Add new colocation</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>