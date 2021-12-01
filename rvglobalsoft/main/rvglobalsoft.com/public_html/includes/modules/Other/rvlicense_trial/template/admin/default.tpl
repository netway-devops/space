<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    {if $success}
        <p class="bg-success col-md-offset-3 col-md-7">{$success}</p>
    {else if $errorss}
        <p class="bg-danger col-md-offset-3 col-md-7">{$errorss}</p>
    {/if}
    <div class="bg-primary" style="padding: 3px;margin-top: 50px;">
        <h3 id="grid-example-fluid " >Add Trial License </h3>
    </div>
    
    <form class="form-horizontal" role="form" action="?cmd=module&module={$module}&action=addLicence" method="post" style="margin-top: 50px;">
         <div class="form-group">
            <label for="product" class="col-md-4 control-label">Product :</label>
            <div class="col-md-5">
              <select class="form-control" name="product"  id="product">
                    <option>RVSitebuilder</option>
                    <option>RVSkin</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="type" class="col-md-4 control-label">Type :</label>
            <div class="col-md-5">
              <select class="form-control" name="type"  id="type">
                    <option value="9">Dedicated</option>
                    <option value="11">VPS</option>
              </select>
            </div>
          </div>
           <div class="form-group">
            <label for="mip" class="col-md-4 control-label">Main IP :</label>
            <div class="col-md-5">
              <input type="text" class="form-control" name="mip"  id="mip" />
            </div>
          </div>
          <div class="form-group">
            <label for="sip" class="col-md-4 control-label">Second IP :</label>
            <div class="col-md-5">
              <input type="text" class="form-control" name="sip"  id="sip" />
            </div>
          </div>
          <div class="form-group">
            <label for="exp" class="col-md-4 control-label">Expire :</label>
            <div class="col-md-5">
              <input type="date" class="form-control" name="exp"  id="exp" value="{php}echo date('Y-m-d',strtotime(date().'+30 days'));{/php}" />
            </div>
          </div>
         
              <button type="submit" class="btn btn-primary center-block" >Add</button></center>
          
     </form>
     
     <div class="bg-primary" style="padding: 3px;margin-top: 50px;">
        <h3 id="grid-example-fluid " >Edit Trial License  </h3>
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
     {if $searchData}
     <div class="col-md-offset-2">
        <h4 id="grid-example-fluid " >RVSitebuider Trial</h4>
        {if $searchData.site}
        <table class="table">
            <tr class="active">
                <th>
                    t_id
                </th>
                <th>
                    license_type
                </th>
                <th>
                    main_ip
                </th>
                <th>
                    second_ip
                </th>
                <th>
                    exprie
                </th>
                <th>
                    effective_expiry
                </th>
                <th>
                    comment
                </th>
                <th>
                    edit/delete
                </th>
            </tr>
            <tr class="warning">
                <td>
                    {$searchData.site.id}
                </td>
                <td>
                    {$searchData.site.type}
                </td>
                <td>
                    {$searchData.site.mip}
                </td>
                <td>
                    {$searchData.site.sip}
                </td>
                <td>
                    {$searchData.site.exp}
                     
                </td>
                <td>
                    {$searchData.site.eff}
                </td>
                <td>
                    {$searchData.site.comment}
                </td>
                <td>
                    <a href="?cmd=module&module={$module}&action=editRVSiteLicence&tid={$searchData.site.id}">Click</a>
                </td>
            </tr>
        </table>
        {else}
            <div class="bg-primary">
                <h5 id="grid-example-fluid " >Not licensed.</h5>
            </div>
        {/if}
        <div >
        <h4 id="grid-example-fluid " >RVSKin Trial</h4>
        {if $searchData.skin}
        <table class="table">
            <tr class="active">
                <th>
                    t_id
                </th>
                <th>
                    license_type
                </th>
                <th>
                    main_ip
                </th>
                <th>
                    second_ip
                </th>
                <th>
                    exprie
                </th>
                <th>
                    effective_expiry
                </th>
                <th>
                    comment
                </th>
                <th>
                    edit/delete
                </th>
            </tr>
            <tr class="warning">
                <td>
                    {$searchData.skin.id}
                </td>
                <td>
                    {$searchData.skin.type}
                </td>
                <td>
                    {$searchData.skin.mip}
                </td>
                <td>
                    {$searchData.skin.sip}
                </td>
                <td>
                    {$searchData.skin.exp}
                </td>
                <td>
                    {$searchData.skin.eff}
                </td>
                <td>
                    {$searchData.skin.comment}
                </td>
                <td>
                    <a href="?cmd=module&module={$module}&action=editRVSkinLicence&tid={$searchData.skin.id}">Click</a>
                </td>
            </tr>
        </table>
        {else}
            <div class="bg-primary">
                <h5 id="grid-example-fluid " >Not licensed.</h5>
            </div>
        {/if}
     </div>
     {/if}



