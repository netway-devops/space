{literal}
    <style type="text/css">
        .button {
            background-color: #4CAF50;
            /* Green */
            border: none;
            color: white;
            padding: 6px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 10px 0% 0px 0%;
            transition-duration: 0.4s;
            cursor: pointer;
        }

        .button1 {
            background-color: #F0AD4E;
            color: white;
            border-radius: 50px;
            border: 2px solid white;
        }

        .button1:hover {
            background-color: #F0AD4E;
            color: white;
        }

        .button2 {
            background-color: white;
            color: black;
            border: 2px solid #008CBA;
        }

        .button2:hover {
            background-color: #008CBA;
            color: white;
        }

        .button3 {
            background-color: white;
            color: black;
            border: 2px solid #f44336;
        }

        .button3:hover {
            background-color: #f44336;
            color: white;
        }

        .button4 {
            background-color: white;
            color: black;
            border: 2px solid #e7e7e7;
        }

        .button4:hover {background-color: #e7e7e7;}

        .button5 {
            background-color: white;
            color: black;
            border: 2px solid #555555;
        }

        .button5:hover {
            background-color: #555555;
            color: white;
        }
    </style>

{/literal}
<a href="#">Cloud & Managed <span></span></a>
<div class="cbp-hrsub" style="height: 490px;">
    <div class="container">
        <div class="span3">

            <div class="img-nav-show" style="height: 130px">
                <img src="{$template_dir}images/Nav-Cloud-image-vector.png" />
            </div>
            <br />
                <!--เอาออกจากหน้าเว็บ <div class="row">
                <h4  class="nav-content" >Cloud & Managed</h4>
                <p class="nav-content txt14" style="text-align: justify;" >
                Cloud Computing เป็นเทคโนโลยีที่เปลี่ยนรูปแบบการทำงานบนคอมพิวเตอร์ขององค์กรไปสู่
                การเก็บข้อมูลและประมวลผลผ่านระบบของ Cloud Provider โดยใช้อินเทอร์เน็ต
                <p>
                </div>-->
            <br />
            <a href="{$smarty.const.CMS_URL}/cloud-comparison"><button class="btn-learnmore" style="margin-top: -20px; width : 240px;">&nbsp; &nbsp;Product Comparison &nbsp; &nbsp;</button> </a>
            <a href="{$smarty.const.CMS_URL}/datacenter"><button class="btn-learnmore" style="width : 240px;">&nbsp; &nbsp;Datacenter &nbsp; &nbsp;</button> </a>
            <a href="{$smarty.const.CMS_URL}/cloud"><button class="btn-learnmore" style="width : 240px;">&nbsp; &nbsp;เรียนรู้เพิ่มเติม &nbsp; &nbsp;</button> </a>
            <a href="{$smarty.const.CMS_URL}/kb/blog/cloud-&-managed-services/download-brochure"><button class="button button1" style="width : 240px;"><b>Download Brochure <i class="fa fa-download"></i></b></button> </a>
        </div>
        <div class="span1 border-left" style="margin-top:30px; height: 320px; margin-left: 50px;">
            <!-- ว่าง -->
        </div>
        <div class="span4" style="margin-top: 30px; margin-left: -10px;">
            <h4 class="title-nav txt20" style="color: #f0f0f0" ;>Linux Cloud VPS</h4>
            <span class="nav-line"></span>
            <br />
            <ul style="list-style : none;">
                <li class="txt16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/linux-vps"><i class="fa fa-angle-right" aria-hidden="true"></i> Linux VPS </a></li>
                <li class="txt16 top-margin">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/linux-vmware"><i class="fa fa-angle-right" aria-hidden="true"></i> Linux VMware </a></li>
                <li class="txt16 top-margin" style="color: #15489F;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/azure-server"><i class="fa fa-angle-right" aria-hidden="true"></i> Microsoft Azure</a></li>
            </ul>
            <br />
            <h4 class="title-nav txt20" style="margin-top: 0px;">Windows Cloud VPS </h4>
            <span class="nav-line"></span>
            <br />
            <ul style="list-style : none;">
                <li class="txt16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/windows-vps"><i class="fa fa-angle-right" aria-hidden="true"></i> Windows VPS </a></li>
                <li class="txt16 top-margin" style="color: #15489F;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/windows-vmware"><i class="fa fa-angle-right" aria-hidden="true"></i> Windows VMware </a></li>
                <li class="txt16 top-margin" style="color: #15489F;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/azure-server"><i class="fa fa-angle-right" aria-hidden="true"></i> Microsoft Azure</a></li>
            </ul>
            <br />
            <h4 class="title-nav txt20">Dedicated Server</h4>
            <span class="nav-line"></span>
            <br />
            <ul style="list-style : none;">
                <li class="txt16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/linux-dedicated-server"><i class="fa fa-angle-right" aria-hidden="true"></i> Linux Dedicated Server </a></li>
                <li class="txt16 top-margin" style="color: #15489F;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/windows-dedicated-server"><i class="fa fa-angle-right" aria-hidden="true"></i> Windows Dedicated Server</a></li>
            </ul>

        </div>

        <div class="span4" style="margin-top: 30px;    width: 340px;">
            <h4 class="title-nav txt20" style="margin-top:10px;">Virtual Private Cloud</h4>
            <span class="nav-line"></span>
             <br>
            <ul style="list-style : none;">
                <li class="txt16 top-margin">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/virtual-private-cloud"><i class="fa fa-angle-right" aria-hidden="true"></i> Virtual Private Cloud</a></li>
            <!--<li class="txt16 top-margin" style="width: 112%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/unified-server-management-platform"><i class="fa fa-angle-right" aria-hidden="true"></i> Unified Server Management Platform </a></li>-->

            </ul>
            <br />
            <h4 class="title-nav txt20" style="margin-top:15px;">Managed Server Services</h4>
            <span class="nav-line"></span>
            <br>
            <ul style="list-style : none;">
                <li class="txt16 top-margin">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/managed-server-services"><i class="fa fa-angle-right" aria-hidden="true"></i> Managed Server Services 1,500 บาท/ เดือน</a></li>
            <!--<li class="txt16 top-margin" style="width: 112%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/unified-server-management-platform"><i class="fa fa-angle-right" aria-hidden="true"></i> Unified Server Management Platform </a></li>-->

            </ul>


            <h4 class="title-nav txt20" style="margin-top: 25px;">Solution</h4>
            <span class="nav-line"></span>
            <ul style="list-style : none;">
                <li class="txt16 top-margin">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/loadbalance"><i class="fa fa-angle-right" aria-hidden="true"></i> Load Balancer </a></li>
                <li class="txt16 top-margin">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$smarty.const.CMS_URL}/cloud-file-sharing"><i class="fa fa-angle-right" aria-hidden="true"></i> Cloud File Sharing</a></li>
            </ul>

        </div>
    </div><!-- /cbp-hrsub-inner -->
</div><!-- /cbp-hrsub -->