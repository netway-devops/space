{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'tags.tpl.php');
$oAdmin     = hbm_logged_admin();
$this->assign('oAdmin',$oAdmin);
{/php}

{literal}
<style>
     #custom-search-form {
        margin:0;
        margin-top: 5px;
        padding: 0;
    }
 
        padding-right: 3px;
        padding-right: 4px \9;
        padding-left: 3px;
        padding-left: 4px \9;
        /* IE7-8 doesn't have border-radius, so don't indent the padding */
 
        margin-bottom: 0;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
    }
 
    #custom-search-form button {
        border: 0;
        background: none;
        /** belows styles are working good */
        padding: 2px 5px;
        margin-top: 2px;
        position: relative;
        left: -28px;
        /* IE7-8 doesn't have border-radius, so don't indent the padding */
        margin-bottom: 0;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
    }
 
    .search-query:focus + button {
        z-index: 3;   
    }
    input[type="search"].txt-kb {
        width: 205px;
        height: 25px;
        font-size: 16px;
        font-weight: 100;
        border-radius: 30px;
        margin-top: 15px;   
        border-color: #c7c7c7;

    }
     input[type="text"].search-tag {
        width: 270px;
        height: 32px;
        font-size: 16px;
        font-weight: 100;
        border-radius: 30px;
        margin-top: 15px;   
        border-color: #c7c7c7;
    }
     input[type="text"].search-tag:focus{
         border-color:dodgerBlue;
         box-shadow:0 0 8px 0 dodgerBlue;
    }
    
    .inputWithIcon input[type=text]{
    padding-left:45px;
  }
  
  .inputWithIcon{
    position:relative;
  }
  
  .inputWithIcon i{
    position:absolute;
    left:0;
    padding: 8px 18px;
    color:#aaa;
    transition:.3s;
    font-size: 20px;
  }
  .inputWithIcon input[type=text]:focus + i{
    color:dodgerBlue;
  }

    .btn-search {
        border: none;
        color: #FFFFFF;
        background-color: #1473e6;
        padding: 8px 27px;
        font-size: 16px;
        font-weight: 600;
        text-decoration: none;
        margin-top: 15px;
        border-radius: 30px;
    }
    .btn-search:hover {
        border: none;
        color: #FFFFFF;
        background-color: #3899e4;
        padding: 8px 27px;
        font-size: 16px;
        font-weight: 600;
        text-decoration: none;
        margin-top: 15px;
        border-radius: 30px;

    }

   
      @media only all and (max-width: 768px) {
          section.hero {
            background: #FC466B;
            background: -webkit-linear-gradient(to right, #3F5EFB, #FC466B); 
            background: linear-gradient(to right, #3F5EFB, #FC466B);
        height:200px;
        }  
    }
     @media only all and (max-width: 480px) {  
        section.hero {
            background: #FC466B;
            background: -webkit-linear-gradient(to right, #3F5EFB, #FC466B); 
            background: linear-gradient(to right, #3F5EFB, #FC466B);
            height:200px;
        }
    }  
    .re-txt-banner {
        font-size  : 46px; 
        font-family: 'Prompt', sans-serif; 
        font-style : normal;
        font-weight: 700;
        color      : #FFFFFF;
        margin-top : 185px;
        text-shadow: 2px 2px 4px #0b58ad;
        letter-spacing : 2px;
        
    }
        
   
    .nw-banner {
        color: #FFFFFF;
        text-align: center;
        font-size: 35px;
        font-family: 'Prompt', sans-serif;
        font-weight: bold;
        line-height: 40px;    
        background-color: transparent;
    }
     section.hero {
            background-image: url('https://netway.co.th/templates/netwaybysidepad/images/bg-all-categorys.png');
            background-position: top center;
            background-repeat: no-repeat;
            height: 475px;
            padding: 0 20px;
            text-align: center;
            width: 100%;
        }
        
        @media only all and (max-width: 768px) {
          section.hero {
           /*background: linear-gradient(to right, #ec2F4B, #009FFF);*/
        background-image: url('https://netway.co.th/templates/netwaybysidepad/images/bg-all-categorys.png');
        background-size: 108%;  
        height:200px;
        }  
    }
     @media only all and (max-width: 480px) {  
        section.hero {
        /*background: linear-gradient(to right, #ec2F4B, #009FFF);*/
        background-image: url('https://netway.co.th/templates/netwaybysidepad/images/bg-all-categorys.png');
        background-size: 108%;  
        height:200px;
        }
    }  
    
    hr.category {
    margin: 12px 275px 12px 70px;
    border: 0;
    border-top: 3px solid #eeeeee;
    border-bottom: 1px solid #ffffff;
}
     
     .nav li.active {
         font-size:18px;
     }
   
      
</style>   
<script>
$(document).ready(function(){
    
      $("#myInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#myTable tr").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
       
      });
      
      $("#myInputPhone").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#myTablephone tr").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
       
      });
      
    $('#myTab a').on('click', function (e) {
        e.preventDefault()
        $(this).tab('show')
    });
 $('#myTabphone a').on('click', function (e) {
        e.preventDefault()
        $(this).tab('show')
    });
});  
</script>


