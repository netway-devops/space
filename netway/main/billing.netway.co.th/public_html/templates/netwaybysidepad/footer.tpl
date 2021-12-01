{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'footer.tpl.php');
{/php}

</div>
<div class="clear"></div>
<!--ปุ่ม UP -->
<div id="back-top" {if $requestURI.1 == 'knowledgebase' || $requestURI.1 == 'kb'|| ( $queryString.1 == 'cart' && $step == 0) } class="hidden-phone" {/if} style="display:none">
          <a href="#top"><span></span></a>
</div>
</section>
</div>
</div>



{include file='content/footer-corporate-temp.tpl'}


<!------------------- Start Middle ----------------------------->

<nav class="ma5menu" itemscope itemtype="http://schema.org/SiteNavigationElement">
    <div class="ma5menu__header">
        <a class="ma5menu__home" href="javascript:void(0);" tabindex="-1">
            ผลิตภัณฑ์ทั้งหมด
        </a>
    </div>
    <!-- 'ma5menu__panel--active' - unordered-list which has active list-item and is closest to him in menu tree (only one for menu) -->
    <!-- At Home page active link set as first in menu tree -->
    <ul class="lvl-0 ma5menu__panel--active" data-ma5order="ma5-ul">
        <!-- 'ma5menu__li--current' - current list-item wchich is closest to active link in menu tree (only one for menu) -->
        <li class="ma5menu__li--current" data-ma5order="ma5-li-1">
            <!-- Use class 'ma5menu__path' when you need colored link or category, for example to active link or path links -->
            <span class="ma5menu__btn--enter ma5menu__category  ">Domain</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-1">

                <li data-ma5order="ma5-li-1-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Domain</div>
                    <span class="ma5menu__btn--enter ma5menu__category ">Good to know</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-1-1">
                        <li data-ma5order="ma5-li-1-1-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Good to know</div>
                            <a href="{$smarty.const.CMS_URL}/kb/domains/%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%84%E0%B8%9B/domain-%E0%B8%84%E0%B8%B7%E0%B8%AD%E0%B8%AD%E0%B8%B0%E0%B9%84%E0%B8%A3-">
                                โดเมนประเภทต่างๆ
                           </a>
                        </li>
                        <li data-ma5order="ma5-li-1-1-2">
                            <a href="{$smarty.const.CMS_URL}/kb/domains/%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%84%E0%B8%9B/%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%E0%B8%A3%E0%B8%B9%E0%B9%89%E0%B9%80%E0%B8%81%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B8%A7%E0%B8%81%E0%B8%B1%E0%B8%9A-domain">
                                ความรู้เกี่ยวกับโดเมน
                            </a>
                       </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-1-2">
                    <span class="ma5menu__btn--enter ma5menu__category">บริการ</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-1-2">
                        <li data-ma5order="ma5-li-1-2-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>บริการ</div>
                            <a href="{$system_url}domain-order">จดโดเมน</a>
                        </li>
                        <li data-ma5order="ma5-li-1-2-2"><a href="{$system_url}domain-order">ย้ายโดเมน</a></li>
                        <li data-ma5order="ma5-li-1-2-2"><a href="{$system_url}domain-checker">Whois</a></li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-1-3">
                  <span class="ma5menu__btn--enter ma5menu__category">ราคา</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-1-3">
                        <li data-ma5order="ma5-li-1-3-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>ราคา</div>
                            <a href="{$system_url}checkdomain/domain-registrations/">ราคา</a>
                        </li>

                    </ul>
                </li>
                <li data-ma5order="ma5-li-1-4">
                  <span class="ma5menu__btn--enter ma5menu__category">ค้นหาโดเมน</span>
                  <ul class="lvl-2" data-ma5order="ma5-ul-1-4">
                    <li data-ma5order="ma5-li-1-4-1">
                     <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>ค้นหาโดเมน</div>
	                  <form class="pure-form" method="get" action="{$system_url}domain-order" style="padding: 20px 10px 10px 10px;">
	                    <input type="search"  class="txt-SearchDomain" name="domain" required=""  placeholder="พิมพ์ชื่อโดเมนที่คุณต้องการทีนี่"  style="width: 95%;"/>
	                    <button type="submit" class="btn-search-domain span12"><i class="fa fa-search" aria-hidden="true"></i> </button>
	                  </form>
	                 </li>
                  </ul>
                </li>

            </ul>
        </li>

        <li data-ma5order="ma5-li-2">
            <span class="ma5menu__btn--enter ma5menu__category">Hosting</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-2">
                <li data-ma5order="ma5-li-2-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Hosting</div>
                    <span class="ma5menu__btn--enter ma5menu__category">Website Hosting</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-2-1">
                        <li data-ma5order="ma5-li-2-1-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Web hosting</div>
                            <a href="{$smarty.const.CMS_URL}/linux-hosting">Linux Hosting</a>
                        </li>
                          <li data-ma5order="ma5-li-2-1-2"><a href="{$smarty.const.CMS_URL}/windows-hosting">Window Hosting</a></li>
                    </ul>
                </li>
                <!-- <li data-ma5order="ma5-li-2-2"><a href="javascript:void(0);" style="color:gray;">Private Hosting(VPS)</a></li>
                <li data-ma5order="ma5-li-2-3"><a href="javascript:void(0);" style="color:gray;">Email Hosting</a></li>
                <li data-ma5order="ma5-li-2-4"><a href="javascript:void(0);" style="color:gray;">Wordpress Hosting</a></li> -->
                <li data-ma5order="ma5-li-2-5">
                    <span class="ma5menu__btn--enter ma5menu__category">บริการ Netway</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-2-5">
                        <li data-ma5order="ma5-li-2-5-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>บริการ Netway</div>
                            <a href="{$smarty.const.CMS_URL}/siaminterhost">บริการย้ายโฮสติ้ง</a>
                        </li>
                        <li data-ma5order="ma5-li-2-5-2"><a href="{$smarty.const.CMS_URL}/siaminterhost">เลือกใช้ Hosting Plan อะไรดี</a></li>
                        <li data-ma5order="ma5-li-2-5-3"><a href="{$smarty.const.CMS_URL}/kb/domains/service-request/%E0%B8%82%E0%B8%B1%E0%B9%89%E0%B8%99%E0%B8%95%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%A2%E0%B9%89%E0%B8%B2%E0%B8%A2%E0%B9%82%E0%B8%94%E0%B9%80%E0%B8%A1%E0%B8%99-gtld-%E0%B8%A1%E0%B8%B2%E0%B8%97%E0%B8%B5%E0%B9%88-netway">บริการย้ายโดเมน</a></li>
                    </ul>
                </li>
                <!-- <li data-ma5order="ma5-li-2-6"><a href="javascript:void(0);" style="color:gray;">Windows Cloud VPS</a></li>
                <li data-ma5order="ma5-li-2-7"><a href="javascript:void(0);" style="color:gray;">Linux Cloud VPS</a></li>
                <li data-ma5order="ma5-li-2-8"><a href="javascript:void(0);" style="color:gray;">Dedicated Server</a></li> -->
            </ul>
        </li>

         <li data-ma5order="ma5-li-10">
            <span class="ma5menu__btn--enter ma5menu__category">Cloud & Managed</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-10">
                 <li data-ma5order="ma5-li-10-1">
                     <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Cloud & Managed</div>
                    <span class="ma5menu__btn--enter ma5menu__category">Linux Cloud VPS</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-10-1">
                        <li data-ma5order="ma5-li-10-1-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Linux Cloud VPS</div>
                            <a href="{$smarty.const.CMS_URL}/linux-vps">Linux  VPS</a>
                            <a href="{$smarty.const.CMS_URL}/linux-vmware"> Linux VMware</a>
                            <a href="{$smarty.const.CMS_URL}/azure-server"> Microsoft Azure</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-10-2">
                    <span class="ma5menu__btn--enter ma5menu__category">Windows Cloud VPS</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-10-2">
                        <li data-ma5order="ma5-li-10-2-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Windows Cloud VPS</div>
                            <a href="{$smarty.const.CMS_URL}/windows-vps"> Windows  VPS</a>
                            <a href="{$smarty.const.CMS_URL}/windows-vmware"> Windows VMware</a>
                            <a href="{$smarty.const.CMS_URL}/azure-server"> Microsoft Azure</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-10-3">
                    <span class="ma5menu__btn--enter ma5menu__category">Dedicated Server</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-10-3">
                        <li data-ma5order="ma5-li-10-3-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Dedicated Server</div>
                            <a href="{$smarty.const.CMS_URL}/linux-dedicated-server"> Linux Dedicated Server</a>
                            <a href="{$smarty.const.CMS_URL}/windows-dedicated-server"> Windows Dedicated Server</a>

                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-10-7">
                    <span class="ma5menu__btn--enter ma5menu__category">Virtual Private Cloud</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-10-7">
                        <li data-ma5order="ma5-li-10-7-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Virtual Private Cloud</div>
                            <a href="{$smarty.const.CMS_URL}/virtual-private-cloud">Virtual Private Cloud</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-10-4">
                    <span class="ma5menu__btn--enter ma5menu__category">Managed Server Services</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-10-4">
                        <li data-ma5order="ma5-li-10-4-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Managed Server Services</div>
                            <a href="{$smarty.const.CMS_URL}/managed-server-services">Managed Server Services <br> 1,500 บาท/เดือน</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-10-5">
                    <span class="ma5menu__btn--enter ma5menu__category">Blog</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-10-5">
                        <li data-ma5order="ma5-li-10-5-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Blog</div>
                            <a href="{$smarty.const.CMS_URL}/kb/blog/cloud-managed-services">Blog</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-10-6">
                    <span class="ma5menu__btn--enter ma5menu__category">Solution</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-10-6">
                        <li data-ma5order="ma5-li-10-6-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Solution</div>
                             <a href="{$smarty.const.CMS_URL}/loadbalance">Load Balancer</a>
                             <a href="{$smarty.const.CMS_URL}/cloud-file-sharing">Cloud File Sharing</a>
                        </li>
                    </ul>
                </li>


            </ul>
        </li>

        <li data-ma5order="ma5-li-3">
            <span class="ma5menu__btn--enter ma5menu__category">SSL</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-3">
                <li data-ma5order="ma5-li-3-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>SSL</div>
                    <span class="ma5menu__btn--enter ma5menu__category">SSL คืออะไร</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-3-1">
                        <li data-ma5order="ma5-li-3-1-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>SSL คืออะไร</div>
                            <a href="{$smarty.const.CMS_URL}/kb/SSL%20Certificate/ข้อมูลทั่วไป/360002121132-SSL%20คืออะไร%20%20ทำไมต้องใช้%20SSL">SSL คือ</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-3-2">
                    <span class="ma5menu__btn--enter ma5menu__category">เปรียบเทียบ SSL (DV, OV, และ EV)</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-3-2">
                        <li data-ma5order="ma5-li-3-2-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>เปรียบเทียบ SSL (DV, OV, และ EV)</div>
                            <a href="{$smarty.const.CMS_URL}/kb/SSL%20Certificate/ข้อมูลทั่วไป/360002144171-ประเภทของ%20SSL%20certificate">เปรียบเทียบ SSL ประเภทต่างๆ</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-3-3"><a href="{$smarty.const.CMS_URL}/kb/Blog/SSL">Blog</a></li>
                <li data-ma5order="ma5-li-3-4"><a href="https://ssl.in.th/ssl-checker">SSL Checker</a></li>
                <li data-ma5order="ma5-li-3-5"><a href="https://ssl.in.th/ssl-comparison">Plan & Pricing</a></li>
                <li data-ma5order="ma5-li-3-6"><a href="{$smarty.const.CMS_URL}/kb/ssl-certificate/ข้อมูลทั่วไป/%5Bfaq%5D-ปัญหาที่พบบ่อยเกี่ยวกับ-ssl-certificate">คำถามที่พบบ่อย</a></li>
                <li data-ma5order="ma5-li-3-7"><a href="https://ssl.in.th/about-us/clients-ssl">เสียงสะท้อนจากลูกค้า</a></li>
            </ul>
        </li>

        <li data-ma5order="ma5-li-4">
            <span class="ma5menu__btn--enter ma5menu__category">Email</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-4">
                <li data-ma5order="ma5-li-4-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Email</div>
                    <span class="ma5menu__btn--enter ma5menu__category">Microsoft 365</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-4-1">
                        <li data-ma5order="ma5-li-4-1-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Microsoft 365</div>
                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=360000274191&request_subject=%E0%B8%AA%E0%B8%99%E0%B9%83%E0%B8%88%E0%B8%97%E0%B8%94%E0%B8%A5%E0%B8%AD%E0%B8%87%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%9F%E0%B8%A3%E0%B8%B5%20Office%20365%20Home&request_custom_fields_114095596292=sales_opt_office_365&_ga=2.9790517.188017872.1535945936-593851065.1525956799">ทดลองฟรี</a>
                        </li>
                        <li data-ma5order="ma5-li-4-1-2"><a href="{$smarty.const.CMS_URL}/microsoft-365" >Microsoft 365 รุ่นต่างๆ</a></li>
                        <li data-ma5order="ma5-li-4-1-2"><a href="{$smarty.const.CMS_URL}/microsoft-365#PlanandPricing" >Microsoft 365 สำหรับสำหรับธุรกิจ</a></li>
                        <li data-ma5order="ma5-li-4-1-3"><a href="{$smarty.const.CMS_URL}/microsoft-365#HomePlanandPricing" >Microsoft 365 สำหรับใช้ที่บ้าน </a></li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-4-2">
                    <span class="ma5menu__btn--enter ma5menu__category">G Suite</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-4-2">
                        <li data-ma5order="ma5-li-4-2-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>G Suite</div>
                             <a href="{$smarty.const.CMS_URL}/gsuite">G Suite</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-4-2">
                    <span class="ma5menu__btn--enter ma5menu__category">Hybrid Email</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-4-2">
                        <li data-ma5order="ma5-li-4-2-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Hybrid Email</div>
                            <a href="{$smarty.const.CMS_URL}/hybrid-o365">เทคนิคลดต้นทุนอีเมล Microsoft 365มากกว่า 28% </a>
                            <a href="{$smarty.const.CMS_URL}/hybrid-gsuite">เทคนิคลดต้นทุนอีเมล Office G Suite มากกว่า 19% </a>
                        </li>

                    </ul>
                </li>
                 <li data-ma5order="ma5-li-4-3">
                    <span class="ma5menu__btn--enter ma5menu__category">Zimbra Based Email</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-4-3">
                        <li data-ma5order="ma5-li-4-3-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Zimbra Based Email</div>
                             <a href="{$smarty.const.CMS_URL}/e-mail">รายละเอียด</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-4-4">
                    <span class="ma5menu__btn--enter ma5menu__category">Traditional Email by cPanel</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-4-4">
                        <li data-ma5order="ma5-li-4-4-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Traditional Email by cPanel</div>
                             <a href="{$smarty.const.CMS_URL}/e-mail">รายละเอียด</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-4-5">
                    <span class="ma5menu__btn--enter ma5menu__category">Email Migration</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-4-5">
                        <li data-ma5order="ma5-li-4-5-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Email Migration</div>
                             <a href="{$smarty.const.CMS_URL}/email-migration">รายละเอียด</a>
                        </li>
                    </ul>
                </li>




            </ul>
        </li>

        <li data-ma5order="ma5-li-5">
            <span class="ma5menu__btn--enter ma5menu__category">Microsoft</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-5">
                <li data-ma5order="ma5-li-5-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Microsoft</div>
                    <span class="ma5menu__btn--enter ma5menu__category">Microsoft Cloud</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-5-1">
                        <li data-ma5order="ma5-li-5-1-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Microsoft Cloud</div>
                            <a href="{$smarty.const.CMS_URL}/microsoft-365">Microsoft 365</a>
                            <a href="{$smarty.const.CMS_URL}/dynamics365">Dynamics 365</a>
                            <a href="{$smarty.const.CMS_URL}/sharepoint">Sharepoint Online</a>

                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-5-4">
                    <span class="ma5menu__btn--enter ma5menu__category">Microsoft Client</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-5-4">
                        <li data-ma5order="ma5-li-5-4-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Microsoft Client</div>
                            <a href="{$smarty.const.CMS_URL}/windows10">Windows 10</a>
                        </li>
                        <!-- <li data-ma5order="ma5-li-5-4-2"><a href="javascript:void(0);" style="color:gray;">Project</a></li> -->
                        <li data-ma5order="ma5-li-5-4-3"><a href="{$smarty.const.CMS_URL}/kb/training/course-syllabus/tra0012%3A-การใช้งาน-visio-บน-microsoft-365">Visio</a></li>
                        <!-- <li data-ma5order="ma5-li-5-4-4"><a href="javascript:void(0);" style="color:gray;">Skype for Business</a></li>
                        <li data-ma5order="ma5-li-5-4-5"><a href="javascript:void(0);" style="color:gray;">Power BI Desktop</a></li> -->
                    </ul>
                </li>
                <li data-ma5order="ma5-li-5-5">
                    <span class="ma5menu__btn--enter ma5menu__category">Cloud Server & System</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-5-5">
                        <li data-ma5order="ma5-li-5-5-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Cloud Server & System</div>
                            <a href="{$smarty.const.CMS_URL}/windows-server">Windows Server</a>
                        </li>
                        <li data-ma5order="ma5-li-5-5-2"><a href="{$smarty.const.CMS_URL}/microsoft-sql-server">Microsoft SQL Server</a></li>
                        <li data-ma5order="ma5-li-5-5-3"><a href="{$smarty.const.CMS_URL}/microsoft-exchange-server/">Microsoft Exchange Server</a></li>
                        <li data-ma5order="ma5-li-5-5-4"><a href="{$smarty.const.CMS_URL}/azure-server"> Microsoft Azure</a></li>

                    </ul>
                </li>
                <li data-ma5order="ma5-li-5-6">
                    <span class="ma5menu__btn--enter ma5menu__category">Hybird Email</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-5-6">
                        <li data-ma5order="ma5-li-5-6-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Hybird Email</div>
                            <a href="{$smarty.const.CMS_URL}/e-mail">Email</a>
                        </li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-5-7"><a href="{$smarty.const.CMS_URL}/microsoft-sam"><span class="btn btn-warning">การบริหารจัดการซอฟต์แวร์ (Microsoft SAM Tool)</span></a></li>
            </ul>
        </li>

        <li data-ma5order="ma5-li-6">
            <span class="ma5menu__btn--enter ma5menu__category">Google</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-6">
                <li data-ma5order="ma5-li-6-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Google</div>
                    <span class="ma5menu__btn--enter ma5menu__category">G Suite</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-6-1">
                        <li data-ma5order="ma5-li-6-1-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>G Suite</div>
                            <a href="{$smarty.const.CMS_URL}/gsuite#Features">Features</a>
                        </li>
                        <li data-ma5order="ma5-li-6-1-2"><a href="{$smarty.const.CMS_URL}/gsuite#PlanandPriceing">Plan & Pricing</a></li>
                        <li data-ma5order="ma5-li-6-1-3"><a href="{$smarty.const.CMS_URL}/kb/Blog/G%20Suites">Blog</a></li>
                        <li data-ma5order="ma5-li-6-1-4"><a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=%E0%B8%97%E0%B8%94%E0%B8%A5%E0%B8%AD%E0%B8%87%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%87%E0%B8%B2%E0%B8%99%20G-Suite&request_custom_fields_114095596292=sales_opt_g_suite"><span class="btn btn-warning">ทดลองใช้งาน G Suite</span></a></li>
                    </ul>
                </li>
            </ul>
        </li>

        <li data-ma5order="ma5-li-7">
            <span class="ma5menu__btn--enter ma5menu__category">Zendesk</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-7">
                <li data-ma5order="ma5-li-7-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Zendesk</div>
                    <a href="{$smarty.const.CMS_URL}/zendesk#support">Zendesk support - helpdesk</a>
                </li>
                <li data-ma5order="ma5-li-7-2"><a href="javascript:void(0);" style="color:gray;">Zendesk guide - knowledge base</a></li>
                <li data-ma5order="ma5-li-7-3"><a href="{$smarty.const.CMS_URL}/zendesk#chat">Zendesk chat - Livechat</a></li>
                <li data-ma5order="ma5-li-7-4"><a href="javascript:void(0);" style="color:gray;">Zendesk talk - Call center</a></li>
                <li data-ma5order="ma5-li-7-5"><a href="javascript:void(0);" style="color:gray;">Omni-channel customer services</a></li>
                <li data-ma5order="ma5-li-7-6"><a href="{$smarty.const.CMS_URL}/zendesk#PlanandPricing">Plan & Pricing</a></li>
                <li data-ma5order="ma5-li-7-8"><a href="{$smarty.const.CMS_URL}/kb/Blog/Zendesk">Blog</a></li>
                <li data-ma5order="ma5-li-7-9"><a href="https://www.zendesk.com/marketplace/partners/netway-communication/?source=partner_directory">Blog</a></li>
                <li data-ma5order="ma5-li-7-10"><a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=%E0%B8%97%E0%B8%94%E0%B8%A5%E0%B8%AD%E0%B8%87%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%87%E0%B8%B2%E0%B8%99%20Zendesk&request_custom_fields_114095596292=sales_opt_other"><span class="btn btn-warning">ทดลองใช้งาน Zendesk ฟรี 30 วัน</span></a></li>
            </ul>
        </li>

        <li data-ma5order="ma5-li-8">
            <span class="ma5menu__btn--enter ma5menu__category">Marketing</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-8">
                <li data-ma5order="ma5-li-8-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Marketing</div>
                    <a href="https://netway.site">Free Website</a>
                </li>
                <!-- <li data-ma5order="ma5-li-8-2"><a href="javascript:void(0);" style="color:gray;">Mailchimp</a></li> -->
            </ul>
        </li>

        <li data-ma5order="ma5-li-9">
            <span class="ma5menu__btn--enter ma5menu__category">Other</span>
            <ul class="lvl-1" data-ma5order="ma5-ul-9">
                <li data-ma5order="ma5-li-9-1">
                    <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Other</div>
                    <!-- <span class="ma5menu__btn--enter ma5menu__category">Anti-Virus</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-9-1">
                        <li data-ma5order="ma5-li-9-1-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Anti-Virus</div>
                            <a href="javascript:void(0);" style="color:gray;">Kaspersky</a>
                        </li>
                        <li data-ma5order="ma5-li-9-1-2"><a href="javascript:void(0);" style="color:gray;">Norton</a></li>
                        <li data-ma5order="ma5-li-9-1-3"><a href="javascript:void(0);" style="color:gray;">McAFee</a></li>
                    </ul> -->

                <!-- <li data-ma5order="ma5-li-9-2">
                    <span class="ma5menu__btn--enter ma5menu__category">Adobe</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-9-2">
                        <li data-ma5order="ma5-li-9-2-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Adobe</div>
                            <a href="javascript:void(0);" style="color:gray;">Adobe Photoshop</a>
                        </li>
                        <li data-ma5order="ma5-li-9-2-2"><a href="javascript:void(0);" style="color:gray;">Adobe Illustrator</a></li>
                        <li data-ma5order="ma5-li-9-2-3"><a href="javascript:void(0);" style="color:gray;">Adobe Autocad</a></li>
                    </ul>
                </li> -->
                <li data-ma5order="ma5-li-9-3">
                    <span class="ma5menu__btn--enter ma5menu__category">Web Hosting Software</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-9-3">
                        <li data-ma5order="ma5-li-9-3-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Web Hosting Software</div>
                            <a href="{$smarty.const.CMS_URL}/webhosting-software" >cPanel</a>
                        </li>
                        <!-- <li data-ma5order="ma5-li-9-3-2"><a href="javascript:void(0);" style="color:gray;">ISPmanager</a></li>
                        <li data-ma5order="ma5-li-9-3-3"><a href="javascript:void(0);" style="color:gray;">Softaculous</a></li>
                        <li data-ma5order="ma5-li-9-3-3"><a href="javascript:void(0);" style="color:gray;">LiteSpeed</a></li>
                        -->
                    </ul>
                </li>
                <li data-ma5order="ma5-li-9-4">
                    <span class="ma5menu__btn--enter ma5menu__category">Serif</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-9-4">
                        <li data-ma5order="ma5-li-9-4-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Serif</div>
                            <a href="{$smarty.const.CMS_URL}/affinityphoto" >Affinity Photo</a>
                        </li>
                        <li data-ma5order="ma5-li-9-4-2"><a href="{$smarty.const.CMS_URL}/affinity-designer">Affinity Designer</a></li>
                    </ul>
                </li>
                <li data-ma5order="ma5-li-9-5">
                    <span class="ma5menu__btn--enter ma5menu__category">Wondershare</span>
                    <ul class="lvl-2" data-ma5order="ma5-ul-9-5">
                        <li data-ma5order="ma5-li-9-5-1">
                            <div class="ma5menu__leave"><span class="ma5menu__btn--leave"></span>Wondershare</div>
                            <a href="{$smarty.const.CMS_URL}/pdfelement-6" >pdfelement 6</a>
                        </li>

                    </ul>
                </li>
                </li>
            </ul>
        </li>

    </ul>
