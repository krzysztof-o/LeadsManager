package leads.views.events {
import flash.events.Event;

import leads.models.vo.LeadVO;

public class SelectedLeadEvent extends Event{
    public static const LEAD_CLICKED:String = "lead_clicked";


    public var vo:LeadVO;
    public function SelectedLeadEvent(type:String, vo:LeadVO, bubbles:Boolean=false, cancelable:Boolean=false) {
        super(type, bubbles, cancelable);
        this.vo = vo;
    }

    override public function clone():Event {
        return new SelectedLeadEvent(type, vo, bubbles, cancelable);
    }
}
}