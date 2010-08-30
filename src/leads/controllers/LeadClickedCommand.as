package leads.controllers {
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.navigateToURL;

import leads.models.ConfigModel;
import leads.models.LeadsModel;
import leads.models.vo.LeadVO;
import leads.views.events.SelectedLeadEvent;

import org.robotlegs.mvcs.Command;

public class LeadClickedCommand extends Command{

    [Inject]
    public var event:SelectedLeadEvent;

    [Inject]
    public var model:LeadsModel;

    [Inject]
    public var userModel:ConfigModel;

    override public function execute():void
    {

        //Console.log("lead clicked" + event.vo.link)
        var request:URLRequest = new URLRequest(event.vo.link);
        
        request.method = URLRequestMethod.POST;

        var requestData:URLVariables = new URLVariables();
        requestData.email = userModel.vo.email;
        requestData.haslo = userModel.vo.password;
        requestData.zaloguj = "Zaloguj";

        request.data = requestData;

        navigateToURL(request);

        model.markLeadAsVisited(event.vo);
        
        model.refreshLeads();
    }
}
}