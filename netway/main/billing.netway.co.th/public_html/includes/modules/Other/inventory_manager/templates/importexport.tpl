<div class="row">
    <form action="" method="post" enctype="multipart/form-data">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 col-md-offset-1">
                    <button type="submit" name="export" value="Export" class="btn-primary btn">Export</button>
                </div>
                <div class="col-md-7 col-md-offset-2">
                    <h3><strong>How to import data</strong></h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-md-offset-1">
                    <div class="row">
                        <div class="col-lg-4">
                            <button id="importL" type="submit" name="import" value="Import" class="btn-primary btn">Import</button>
                        </div>
                        <div class="col-lg-6">
                            <input style="padding-top: 5px;" type="file" name="fileUpload">
                        </div>
                    </div>
                </div>
                <div class="col-md-7 col-md-offset-1">
                    <p>1. The import does not update the current data, <strong>only adds new items</strong></p>
                    <p>2. For import, use an xls file that has the same sheets and column layout as the generated export file. <br>(Advice: First, export the data to see the xls file scheme.)</p>
                </div>
            </div>
            {securitytoken}
        </div>
    </form>
</div>
{if $logs}
<div class="row">
    <div class="col-sm-11 col-centered">
        <table id="logs" class="table table-bordered table-striped">
            <thead>
            <tr>
                <th class="col-sm-1">Type</th>
                <th class="col-sm-2">Date</th>
                <th class="col-sm-8">Entry</th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$logs item=log}
                <tr>
                    <td>{$log.type}</td>
                    <td>{$log.date}</td>
                    <td>{$log.message}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
{/if}

{literal}
    <style>
        .row{
            margin-bottom: 10px;
            margin-top: 10px;
        }
        .col-centered{
            float: none;
            margin: 0 auto;
        }
    </style>
{/literal}