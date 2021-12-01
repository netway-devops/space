```

module อยู่ใน server2.rvglobalsoft.com /home/rvglobal/public_html/includes/modules/Hosting/

function ใน class ดูตามชื่อของ action ใน hostbill ได้เลย Create() Suspend() Unsuspend() ChangePackage()

database rvglobal_hostbill table rvsitebuilder_developer_license และ rvsitebuilder_developer_site

active / deactive / config module ได้ที่ hostbill settings->module->hosting modules

หลังจาก action process ของ hostbill ผ่านไปแล้ว module rvsitebuilder_developer_license จะ hook เพื่อทำงานต่าง ๆ ต่อไปนี้
    addorder (only trial) -> function Create()
        generate random string devtoken and save table rvsitebuilder_developer_license
    suspend -> function Suspend()
        flag status suspend to table rvsitebuilder_developer_license
        flag status suspend to table rvsitebuilder_developer_site
    unsuspend -> function Unsuspend()
        flag status unsuspend to table rvsitebuilder_developer_license
        flag status unsuspend to table rvsitebuilder_developer_site
    renew(after user renew/paid) -> function Renewal()
        update expiredate +1year to table rvsitebuilder_developer_license
    upgradeplan -> ChangePackage()
        update plan id/name to table rvsitebuilder_developer_license




```
