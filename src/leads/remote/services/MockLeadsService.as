package leads.remote.services {
import flash.events.TimerEvent;
import flash.utils.Timer;

import leads.models.events.LeadEvent;
import leads.models.vo.LeadVO;

import org.robotlegs.mvcs.Actor;

public class MockLeadsService extends Actor implements ILeadsService {

    private var timer:Timer;
    public function MockLeadsService() {
        super();
        timer = new Timer(5000);
        timer.addEventListener(TimerEvent.TIMER, onTimer);
    }

    private function onTimer(event:TimerEvent=null):void {
        var vo1:LeadVO = new LeadVO("na ýycie", "ABC123", "Ma¸opolskie", "https://www.ubezpieczeniaonline.pl/lead/");
        var vo2:LeadVO = new LeadVO("na ýycie", "ABC124", "Ma¸opolskie", "http://wp2.pl");
        var vo3:LeadVO = new LeadVO("na ýycie", "ABC125", "Ma¸opolskie", "http://wp3.pl");
        var leads:Array = [vo1, vo2, vo3];

        dispatch(new LeadEvent(LeadEvent.NEW_LEADS_TO_PREPARE, leads));
    }

    public function startChecking():void {
        timer.start();
        //onTimer();
    }
}
}