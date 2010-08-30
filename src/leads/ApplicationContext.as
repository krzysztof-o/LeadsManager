package leads {
import leads.controllers.LeadClickedCommand;
import leads.controllers.NewLeadsToPrepareCommand;
import leads.controllers.StartCheckingCommand;
import leads.controllers.ConfigSaveCommand;
import leads.models.LeadsModel;
import leads.models.ConfigModel;
import leads.models.events.LeadEvent;
import leads.remote.services.ILeadsService;
import leads.remote.services.LeadsService;
import leads.remote.services.MockLeadsService;
import leads.views.ConfigView;
import leads.views.ConfigViewMediator;
import leads.views.LeadsMediator;
import leads.views.LogView;
import leads.views.LogViewMediator;
import leads.views.MainView;
import leads.views.MainViewMediator;
import leads.views.NewLeadMediator;
import leads.views.NewLeadView;
import leads.views.events.SelectedLeadEvent;
import leads.views.events.ConfigEvent;

import org.robotlegs.mvcs.Context;

public class ApplicationContext extends Context {

    public function ApplicationContext() {
        super();
    }

    override public function startup():void
    {
        mediatorMap.mapView(Leads, LeadsMediator);
        mediatorMap.mapView(MainView, MainViewMediator);
        mediatorMap.mapView(LogView, LogViewMediator);
        mediatorMap.mapView(ConfigView, ConfigViewMediator);
        mediatorMap.mapView(NewLeadView, NewLeadMediator);

        commandMap.mapEvent(LeadEvent.START_CHECKING, StartCheckingCommand, LeadEvent);
        commandMap.mapEvent(LeadEvent.NEW_LEADS_TO_PREPARE, NewLeadsToPrepareCommand, LeadEvent);
        commandMap.mapEvent(ConfigEvent.SAVE_DATA, ConfigSaveCommand, ConfigEvent);
        commandMap.mapEvent(SelectedLeadEvent.LEAD_CLICKED, LeadClickedCommand, SelectedLeadEvent);

        injector.mapSingleton(ConfigModel);
        injector.mapSingleton(LeadsModel);
        injector.mapSingletonOf(ILeadsService, LeadsService);
    }

}
}