<?php
/****************************************************************
 * _mergeUser : เอาไว้ merge client id จาก hostbilll เข้า database ของ rvsitebuilder
 *
 *
 ***************************************************************/
class rv_product_prorata_controller extends HBController {
    /*
     * Under $this->module HostBill will load your module
     * in this case it will be Example
    */



	// วันที่ 1 ปิด prorate วันที่ 7 เปิด prorate ทำเฉพาะ product license
    public function call_daily()
    {

        $db         = hbm_db();
        $iDate = intval(date('d'));
        $today = date('d-m-y');
        $message = "-ไม่มีการอัพเดท-".$today ;

		if ($iDate == 1) {
			$aUpdateEnableProrata = $db->query("
	            DELETE FROM
	                hb_automation_settings
	            WHERE
	               item_id in (
						SELECT
							p.id
						FROM
							hb_products p, hb_categories c where p.category_id = c.id AND p.category_id =6
							AND p.name not like 'Free%'
						)
					AND setting = 'EnableProRata'
	            ", array());

			$message = 'update วันที่ 1 ';
		}  elseif ($iDate == 7) {
			/// เอาแค่ license เท่านั้น คือ ปรับเปลี่ยนการคิดราคาแบบ prorata
			// ***ยกเว้น Softaculous และ Virtualizor***
			$aGet  = $db->query("
				SELECT
					p.id ,p.name
				FROM
					hb_products p, hb_categories c
				WHERE
					p.category_id = c.id
					AND p.category_id = 6
					AND p.name not like 'Free%'
					AND p.id NOT IN(144, 145, 149)
                    ", array())->fetchall();
		    if (count($aGet) == 0 )return 'NO DATA';
            foreach ($aGet as $key => $adtl) {
				$aInsertEnableProrata = $db->query("
		            INSERT INTO
		                hb_automation_settings
		            	(item_id, type, setting, value)
					VALUES
						(:item_id, :type, :setting,:value)
		            "
		            , array(
					':item_id' => $adtl['id'],
					':type' => 'Hosting',
					':setting' => 'EnableProRata',
					':value' => 'on',

					));
			     $message .= '<br>'.$adtl['name'];
			}

		}
        //echo 'return '.$message;
        return $message;
    }




}
