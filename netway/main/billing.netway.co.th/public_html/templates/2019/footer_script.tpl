<!-- call crisp shat-->
{literal}
<script type="text/javascript">window.$crisp=[];window.CRISP_WEBSITE_ID="928dc456-d257-4727-9fd7-ab9c055607fb";(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();</script>
{/literal}
<!-- function call zohoform-->
<div id="formModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
    <div class="modal-header">
        <h4 id="formModalLabel">กรุณาให้ข้อมูลเพิ่มเติม</h4>
    </div>
    <div class="modal-body">
        <div id="zf_div_lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og"></div>

        {literal}
        <script type="text/javascript">
        (function() {
                try{
                    var f = document.createElement("iframe");   
                    f.src = 'https://forms.zohopublic.com/netwaycommunication/form/Support/formperma/lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og?zf_rszfm=1';
                    f.style.border="none";                                           
                    f.style.height="554px";
                    f.style.width="99%";
                    f.style.transition="all 0.5s ease";// No I18N
                    var d = document.getElementById("zf_div_lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og");
                    d.appendChild(f);
                    window.addEventListener('message', function (){
                        var zf_ifrm_data = event.data.split("|");
                        var zf_perma = zf_ifrm_data[0];
                        var zf_ifrm_ht_nw = ( parseInt(zf_ifrm_data[1], 10) + 15 ) + "px";
                        var iframe = document.getElementById("zf_div_lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og").getElementsByTagName("iframe")[0];
                        if ( (iframe.src).indexOf('formperma') > 0 && (iframe.src).indexOf(zf_perma) > 0 ) {
                            var prevIframeHeight = iframe.style.height;
                            if ( prevIframeHeight != zf_ifrm_ht_nw ) {
                                iframe.style.height = zf_ifrm_ht_nw;
                            }   
                        }
                    }, false);
                }catch(e){}
                }
            )();
        </script>
        {/literal}
        <!--if set Email Crisp-->
        {literal}
        <script>
        var zohoFormId      = 'zf_div_lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og';
        var zohoFormUrl     = 'https://forms.zohopublic.com/netwaycommunication/form/Support/formperma/lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og?zf_rszfm=1';
        var sessionId       = '';
        var loadForm        =  sessionStorage.getItem("loadForm")? sessionStorage.getItem("loadForm"):1;
        var clientEmail     = {/literal}"{$aClient.email}"{literal};
        var clientName      = {/literal}"{$aClient.firstname} {$aClient.lastname}"{literal};

        $crisp.push(['on', 'session:loaded', function (session_id) {
            sessionId       = session_id;
             console.log('sessionId= '+sessionId);
            if(sessionId == ''){
                sessionId = $crisp.get("session:identifier"); 
            }
              
            if(sessionId != ''){
                var email = null;//$crisp.get("user:email")
                if(email == null && clientEmail !=''){  
                   if(loadForm == 1){
                        loadForm = 2;
                        sessionStorage.setItem("loadForm", loadForm);
                   } 
                    $crisp.push(["set", "user:email", [{/literal}"{$aClient.email}"{literal},{/literal}"{$emailSignature}"{literal}]]);
                    $crisp.push(["set", "user:nickname", [{/literal}"{$aClient.firstname} {$aClient.lastname}"{literal}]]);
                    $crisp.push(["set", "user:phone", [{/literal}"{$aClient.phonenumber}"{literal}]]); 
                    $crisp.push(["set", "session:segments", [["hostbill client"]]]);       
                    $crisp.push(["set", "user:company", [{/literal}"{$aClient.companyname}"{literal}]]);
                }

            } 

        }]);
        
        //on message sent
        $crisp.push(["on", "message:sent", function () {
           
            if (loadForm != 2 ){
                return true;
            }
            
            loadForm = 0;
            sessionStorage.setItem("loadForm", loadForm);
            
            var dom     = document.getElementById(zohoFormId).querySelector('iframe');
                dom.src     = zohoFormUrl +'&session_id='+ sessionId +'&email='+ encodeURIComponent(clientEmail) +'&name='+ encodeURIComponent(clientName);           
                    $('#formModal').modal({
                        show: true,
                        keyboard: false,
                        backdrop: 'static'
                    });
                $crisp.push(['do', 'chat:close']);   
        }]);

        //mail change
        $crisp.push(['on', 'user:email:changed', function (email) {

            if (loadForm == 1) {
                loadForm = 0;
                sessionStorage.setItem("loadForm", loadForm);

                var dom     = document.getElementById(zohoFormId).querySelector('iframe');
                dom.src     = zohoFormUrl +'&session_id='+ sessionId +'&email='+ encodeURIComponent(email);           
                    $('#formModal').modal({
                        show: true,
                        keyboard: false,
                        backdrop: 'static'
                    });
                $crisp.push(['do', 'chat:close']);              
            
            } 
        }]);

        //chat crisp when zohoform submit
        $crisp.push(['on', 'message:received', function (data) {
            if (data.content !== 'สักครู่นะครับ') {
                return true;
            }

            $('#formModal').modal('hide');
            $crisp.push(['do', 'chat:open']);
        }]);

        </script>
        {/literal}
    </div>
</div>
<!-- End script Crisp chat -->