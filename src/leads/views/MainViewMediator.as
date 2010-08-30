package leads.views {
import flash.desktop.NativeApplication;

import leads.models.events.LeadEvent;

import org.robotlegs.mvcs.Mediator;

public class MainViewMediator extends Mediator{

    [Inject]
    public var view:MainView;

    override public function onRegister():void
    {
        addContextListener(LeadEvent.NEW_LEADS, handleNewLeads);
    }
    
    private function handleNewLeads(event:LeadEvent):void
    {
        NativeApplication.nativeApplication.activate();
        view.viewStack.selectedIndex = 0;
    }
}
}