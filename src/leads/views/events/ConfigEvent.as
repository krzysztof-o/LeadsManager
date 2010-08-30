package leads.views.events {
import flash.events.Event;

import leads.models.vo.ConfigVO;

public class ConfigEvent extends Event{

    public static const SAVE_DATA:String = "save_data";
    public static const DATA_LOADED:String = "user_saved";


    public var vo:ConfigVO;
    
    public function ConfigEvent(type:String, vo:ConfigVO=null, bubbles:Boolean=false, cancelable:Boolean=false) {
        this.vo = vo;
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        return new ConfigEvent(type, vo, bubbles, cancelable);
    }
}
}