{/literal}
{if $oAdmin.id}
<div class="row-fluid hidden-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #e4edff;height: 85px;margin-bottom: 30px;">
        <div class="container">
         <div class="row">
            <div class="span6">  
                <div style="padding: 30px 10px 40px 10px; width: 700px;">
                    <p style="font-weight: normal; color: #a3c1ff;font-size: 20px;">{$pathway}</p> 
                </div>
            </div> 
             <div class="span6" style="padding: 9px 0 20px 0;">
                <nav class="navbar navbar-light bg-light  pull-right " style="z-index: 0;">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 100%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                        color: #000;font-size: 14px;margin-left: 0;" name="utf8" type="hidden" value="✓">  
                        <input class="form-control mr-sm-2 txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="   ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off">
                        <button class=" btn-search" type="submit">ค้นหา</button>
                    </form>
                </nav>
            </div>
          </div>
        </div>
    </div>
</div>
<div class="row-fluid visible-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #e4edff;height:55px;">
        <div class="container">
         <div class="row">
            <div class="span6">  
                <div style="padding: 15px 0px 20px 3px; ">
                    <p style="color: #a3c1ff;font-size: 18px;">{$pathway}</p> 
                </div>
            </div> 
             <div class="span6">
                <nav class="navbar-light bg-light  pull-left " style="z-index: 0;margin-left: 20px">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 100%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                               color: #000;font-size: 14px;margin-left: 0;" name="utf8" type="hidden" value="✓">  
                        <input class="form-  var toc     = $('.content').find('[TOC]');control mr-sm-2 txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="   ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off">
                        <button class=" btn-search" type="submit" style="padding: 8px 22px;">ค้นหา</button>
                    </form>
                </nav>
            </div>
          </div>
        </div>
    </div>
</div>   


<div class="row-fluid hidden-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #FFFFFF;height: 85px;margin-top: 0px;">
        <div class="container">
          <div class="row">
              <div class="span6 ">     
                   <div class="inputWithIcon">
                       <input  id ="myInput" class="search-tag" type="text" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query"  placeholder="  Filter by tag name" autocomplete="off" style="margin-top:0px; border-radius: 3px;">
                       <i class="fa fa-search fa-lg fa-fw" aria-hidden="true"></i>
                    </div>
              </div>
              <div class="span6 hidden-phone">   
                 <div class="row pull-right">  
                 <ul class="nav nav-pills mb-3 " id="myTab" role="tablist">
                      <li class="nav-item active" style=" border-radius: 6px;border: 1px solid #1473e6; color:#000;margin-right: 5px;" > 
                        <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#popularTag" role="tab" aria-controls="pills-profile" aria-selected="false"
                        style="margin-top: 0px;margin-bottom: 0px;margin-right: 0px;">
                            <i class="fa fa-tags pull-left" aria-hidden="true"></i>  Popular
                        </a> 
                      </li>
                      <li class="nav-item" style=" border-radius: 6px;border: 1px solid #1473e6; color:#000;margin-right: 5px;" >
                        <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#nameTag" role="tab" aria-controls="pills-contact" aria-selected="false"
                         style="margin-top: 0px;margin-bottom: 0px;margin-right: 0px;">
                           
                           <i class="fa fa-tags pull-left" aria-hidden="true"></i>  Name  
                        </a>
                      </li>
                      <li class="nav-item" style=" border-radius: 6px;border: 1px solid #1473e6; color:#000;margin-right: 5px;" >
                        <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#newTag" role="tab" aria-controls="pills-contact" aria-selected="false"
                         style="margin-top: 0px;margin-bottom: 0px;margin-right: 0px;">
                           <i class="fa fa-tags pull-left" aria-hidden="true"></i>  New 
                        </a>
                      </li>
                  </ul>
                </div>
            </div>
       </div>
     </div>
  </div>
