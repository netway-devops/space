<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="list-1elem active">
                <a href="?cmd=xml_ubl"><span>Bulk export</span></a>
            </li>

        </ul>
    </div>

</div>
<form method="post" action="?cmd=xml_ubl&action=submit"  style="margin: 10px 0" >
    {securitytoken}
<div class="container-fluid clear">
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Bulk export UBL invoices to zip file
                </div>
                <div class="panel-body">


                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="">Date from</label>
                                <div class="datepicker" style="width: 100%">
                                    <input type="text" value="{$first|dateformat:$date_format}" name="date_from" class="form-control haspicker " style="width: 100%">
                                </div>
                            </div>

                        </div>
                        <div class="col-md-6">

                            <div class="form-group">
                                <label for="">Date to</label>
                                <div class="datepicker" style="width: 100%">
                                    <input type="text" value="{$last|dateformat:$date_format}"  name="date_to" class="form-control haspicker " style="width: 100%">
                                </div>
                            </div>

                        </div>
                    </div>



                </div>


                <div class="panel-footer">
                    <input type="submit" class="btn-primary btn" value="Download Zip file" />
                </div>
            </div>
        </div>
        <div class="col-md-4">
        </div>
    </div>
</div>

</form>