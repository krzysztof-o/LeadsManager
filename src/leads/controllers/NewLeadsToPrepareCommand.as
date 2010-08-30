package leads.controllers {
import leads.models.LeadsModel;
import leads.models.events.LeadEvent;

import leads.models.events.LeadStatusEvent;

import org.robotlegs.mvcs.Command;

public class NewLeadsToPrepareCommand extends Command{

    [Inject]
    public var event:LeadEvent;

    [Inject]
    public var model:LeadsModel;

    override public function execute():void {

        if(model.addLeadsWithoutDuplicates(event.leads))
        {
            dispatch(new LeadEvent(LeadEvent.NEW_LEADS));
        }
        else
        {
            dispatch(new LeadEvent(LeadEvent.NO_LEADS));
        }
    }
}
}