</nav>

<script src="{$template_dir}js/horizontalDropDownMenu/modernizr.custom.js"></script>
<script>
{literal}
$(document).ready( function () {
    $('.ma5menu').css({
        position: 'left',
        closeOnBodyClick: true
    });
});
{/literal}
</script>


{*
{if $isOnline=='0'}
<div id="hbtagcontainer_f87dea01855e3766"><div id="hb_floatingstatus" style="position:fixed;left:0px;top:70%;z-index:1000;"><img src="{$system_url}?cmd=hbchat&action=status&sid=2" alt="Click here to chat" onclick="window.open('{$system_url}/tickets/new/tickets/new','_self');" style="cursor:pointer"></div></div>
{else}
{if $enableFeatures.chat!='off'}  <div id="hbinvitationcontainer_f87dea01855e3766"></div><div id="hbtagcontainer_f87dea01855e3766"></div><script type="text/javascript">var hb_script_tag_f87dea01855e3766=document.createElement("script");hb_script_tag_f87dea01855e3766.type="text/javascript";setTimeout('hb_script_tag_f87dea01855e3766.src="{$system_url}index.php?cmd=hbchat&action=embed&v=cmFuZGlkPWY4N2RlYTAxODU1ZTM3NjYmaW52aXRlX2lkPTMmdGFnPXNpZGViYXImc3RhdHVzX2lkPTI=";document.getElementById("hbtagcontainer_f87dea01855e3766").appendChild(hb_script_tag_f87dea01855e3766);',5);</script><!--END OF: HostBill Chat Code, (c) Quality Software-->{/if}
{/if}
*}
{userfooter}
{* {literal}

    <script>/*<![CDATA[*/window.zEmbed||function(e,t){var n,o,d,i,s,a=[],r=document.createElement("iframe");window.zEmbed=function(){a.push(arguments)},window.zE=window.zE||window.zEmbed,r.src="javascript:false",r.title="",r.role="presentation",(r.frameElement||r).style.cssText="display: none",d=document.getElementsByTagName("script"),d=d[d.length-1],d.parentNode.insertBefore(r,d),i=r.contentWindow,s=i.document;try{o=s}catch(e){n=document.domain,r.src='javascript:var d=document.open();d.domain="'+n+'";void(0);',o=s}o.open()._l=function(){var o=this.createElement("script");n&&(this.domain=n),o.id="js-iframe-async",o.src=e,this.t=+new Date,this.zendeskHost=t,this.zEQueue=a,this.body.appendChild(o)},o.write('<body onload="document._l();">'),o.close()}("https://assets.zendesk.com/embeddable_framework/main.js","pdi-netway.zendesk.com");
    /*]]>*/</script>
    <script language="JavaScript">
    var oClient     = {
        name    : '{/literal}{$aClient.firstname}{literal}',
        email   : '{/literal}{$aClient.email}{literal}'
    };
    </script>
    <script type="text/javascript" src="https://dev.zopim.com/web-sdk/latest/web-sdk.js"></script>
    <script type="text/javascript" src="{/literal}{$template_dir}{literal}js/zendesk_livechat.js"></script>
    <script type="text/javascript" src="{$system_url}js/netway_chat_widget_customize.js"></script>
{/literal} *}
{literal}
<!-- Google Tag Manager (noscript) -->
   <noscript>
        <iframe src="https://www.googletagmanager.com/ns.html?id=GTM-K5JBBX2"height="0" width="0" style="display:none;visibility:hidden"></iframe>
 </noscript>
