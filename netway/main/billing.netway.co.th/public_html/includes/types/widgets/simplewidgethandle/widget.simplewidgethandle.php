<?php


// DomainsWidget ptype 9 
// ServicesWidget ptype 0
// HostingWidget

class widget_simplewidgethandle extends DomainsWidget {
 
    protected $description = 'simplewidgethandle';
    protected $widgetfullname = 'simplewidgethandle';
    
    public function __construct ()
    {
        parent::__construct();
        $this->info['appendtpl'] = 'template.tpl';
    }

    /*
    ไม่เห็นถูกเรียกใช้งาน
    public function install ($detail)
    {
        $db         = hbm_db();

        $widgetfullname = $this->widgetfullname;

        $aConfig    = array(
            'smallimg'  => 'includes/types/widgets/simplewidgethandle/small.png',
            'bigimg'    => 'includes/types/widgets/simplewidgethandle/small.png',
        );
        $db->query("
        INSERT INTO `hb_widgets_config` (`id`, `widget`, `name`, `location`, `ptype`, `config`, `options`, `group`) VALUES
            ('', 'simplewidgethandle', '{$widgetfullname}', 'includes/types/widgets/simplewidgethandle/', 9, '". serialize($aConfig) ."', 1, 'sidemenu')
            ");
    }
    */

    public function controller ($detail)
    {
        
    }
    

    
}