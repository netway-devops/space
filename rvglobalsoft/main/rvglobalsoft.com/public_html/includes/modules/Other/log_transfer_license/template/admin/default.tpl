<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
 
     
     <div class="bg-primary" style="padding: 3px;margin-top: 50px;">
        <h3 id="grid-example-fluid " >Search log transfer license </h3>
    </div>

     <form class="form-inline col-md-offset-4" role="form" action="?cmd=module&module={$module}&action=searchLicence" method="post" style="margin-top: 50px;">
         <div class="form-group">
            <label for="ip" class="col-md-3 control-label">IP :</label>
            <div class="col-md-2">
                <input type="text" class="form-control" name="ip"  id="ip" />    
            </div>
            
          </div>
         <button type="submit" class="btn btn-primary col-md-offset-1" >Search</button>

     </form>
     
     <br><br>
     {if $searchData}
     <div class="content">
         <div class="col-md-10 col-md-offset-1">
               <table class="table table-striped table-hover">
                    <tr class="info">
                        <th>
                            AccountID
                        </th>
                        <th>
                            From IP
                        </th>
                        <th>
                            To IP
                        </th>
                        <th>
                            Date
                        </th>
                    </tr>
                    {foreach from=$searchData item=data}
                    <tr>
                        <td>
                            <a href="{$admin_url}?cmd=accounts&action=edit&id={$data.acc_id}&list=all" target="_blank">{$data.acc_id}</a>
                        </td>
                        <td>
                            {$data.from_ip}
                        </td>
                        <td>
                            {$data.to_ip}
                        </td>
                        <td>
                            {$data.create_date|date_format}
                        </td>
                    </tr>
                    {/foreach}
               </table>
         </div> 
         
    </div>
    {else}
    <center>
        <div>
            <h1>
                NO DATA
            </h1>
        </div>
        
    </center>
     {/if}
     



