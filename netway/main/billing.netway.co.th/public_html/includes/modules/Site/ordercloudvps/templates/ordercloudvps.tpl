
  {literal}
<style>
    #circularG{
        position:relative;
        width:128px;
        height:128px
    }

    .circularG{
        position:absolute;
        background-color:#000000;
        width:29px;
        height:29px;
        -moz-border-radius:19px;
        -moz-animation-name:bounce_circularG;
        -moz-animation-duration:1.04s;
        -moz-animation-iteration-count:infinite;
        -moz-animation-direction:linear;
        -webkit-border-radius:19px;
        -webkit-animation-name:bounce_circularG;
        -webkit-animation-duration:1.04s;
        -webkit-animation-iteration-count:infinite;
        -webkit-animation-direction:linear;
        -ms-border-radius:19px;
        -ms-animation-name:bounce_circularG;
        -ms-animation-duration:1.04s;
        -ms-animation-iteration-count:infinite;
        -ms-animation-direction:linear;
        -o-border-radius:19px;
        -o-animation-name:bounce_circularG;
        -o-animation-duration:1.04s;
        -o-animation-iteration-count:infinite;
        -o-animation-direction:linear;
        border-radius:19px;
        animation-name:bounce_circularG;
        animation-duration:1.04s;
        animation-iteration-count:infinite;
        animation-direction:linear;
    }

    #circularG_1{
        left:0;
        top:50px;
        -moz-animation-delay:0.39s;
        -webkit-animation-delay:0.39s;
        -ms-animation-delay:0.39s;
        -o-animation-delay:0.39s;
        animation-delay:0.39s;
    }

    #circularG_2{
        left:14px;
        top:14px;
        -moz-animation-delay:0.52s;
        -webkit-animation-delay:0.52s;
        -ms-animation-delay:0.52s;
        -o-animation-delay:0.52s;
        animation-delay:0.52s;
    }

    #circularG_3{
        top:0;
        left:50px;
        -moz-animation-delay:0.65s;
        -webkit-animation-delay:0.65s;
        -ms-animation-delay:0.65s;
        -o-animation-delay:0.65s;
        animation-delay:0.65s;  
    }

    #circularG_4{
        right:14px;
        top:14px;
        -moz-animation-delay:0.78s;
        -webkit-animation-delay:0.78s;
        -ms-animation-delay:0.78s;
        -o-animation-delay:0.78s;
        animation-delay:0.78s;
    }

    #circularG_5{
        right:0;
        top:50px;
        -moz-animation-delay:0.91s;
        -webkit-animation-delay:0.91s;
        -ms-animation-delay:0.91s;
        -o-animation-delay:0.91s;
        animation-delay:0.91s;
    }

    #circularG_6{
        right:14px;
        bottom:14px;
        -moz-animation-delay:1.04s;
        -webkit-animation-delay:1.04s;
        -ms-animation-delay:1.04s;
        -o-animation-delay:1.04s;
        animation-delay:1.04s;
    }

    #circularG_7{
        left:50px;
        bottom:0;
        -moz-animation-delay:1.17s;
        -webkit-animation-delay:1.17s;
        -ms-animation-delay:1.17s;
        -o-animation-delay:1.17s;
        animation-delay:1.17s;
    }

    #circularG_8{
        left:14px;
        bottom:14px;
        -moz-animation-delay:1.3s;
        -webkit-animation-delay:1.3s;
        -ms-animation-delay:1.3s;
        -o-animation-delay:1.3s;
        animation-delay:1.3s;
    }

    @-moz-keyframes bounce_circularG{
    0%{
    -moz-transform:scale(1)}
    
    100%{
    -moz-transform:scale(.3)}
    
    }
    
    @-webkit-keyframes bounce_circularG{
    0%{
    -webkit-transform:scale(1)}
    
    100%{
    -webkit-transform:scale(.3)}
    
    }
    
    @-ms-keyframes bounce_circularG{
    0%{
    -ms-transform:scale(1)}
    
    100%{
    -ms-transform:scale(.3)}
    
    }
    
    @-o-keyframes bounce_circularG{
    0%{
    -o-transform:scale(1)}
    
    100%{
    -o-transform:scale(.3)}
    
    }
    
    @keyframes bounce_circularG{
    0%{
    transform:scale(1)}
    
    100%{
    transform:scale(.3)}
    
    }


    {/literal}

</style>
<br><br><br>
<center>
    <div id="circularG">
        <div id="circularG_1" class="circularG">
        </div>
        <div id="circularG_2" class="circularG">
        </div>
        <div id="circularG_3" class="circularG">
        </div>
        <div id="circularG_4" class="circularG">
        </div>
        <div id="circularG_5" class="circularG">
        </div>
        <div id="circularG_6" class="circularG">
        </div>
        <div id="circularG_7" class="circularG">
        </div>
        <div id="circularG_8" class="circularG">
        </div>
    </div> 
    <h1>Loading</h1>
</center>

<script type="text/javascript">
    {literal}
       
            var url  = '{/literal}{$system_url}{literal}'+'index.php/' + '{/literal}{$linkToOrder}{literal}';            
            window.open(url , '_self');
{/literal}
</script>