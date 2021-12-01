<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">

<div class="bg-primary" style="padding: 3px;margin-top: 50px;">
        <h3 id="grid-example-fluid " >Edit Trial License </h3>
    </div>
    
    <form class="form-horizontal" role="form" action="?cmd=module&module={$module}&action=updateLicence" method="post" style="margin-top: 50px;">
         <div class="form-group">
            <label for="disabledSelect" class="col-md-4 control-label">Product :</label>
            <div class="col-md-5">
              <label>
                     {if $product}{$product}{/if}
              </label>
              <input type="hidden" name="product" value="{$product}"/>
              <input type="hidden" name="tid" value="{$tid}"/>
            </div>
          </div>
          <div class="form-group">
            <label for="type" class="col-md-4 control-label">Type :</label>
            <div class="col-md-5">
              <select class="form-control" name="type"  id="type">
                    <option value="9" {if $searchData.site.type == 9 || $searchData.skin.type == 9}selected{/if}>Dedicated</option>
                    <option value="11" {if $searchData.site.type == 11 || $searchData.skin.type == 11}selected{/if}>VPS</option>
              </select>
            </div>
          </div>
           <div class="form-group">
            <label for="mip" class="col-md-4 control-label">Main IP :</label>
            <div class="col-md-5">
              <input type="text" class="form-control" name="mip"  id="mip" value="{if $searchData.site}{$searchData.site.mip}{else if $searchData.skin}{$searchData.skin.mip}{/if}" />
            </div>
          </div>
          <div class="form-group">
            <label for="sip" class="col-md-4 control-label">Second IP :</label>
            <div class="col-md-5">
              <input type="text" class="form-control" name="sip"  id="sip" value="{if $searchData.site}{$searchData.site.sip}{else if $searchData.skin}{$searchData.skin.sip}{/if}" />
            </div>
          </div>
          <div class="form-group">
            <label for="exp" class="col-md-4 control-label">Expire :</label>
            <div class="col-md-5">
              <input type="date" class="form-control" name="exp"  id="exp" value="{if $searchData.site}{$searchData.site.exp}{else if $searchData.skin}{$searchData.skin.exp}{/if}" />
            </div>
          </div>
         <div class="text-center">
              <button type="submit" class="btn btn-primary" >Update</button>
              <a onclick="deleteCon()" href="#" class="btn btn-danger">Delete</a>
              <a href="?cmd=module&module={$module}" class="btn">Back</a>
         </div> 
     </form>
     {literal} 
     <script type="text/javascript">
         function deleteCon(){
             var r = confirm("Do you want to delete this?");
             if(r)
                 window.location.assign("?cmd=module&module={/literal}{$module}{literal}&action=deleteLicence&product={/literal}{$product}{literal}&tid={/literal}{$tid}{literal}");
         }
     </script>
     {/literal} 