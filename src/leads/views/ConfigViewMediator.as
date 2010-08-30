package leads.views {
import flash.desktop.NativeApplication;

import leads.models.events.LeadEvent;
import leads.views.events.ConfigEvent;

import org.robotlegs.mvcs.Mediator;

public class ConfigViewMediator extends Mediator {

    [Inject]
    public var view:ConfigView;

    override public function onRegister():void
    {
        if(!NativeApplication.supportsStartAtLogin)
            view.openOnStartupCheckbox.enabled = false;

        
        addViewListener(ConfigEvent.SAVE_DATA, dispatch);
        addContextListener(ConfigEvent.DATA_LOADED, handleDataLoaded);

        dispatch(new LeadEvent(LeadEvent.START_CHECKING));
    }

    private function handleDataLoaded(event:ConfigEvent):void
    {
        view.loadUserData(event.vo);
    }


}
}