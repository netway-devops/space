<div class="row-fluid" style="padding: 0 20px 20px 20px;  background-color: #FFF;" > 
      <div class="container" >  
            <div class="row" style=" padding: 0 20px 0 20px;">
               <div class="span12 dynamic-content">
                    <center>
                        <h3 class="h3-title-content g-txt32 re-topic">เมื่อไหร่ควรใช้งาน Load Balancer ?  </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 20px;"></span>
                    </center>
                </div>
           </div>
            <div class="row" style=" padding: 30px  20px 0 20px;">
                 <div class="span6" style="text-align: center;">
                        <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-LB-min.jpg"    style="margin-bottom: 20px;"/> 
                 </div>
                 <div class="span6" style="padding: 170px 0 0 0;">
                    <p class="g-txt18" style="margin-bottom: 20px; line-height: normal;  text-align: left;">
                                                      เมื่อมีการเรียกเข้าใช้งานเว็บไซต์หรือ Application ในเวลาเดียวกันในปริมาณที่สูงมากๆ เกินกว่าที่ระบบจะรองรับไหว
                    </p>
                 </div>
           </div>        
            <div class="row" style=" padding: 0  20px 0 20px;">
                 <div class="span6" style="padding: 170px 0 0 0;">
                    <p class="g-txt18" style="margin-bottom: 20px; line-height: normal;  text-align: left;">
                                                      เมื่อเว็บเซิร์ฟเวอร์มีปัญหาล่มอยู่บ่อยๆทำให้ไม่สามารถเรียกใช้งานได้  
                    </p>
                 </div>
                 <div class="span6" style="text-align: center;">
                        <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-LB-1-min.png"    style="margin-bottom: 20px;"/> 
                 </div>                 
           </div>  
            <div class="row" style=" padding: 0  20px 0 20px;">
                 <div class="span6" style="text-align: center;">
                      <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-LB-2-min.jpg"    style="margin-bottom: 20px;"/> 
                  
                 </div> 
                 <div class="span6" style="padding: 150px 0 0 0;">
                                           <p class="g-txt18" style="margin-bottom: 40px; line-height: normal;  text-align: center;">
                        ใช้คุณสมบัติของ Load Balancer มาทำหน้าที่ในการเป็น DDOS Protection ให้กับระบบของเว็บไซต์หรือ Application
                      </p>
                 </div>
           
            </div> 
               <hr/> 
           <div class="row" style=" padding: 30px  20px 20px 20px;">
               <div class="span12 dynamic-content">
                    <center>
                        <h3 class="h3-title-content g-txt32 re-topic">  แนวทางการแก้ไขปัญหา คือ  </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 40px;"></span>
                    </center>
                    <p class="g-txt18" style="margin-bottom: 20px; line-height: normal;  text-align: justify;">
                                                   การทำ Load Balancer อย่างน้อยหนึ่งตัว วางหน้า Server ที่เป็น Web Server เพื่อรองรับ Request จาก User เมื่อมี Request เข้ามา ตัว Load Balancer จะทําการ Forward Request ไปยัง Serverโดยเป็นการกระจายแบ่งตามเซิร์ฟเวอร์ที่มีอยู่ให้สมดุลและสามารถตรวจสอบและนับจำนวนคนเข้าชมเว็บไซต์ได้อีกด้วย 
                    </p>
                </div>
           </div>
            <div class="row" style=" padding: 0  20px 0 20px;">
                 <div class="span12" style="text-align: left;">
                        <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-LB-3-Layer4-min.jpg"    style="margin-bottom: 20px;"/> 
                      <p class="g-txt18" style="margin-bottom: 20px; line-height: 24px;  text-align: justify;">
                          <b>Load Balancer Layer 4 </b> จะมองเห็นข้อมูลเครือข่าย Protocol (TCP / UDP) Load Balancer Traffic โดยรวมข้อมูลเครือข่ายที่ จำกัด นี้เข้ากับอัลกอริธึม เช่น Round-Robin, LeastConnection และโดยการคำนวณเซิร์ฟเวอร์ปลายทางที่ดีที่สุดตามการเชื่อมต่อน้อยที่สุดหรือเวลาตอบสนองของเซิร์ฟเวอร์  
                      </p>
                 </div>            
            </div> 
            <div class="row" style=" padding: 20px  20px 0 20px;">
                 <div class="span12" style="text-align: left;">
                        <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-LB-3-Layer7.3-min.jpg"    style="margin-bottom: 20px;"/> 
                      <p class="g-txt18" style="margin-bottom: 20px; line-height: 24px;  text-align: justify;">
                          <b>Load Balancer Layer 7 </b>การทำงานในระดับ Application และสามารถใช้ข้อมูล Application เพิ่มเติมนี้เพื่อทำการตัดสินใจในการทำ Load Balancer ที่ซับซ้อนและมีข้อมูลมากขึ้น ด้วยโปรโตคอลเช่น HTTP, HTTPS โดย Load Balancer Layer 7 สามารถระบุ Session Client ตามคุกกี้และใช้ข้อมูลนี้เพื่อส่งคำขอ Client ทั้งหมดไปยัง Server เดียวกัน  
                      </p>
                 </div>            
            </div>   
          
                 
    </div>
</div> 