</div>  

<div class="row-fluid visible-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #FFFFFF;margin-top: 40px;">
        <div class="container">
          <div class="row">
              
            <div class="span6  ">   
               <div class="row ">  
                   <ul class="nav nav-pills mb-3 " id="myTabphone" role="tablist" style="padding: 0px 15px;">    
                       <li class="nav-item active" style=" border-radius: 6px;border: 1px solid #1473e6;color:#000;margin-right: 5px;" > 
                          <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#popularTagphone" role="tab" aria-controls="pills-profile" aria-selected="false"
                          style="margin-top: 0px;margin-bottom: 0px;margin-right: 0px;">
                              <i class="fa fa-tags pull-left" aria-hidden="true"></i>  Popular
                          </a> 
                       </li>
                       <li class="nav-item" style=" border-radius: 6px;border: 1px solid #1473e6; color:#000;margin-right: 5px;" >
                          <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#nameTagphone" role="tab" aria-controls="pills-contact" aria-selected="false"
                          style="margin-top: 0px;margin-bottom: 0px;margin-right: 0px;">
                             <i class="fa fa-tags pull-left" aria-hidden="true"></i>  Name  
                          </a>
                       </li>
                       <li class="nav-item" style=" border-radius: 6px;border: 1px solid #1473e6; color:#000" >
                          <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#newTagphone" role="tab" aria-controls="pills-contact" aria-selected="false"
                          style="margin-top: 0px;margin-bottom: 0px;margin-right: 0px;">
                             <i class="fa fa-tags pull-left" aria-hidden="true"></i>  New 
                          </a>
                       </li>
                  </ul>
                  <div class="row ">  
                     <div class="span6 " style="margin-top: 50px"> 
                          <div class="inputWithIcon">     
                             <input  id ="myInputPhone" class="search-tag" type="text" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query"  placeholder="  Filter by tag name" autocomplete="off" style="margin-top:-36px;border-radius: 3px;margin-left: 20px;">
                             <i class="fa fa-search fa-lg fa-fw" aria-hidden="true" style="top:-28px;padding-left: 38PX;" ></i>
                           </div>
                         
                     </div>
                </div>
            </div>
         </div>
       </div>
     </div>
  </div>
</div> 

