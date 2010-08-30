package leads.models.events {
import flash.events.Event;

public class LeadEvent extends Event
{
    //CHECKING LIFECYCLE
    public static const START_CHECKING:String = "start_checking";
    public static const CHECKING:String = "checking";
    public static const NEW_LEADS_TO_PREPARE:String = "new_leads_to_prepare";
    public static const NEW_LEADS:String = "new_leads";
    public static const NO_LEADS:String = "no_leads";
    //ERRORS
    public static const E_SECURUTY_ERROR:String = "error_security";
    public static const E_IO_ERROR:String = "error_io";
    public static const E_LOGIN_ERROR:String = "e_login_error";

    public var leads:Array;
    
    public function LeadEvent(type:String, leads:Array = null, bubbles:Boolean=false, cancelable:Boolean=false) {
        this.leads = leads;
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        return new LeadEvent(type, leads, bubbles, cancelable);
    }
}
}