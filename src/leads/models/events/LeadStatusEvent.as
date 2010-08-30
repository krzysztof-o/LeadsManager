package leads.models.events {
import flash.events.Event;

public class LeadStatusEvent extends Event{
    public static const LOG:String = "log";
    //public static const CLEAR_LOG:String = "clearLog";

    public var logStr:String;

    public function LeadStatusEvent(type:String, logStr:String="", bubbles:Boolean=false, cancelable:Boolean=false) {
        this.logStr = logStr;
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        return new LeadStatusEvent(type, logStr, bubbles, cancelable);
    }
}
}