<div class="tab-content hidden-phone"> 
  <div class="tab-pane  hidden-phone active" id="popularTag" >       
     <div class="row-fluid white-kb-2018" style="margin-bottom: 50px;" > 
            <div class="row">
                <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight:300;">Popular Tags</h3>
                <span class="nw-2018-content-line" style="margin-bottom: 60px;"></span></center>  
            </div>
              <div class="container hidden-phone">
               <table style="margin-bottom: 15px;">
                  <tbody style="font-size: 16px;">
                    <tr style="border-bottom: 2px solid #1473e6;">
                        <td  style="width: 150px;padding-bottom:7px;">
                           ชื่อ Tags
                       </td>
                      <td  style="width: 118px;padding-bottom:7px;">
                          จำนวน Articles        
                      </td>
                      <td style="width: 149px;padding-bottom:7px;">
                           ชื่อ Tags 
                      </td>
                      <td style="width: 119px;padding-bottom:7px;">
                           จำนวน Articles        
                       </td> 
                       <td style="width: 216px;padding-bottom:7px;">
                           ชื่อ Tags 
                      </td>
                      <td  style="width: 121px;padding-bottom:7px;">
                           จำนวน Articles        
                       </td> 
                       <td  style="width: 174px;padding-bottom:7px;" >
                           ชื่อ Tags 
                      </td>
                      <td style="width: 115px;padding-bottom:7px;" >
                           จำนวน Articles        
                       </td> 
                    </tr>
                  </tbody>
                </table>
            </div>
            
            {if $aTagPopular|@count}           
                <div class="container hidden-phone">
                    <div class=" section-tree ">      
                         <table style="width: 100%"  >                               
                               <tbody id='myTable' style="width: 100%;font-size: 18px;line-height: 22px;">
                                {assign var=val value=0}           
                                {foreach from=$aTagPopular key=pTag item=popTag}
                                         {if $val == 0 }
                                             <tr> 
                                        {/if}
                                        {assign var=val value=$val+1}
                                         
                                             <td style='width: 10%' >
                                                  <i class="fa fa-tag " aria-hidden="true" style="color:#adb4c3;"></i>   
                                                <a href="{$ca_url}/tag_article?nameTag={$popTag.name}" >
                                                     {$popTag.name} 
                                                </a>
                     
                                                
                                             </td>
                                             <td style="text-align:center; width: 10%; padding: 6px 0px;">
                                               <a href="{$ca_url}/tag_article?nameTag={$popTag.name}" style="color: #0052cd;">   
                                              {$popTag.total_article}
                                              </a>
                                            </td>   
                                        {if $val == 4}     
                                        </tr>
                                        {assign var=val value=0}
                                      {/if} 
                                 {/foreach}      
                         </tbody>
                     </table>               
                    </div>
                </div>  
            {/if}         
        </div>     
    </div>   

     <div class="tab-pane hidden-phone" id="nameTag" > 
      <div class="row-fluid white-kb-2018" style="margin-bottom: 50px;">     
            <div class="row ">
                <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight:300;">Name Tags </h3>
                <span class="nw-2018-content-line" style="margin-bottom: 60px;"></span></center>  
            </div>
              <div class="container hidden-phone">
                <table style="margin-bottom: 15px;">
                   <tbody style="font-size: 16px">
                    <tr style="border-bottom: 2px solid #1473e6;">
                        <td  style="width: 340px;padding-bottom:7px;">
                           ชื่อ Tags
                       </td>
                    <td style="width: 165px;padding-bottom:7px;">
                           จำนวน Articles       
                    </td>
                      <td style="width: 274px;padding-bottom:7px;">
                           ชื่อ Tags 
                      </td>
                      <td style="width: 165px;padding-bottom:7px;">
                        จำนวน Articles       
                      </td>
                       <td  style="width: 232px;padding-bottom:7px;">
                           ชื่อ Tags 
                      </td>
                      <td style="width: 153px;padding-bottom:7px;">
                        จำนวน Articles       
                      </td>
                       <td style="width: 217px;padding-bottom:7px;" >
                           ชื่อ Tags 
                      </td>
                       <td style="width: 135px;padding-bottom:7px;">
                        จำนวน Articles       
                      </td>
                    </tr>
                </table>
            </div>
            
            {if $aTagName|@count}           
                <div class="container ">
                    <div class=" section-tree ">      
                         <table style="width: 100%"  >                               
                               <tbody id="myTable" style="width: 100%;font-size: 18px;line-height: 22px;">
                                {assign var=val value=0}           
                                {foreach from=$aTagName key=naTag item=nameTag}
                                         {if $val == 0 }
                                             <tr>
                                        {/if}
                                        {assign var=val value=$val+1}
                                             <td style="width: 10%" >
                                                <i class="fa fa-tag " aria-hidden="true"  style="color:#adb4c3;"></i>   
                                                <a href="{$ca_url}/tag_article?nameTag={$nameTag.name}">
                                                    {$nameTag.name}
                                                 </a>
                                             </td>
                                             <td style="text-align:center; width: 10%; padding: 6px 0px;">
                                                <a href="{$ca_url}/tag_article?nameTag={$nameTag.name}" style="color: #0052cd;">
                                                 {$nameTag.total_article}
                                                </a>
                                            </td>   
                                        {if $val == 4}     
                                        </tr>
                                        {assign var=val value=0}
                                      {/if} 
                                 {/foreach}      
                         </tbody>
                     </table>               
                    </div>
                </div>  
            {/if}         
        </div> 
    </div> 
    
    
    <div class="tab-pane hidden-phone" id="newTag" >     
     <div class="row-fluid white-kb-2018" style="margin-bottom: 50px;" > 
          <div class="row ">
                <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight:300;">New Tags </h3>
                <span class="nw-2018-content-line" style="margin-bottom: 60px;"></span></center>  
            </div>
              <div class="container hidden-phone">
                <table style="margin-bottom: 15px;">
                    <tbody style="font-size: 16px">
                        <tr style="border-bottom: 2px solid #1473e6;">
                            <td style="width: 134px;padding-bottom:7px;">
                               ชื่อ Tags
                           </td>
                          <td style="width: 109px;padding-bottom:7px;">
                              จำนวน Articles       
                          </td>
                          <td style="width: 188px;padding-bottom:7px;">
                               ชื่อ Tags 
                          </td>
                          <td  style="width: 109px;padding-bottom:7px;">
                               จำนวน Articles       
                           </td> 
                           <td style="width: 248px;padding-bottom:7px;">
                               ชื่อ Tags 
                          </td>
                          <td style="width: 109px;padding-bottom:7px;">
                               จำนวน Articles       
                           </td> 
                           <td style="width: 165px;padding-bottom:7px;" >
                               ชื่อ Tags 
                          </td>
                          <td  style="width: 105px;padding-bottom:7px;" >
                               จำนวน Articles     
                           </td> 
                        </tr>
                   </tbody>  
                </table>
            </div>
            
            {if $aTagNew|@count}           
                <div class="container ">
                    <div class=" section-tree ">      
                         <table style="width: 100%"  >                               
                               <tbody id="myTable" style="width: 100%;font-size: 18px;line-height: 22px;">
                                {assign var=val value=0}           
                                {foreach from=$aTagNew key=nTag item=newTag}
                                         {if $val == 0 }
                                             <tr>
                                            
                                        {/if}
                                        {assign var=val value=$val+1}
                                             <td style="width: 10%" >
                                                  <i class="fa fa-tag " aria-hidden="true" style="color:#adb4c3;"></i>   
                                                  <a href="{$ca_url}/tag_article?nameTag={$newTag.name}">
                                                    {$newTag.name}
                                                 </a>
                                             </td>
                                             <td style="text-align:center; width: 10%; padding: 6px 0px;">
                                               <a href="{$ca_url}/tag_article?nameTag={$newTag.name}" style="color: #0052cd;"> 
                                                   {$newTag.total_article}
                                               </a>
                                            </td>   
                                        {if $val == 4}     
                                        </tr>
                                        {assign var=val value=0}
                                      {/if} 
                                 {/foreach}      
                         </tbody>
                     </table>               
                    </div>
                </div>  
            {/if}         
        </div> 
      </div>
