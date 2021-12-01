{literal}
<script>
    var listluckyNumber =   [];
    $(document).ready(function(){
        
        $('.lucky-draw-button').click(function(){
            var maxRandomNumber = $('.lucky-draw-number').val();
            if(maxRandomNumber <= 0){ maxRandomNumber = 30; $('.lucky-draw-number').val(30); }
            var luckyNumber = randomNumber(maxRandomNumber);
        });
        
        $('.lucky-draw-reset').click(function(){
            
            if(confirm('มั่นใจ ?')){
                $('.lucky-draw-number').val(30);
                $('.lucky-draw-result').html('Lucky Number :');
                $('.lucky-draw-current').html(' ');
                listluckyNumber =   [];
            }
            
        });
        
    });
    
    function randomNumber(maxRandomNumber){
        
        intRandom = Math.floor((Math.random()* maxRandomNumber)+1);
        if(jQuery.inArray(intRandom, listluckyNumber) !== -1){
            if(listluckyNumber.length >= maxRandomNumber){ alert('สุ่มหมดทุกตัวเลขแล้ว'); return ; }
            randomNumber(maxRandomNumber);
        }else{
            listluckyNumber.push(intRandom);
            $('.lucky-draw-result').append(' [ ' + intRandom + ' ] ');
            $('.lucky-draw-current').html(intRandom);
            return intRandom;
        }
        
    }
</script>
<style>
  
.btn-lucky-submit {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    display: inline-block;
    box-sizing: content-box;
    background-color: #1abc9c;
    color: #fff;
    font-weight: 300;
    font-size: 18px;
    text-transform: uppercase;
    text-decoration: none;
    padding: 8px 20px;
    border-radius: 30px;
    outline: 0!important;
    border: 0;
    transition: all .2s ease-in-out;
    cursor: pointer;
    margin-right: 20px; 
}
.btn-lucky-submit:hover {
    background-color: #08c43a;
}

.btn-lucky-reset {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    display: inline-block;
    box-sizing: content-box;
    background-color: #fc8054;
    color: #fff;
    font-weight: 300;
    font-size: 18px;
    text-transform: uppercase;
    text-decoration: none;
    padding: 8px 20px;
    border-radius: 30px;
    outline: 0!important;
    border: 0;
    transition: all .2s ease-in-out;
    cursor: pointer;    
}
.btn-lucky-reset:hover {
    background-color: #f5541b;
}   
</style>
{/literal}
<div style="     background-image: url(https://netway.co.th/templates/netwaybysidepad/images/bg-netwayconnect-lucky-draw-min.png);
    height: 800px;
    background-attachment: fixed;
    background-repeat: no-repeat;
    background-size: cover; 
    
    
    ">
<div class="row" style="background: rgba(0, 0, 0, 0.7);  height: 800px;" >
    <div style="margin-top: 120px;">
    <div  align="center">
        <h3 style="color: #ffffff; font-weight: 300; font-size: 35px;">Lucky Draw Time!</h3> <input type="number" required="" value="30" class="lucky-draw-number " 
        style="height: 30px;   font-size: 24px; width: 450px; margin-bottom: 30px; margin-top: 5px; " />
    </div>
    <div class="" align="center">
        <button class="lucky-draw-button btn-lucky-submit" >Click for Random</button><button class="lucky-draw-reset btn-lucky-reset">Clear </button>
    </div>
    <div  align="center" style="padding: 30px 30px 0px 30px; ">
        <div><h1 class="lucky-draw-current" style="font-size: 120px !important; margin-top: 60px;  color: #ffffff;   text-shadow: 2px 2px 4px #212127;"> </h1></div>
    </div>
    <div class="" align="center" style="padding: 30px 30px 100px 30px;">
        <div><h4 class="lucky-draw-result" style="color: #FFF; font-size: 28px;  font-weight: 100; margin-top: 30px; line-height: normal;  padding: 0 60px 0 60px;">The Winners Are : </h4></div>
    </div>
    </div>
</div>
</div>