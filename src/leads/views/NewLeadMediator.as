package leads.views {
import leads.models.LeadsModel;
import leads.views.events.SelectedLeadEvent;

import org.robotlegs.mvcs.Mediator;

public class NewLeadMediator extends Mediator {

    [Inject]
    public var view:NewLeadView;

    [Inject]
    public var model:LeadsModel;

    override public function onRegister():void
    {
        addViewListener(SelectedLeadEvent.LEAD_CLICKED, dispatch);
        view.dataGrid.dataProvider = model.leads;
    }


}
}