</div>     

<!-------------------visible-phone --------------->

  
<div class="tab-content visible-phone"> 
    <div class="tab-pane active" id="popularTagphone">    
      <div class="row-fluid white-kb-2018" > 
        <div class="row ">
            <center>
                <h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight:300;">Popular Tags</h3>
                <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>
            </center>  
       </div>
        <div class="container" style="padding: 0px 25px;">
            <div class="row">
                <section class="section-content">
                    <table style="margin-bottom: 15px;width:100%">
                        <tbody style="font-size: 16px">
                             <tr style="border-bottom: 2px solid #1473e6;">
                                <td >
                                    <div class="span2 "> 
                                        ชื่อ Tags
                                    </div>
                                </td>
                                <td >
                                    <div class="span2 "style="text-align: right;"> 
                                        จำนวน Articles
                                    </div>  
                                </td>
                             </tr>
                        </tbody>  
                    </table>        
                </section>
            </div>
            <div class="row">
                <table style="width: 100%"  >      
                    <tbody id="myTablephone" style="width: 100%;font-size: 16px;line-height: 18px;">
                        {assign var=val value=0}  
                        {foreach from=$aTagPopular key=pTag item=popTag} 
                        {if $val == 0 }
                        <tr>
                        {/if}
                        {assign var=val value=$val+1}  
                            <td>
                                <div class="span2 "> 
                                    <i class="fa fa-tag " aria-hidden="true"style="color:#adb4c3;"></i>&nbsp;
                                    <a href="{$ca_url}/tag_article?nameTag={$popTag.name}">{$popTag.name}</a>   
                                </div>
                            </td>
                            <td>
                                <div class="span2 "> 
                                    <a href="{$ca_url}/tag_article?nameTag={$popTag.name}"style="color: #0052cd;">{$popTag.total_article} </a>     
                                </div> 
                            </td>
                        {if $val == 1}     
                        </tr>
                        {assign var=val value=0}
                        {/if} 
                        {/foreach}   
                    </tbody>      
                </table>
            </div>
        </div>
    </div>
  </div> 
    <div class="tab-pane " id="nameTagphone" >    
        <div class="container" style="padding: 0px 25px;">
           <div class="row-fluid white-kb-2018" > 
             <div class="row">
                <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight:300;">Name Tags </h3>
                <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>  
            </div>
            <div class="row">
                <section class="section-content">
                    <table style="margin-bottom: 15px; width: 100%">
                        <tbody style="font-size: 16px">
                             <tr style="border-bottom: 2px solid #1473e6;">
                                <td >
                                    <div class="span2 "> 
                                        ชื่อ Tags
                                    </div>
                                </td>
                                <td >
                                    <div class="span2 "style="text-align: right;"> 
                                        จำนวน Articles
                                    </div>  
                                </td>
                             </tr>
                        </tbody>  
                    </table>        
                </section>
            </div>
            <div class="row">
                <table style="width: 100%"  >      
                    <tbody id="myTablephone" style="width: 100%;font-size: 16px;line-height: 18px;">
                        {assign var=val value=0}  
                        {foreach from=$aTagName key=naTag item=nameTag}
                        {if $val == 0 }
                        <tr>
                        {/if}
                        {assign var=val value=$val+1}  
                            <td>
                                <div class="span2 "> 
                                    <i class="fa fa-tag " aria-hidden="true" style="color:#adb4c3;"></i>&nbsp;
                                    <a href="{$ca_url}/tag_article?nameTag={$nameTag.name}">{$nameTag.name}</a>   
                                </div>
                            </td>
                            <td>
                                <div class="span2 "> 
                                    <a href="{$ca_url}/tag_article?nameTag={$nameTag.name}"style="color: #0052cd;">{$nameTag.total_article} </a>     
                                </div> 
                            </td>
                        {if $val == 1}     
                        </tr>
                        {assign var=val value=0}
                        {/if} 
                        {/foreach}   
                    </tbody>      
                </table>
            </div>
        </div>
    </div>
   </div> 
    <div class="tab-pane " id="newTagphone" >  
        <div class="container" style="padding: 0px 25px;">
          <div class="row-fluid white-kb-2018"  > 
             <div class="row">
                <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight:300;">New Tags </h3>
                <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>  
            </div>      
            <div class="row">
                <section class="section-content">
                    <table style="margin-bottom: 15px;width: 100%">
                        <tbody style="font-size: 16px">
                             <tr style="border-bottom: 2px solid #1473e6;">
                                <td >
                                    <div class="span2 "> 
                                        ชื่อ Tags
                                    </div>
                                </td>
                                <td >
                                    <div class="span2 "style="text-align: right;"> 
                                        จำนวน Articles
                                    </div>  
                                </td>
                             </tr>
                        </tbody>  
                    </table>        
                </section>
            </div>
            <div class="row">
                <table style="width: 100%"  >      
                    <tbody id="myTablephone" style="width: 100%;font-size: 16px;line-height: 18px;">
                        {assign var=val value=0}  
                        {foreach from=$aTagNew key=nTag item=newTag}
                        {if $val == 0 }
                        <tr>
                        {/if}
                        {assign var=val value=$val+1}  
                            <td>
                                <div class="span2 "> 
                                    <i class="fa fa-tag " aria-hidden="true"style="color:#adb4c3;"></i>&nbsp;
                                    <a href="{$ca_url}/tag_article?nameTag={$newTag.name}">{$newTag.name}</a>   
                                </div>
                            </td>
                            <td>
                                <div class="span2 "> 
                                    <a href="{$ca_url}/tag_article?nameTag={$newTag.name}"style="color: #0052cd;">{$newTag.total_article} </a>     
                                </div> 
                            </td>
                        {if $val == 1}     
                        </tr>
                        {assign var=val value=0}
                        {/if} 
                        {/foreach}   
                    </tbody>      
                </table>
            </div>
        </div>
      </div>
    </div> 
</div>
{else}
<div class="row-fluid">
    <div class="span12 dynamic-content bg-gs-wn">
        <div class="container">
         <div class="row">
            <div class="span6">  
                <div style="padding: 15px 0px 20px 3px; ">
                    <p style="color: #000000;font-size: 18px;"><strong style="color: red">**</strong>คุณไม่สามารถดูหน้านี้ได้เนื่องจาก User ของคุณไม่ใช่ Staff</p> 
                </div>
            </div>     
          </div>
        </div>
    </div>
</div>   

{/if}