<!-- End Google Tag Manager (noscript) -->

<script type="text/javascript">window.$crisp=[];window.CRISP_WEBSITE_ID="928dc456-d257-4727-9fd7-ab9c055607fb";(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();</script>

<!-- Modal -->
<div id="formModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
    <div class="modal-header">
        <h4 id="formModalLabel">กรุณาให้ข้อมูลเพิ่มเติม</h4>
    </div>
    <div class="modal-body">


<div id="zf_div_lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og"></div>
    <script type="text/javascript">(function() {
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
        })();
    </script>

<script>

var zohoFormId      = 'zf_div_lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og';
var zohoFormUrl     = 'https://forms.zohopublic.com/netwaycommunication/form/Support/formperma/lekE3E4ZMw_QAhXLTmCg6pVK0WrHo8Kt8LJQH1D92og?zf_rszfm=1';
var sessionId       = '';

$crisp.push(['on', 'session:loaded', function (session_id) {
    sessionId       = session_id;
}]);

$crisp.push(['on', 'user:email:changed', function (email) {

    var dom     = document.getElementById(zohoFormId).querySelector('iframe');
    dom.src     = zohoFormUrl +'&session_id='+ sessionId +'&email='+ email;

    $('#formModal').modal({
        show: true,
        keyboard: false,
        backdrop: 'static'
    });

    $crisp.push(['do', 'chat:close']);
    
}]);

$crisp.push(['on', 'message:received', function (data) {
    if (data.content !== 'สักครู่นะครับ') {
        return true;
    }

    $('#formModal').modal('hide');
    $crisp.push(['do', 'chat:open']);
}]);

$(document).ready( function () {

});
</script>


    </div>
</div>

{/literal}

{if $logged!='1'}

<div class="a2a_kit a2a_kit_size_32 a2a_floating_style a2a_vertical_style hidden-phone" style="left:0px; top:200px;">
    <a class="a2a_button_facebook"></a>
    <a class="a2a_button_twitter" style="display: none"></a>
    <a class="a2a_button_line"></a>
    <a class="a2a_dd" href="https://www.addtoany.com/share"></a>
</div>

{literal}
<script async src="//static.addtoany.com/menu/page.js"></script>
<style type="text/css">
/* Hide AddToAny vertical share bar when screen is less than 980 pixels wide */
@media screen and (min-width: 480px){
    .a2a_floating_style.a2a_vertical_style { display: inherit; }
}
</style>
{/literal}

{/if}

{literal}
 <script>
$(document).ready(function(){
    $('#phoneCall').click(function(){
        $.get("/phone-click",function(data){
            console.log(data)
      });
    });
});


function parse_response_json (respose) {
    if (respose.hasOwnProperty('data')) {
        if (respose.data.hasOwnProperty('info')) {
            $.growl.notice({ title: 'Information', message: respose.data.info });
        }
        if (respose.data.hasOwnProperty('error')) {
            $.growl.warning({ title: 'Error', message: respose.data.error });
        }
    }
}

</script>
{/literal}

<!-- Add fancyBox main JS and CSS files -->
<script type="text/javascript" src="{$system_url}templates/netwaybysidepad/share/js/fancybox/jquery.fancybox.js?v=2.1.4"></script>
<link type="text/css" rel="stylesheet" media="screen" href="{$system_url}templates/netwaybysidepad/share/js/fancybox/jquery.fancybox.css" />
<script type="text/javascript" src="{$system_url}templates/netwaybysidepad/share/js/fancybox/fancybox.js"></script>
<!-- or combined in one plugin file -->
{php}
 function isMobile() {
    return preg_match("/(android|webos|avantgo|iphone|ipad|ipod|blackberry|iemobile|bolt|boost|cricket|docomo|fone|hiptop|mini|opera mini|kitkat|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i", $_SERVER["HTTP_USER_AGENT"]);
}
if(isMobile()){
{/php}  
<link href="{$template_dir}js/ma5-mobile-menu-3.0.3/css/ma5-menu.min.css" rel="stylesheet" type="text/css">
<script src="{$template_dir}js/ma5-mobile-menu-3.0.3/js/ma5-menu.min.js"></script>
{php}
}
else{
{/php} 
{literal}
<script>
$(document).ready(function(){
    $(".ma5menu").each(function() {
        $(this).css("display", "none");
    });
});
</script>
{/literal}
{php}
}
{/php} 
<link href="{$template_dir}js/jquery.growl/stylesheets/jquery.growl.css" rel="stylesheet" type="text/css">
<script src="{$template_dir}js/jquery.growl/javascripts/jquery.growl.js"></script>
</body>
</html>
