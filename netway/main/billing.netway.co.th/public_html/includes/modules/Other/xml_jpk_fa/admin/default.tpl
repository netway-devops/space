<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="list-1elem active">
                <a href="?cmd=xml_jpk_fa"><span>Eksport grupowy</span></a>
            </li>

        </ul>
    </div>

</div>
<form method="post" action="?cmd=xml_jpk_fa&action=submit&type=range"  style="margin: 10px 0" >
    {securitytoken}
    <div class="container-fluid clear">
        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Eksportuj do pliku JPK_FA(3) wg daty
                    </div>
                    <div class="panel-body">


                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="">Data od</label>
                                    <div class="datepicker" style="width: 100%">
                                        <input type="text" value="{$first|dateformat:$date_format}" name="date_from" class="form-control haspicker " style="width: 100%">
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-6">

                                <div class="form-group">
                                    <label for="">Data do</label>
                                    <div class="datepicker" style="width: 100%">
                                        <input type="text" value="{$last|dateformat:$date_format}"  name="date_to" class="form-control haspicker " style="width: 100%">
                                    </div>
                                </div>

                            </div>
                        </div>


                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="only_paid" value="1">
                                    Tylko faktury opłacone
                                </label>
                            </div>
                        </div>


                    </div>


                    <div class="panel-footer">
                        <input type="submit" class="btn-primary btn" value="Generuj" />
                    </div>
                </div>
            </div>
            <div class="col-md-4">
            </div>
        </div>
    </div>

</form>

<form method="post" action="?cmd=xml_jpk_fa&action=submit&type=paidlist"  style="margin: 10px 0" >
    {securitytoken}
    <div class="container-fluid clear">
        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Eksportuj do pliku JPK_FA(3) wg listy faktur
                    </div>
                    <div class="panel-body">


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="">Lista faktur</label>
                                    <textarea type="text" name="ids" class="form-control " style="width: 100%" placeholder="1/12/2011,2/01/2012,121/2021"></textarea>
                                </div>

                            </div>

                        </div>



                    </div>


                    <div class="panel-footer">
                        <input type="submit" class="btn-primary btn" value="Generuj" />
                    </div>
                </div>
            </div>
            <div class="col-md-4">
            </div>
        </div>
    </div>

</form>
<form method="post" action="?cmd=xml_jpk_fa&action=submit&type=list"  style="margin: 10px 0" >
    {securitytoken}
    <div class="container-fluid clear">
        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Eksportuj do pliku JPK_FA(3) wg listy pro-form
                    </div>
                    <div class="panel-body">


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="">Lista pro-form</label>
                                    <textarea type="text" name="proforma_ids" class="form-control " style="width: 100%" placeholder="12112,123421,35123,123412"></textarea>
                                </div>

                            </div>

                        </div>



                    </div>


                    <div class="panel-footer">
                        <input type="submit" class="btn-primary btn" value="Generuj" />
                    </div>
                </div>
            </div>
            <div class="col-md-4">
            </div>
        </div>
    </div>

</form>