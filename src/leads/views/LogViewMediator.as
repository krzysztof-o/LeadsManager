package leads.views {
import com.adobe.utils.NumberFormatter;

import leads.models.events.LeadEvent;
import leads.models.events.LeadStatusEvent;

import mx.utils.StringUtil;

import org.robotlegs.mvcs.Mediator;

public class LogViewMediator extends Mediator {

    [Inject]
    public var view:LogView;

    override public function onRegister():void
    {

        addContextListener(LeadEvent.START_CHECKING, handleStartChecking);
        addContextListener(LeadEvent.CHECKING, handleChecking);
        addContextListener(LeadEvent.NEW_LEADS, handleNewLeads);
        addContextListener(LeadEvent.NO_LEADS, handleNoLeads);
        //ERRORS
        addContextListener(LeadEvent.E_IO_ERROR, handleIOError);
        addContextListener(LeadEvent.E_LOGIN_ERROR, handleLoginError);
        addContextListener(LeadEvent.E_SECURUTY_ERROR, handleSecurityError);
        addContextListener(LeadStatusEvent.LOG, handleLog);
    }

    private function handleStartChecking(event:LeadEvent):void
    {
        //log("Rozpoczeto sprawdzanie");
    }

    private function handleChecking(event:LeadEvent):void
    {
        log("Sprawdzanie...");
    }

    private function handleNewLeads(event:LeadEvent):void
    {
        log("Sa nowe LEADy!");
    }

    private function handleNoLeads(event:LeadEvent):void
    {
        log("Brak nowych LEADow");
    }

    private function handleIOError(event:LeadEvent):void
    {
        log("Wystapil blad z polaczeniem.");
    }

    private function handleLoginError(event:LeadEvent):void
    {
        log("Wystapil blad podczas logowania - sprawdz dane!");
    }

    private function handleSecurityError(event:LeadEvent):void
    {
        log("Wystapil blad bezpieczenstwa");
    }
    
    private function  handleLog(event:LeadStatusEvent):void
    {
        log(event.logStr);
    }

    private function log(str:String):void
    {
        var date:Date = new Date();

        var text:String = StringUtil.substitute("{0}:{1}:{2} {3}\r",
                            NumberFormatter.addLeadingZero(date.hours),
                            NumberFormatter.addLeadingZero(date.minutes),
                            NumberFormatter.addLeadingZero(date.seconds),
                            str);

        view.addLogText(text);
    }
    

}
}