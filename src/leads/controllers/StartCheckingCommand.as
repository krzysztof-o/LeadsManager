package leads.controllers {
import leads.models.ConfigModel;
import leads.remote.services.ILeadsService;

import org.robotlegs.mvcs.Command;

public class StartCheckingCommand extends Command {

    [Inject]
    public var service:ILeadsService;

    [Inject]
    public var model:ConfigModel;

    
    override public function execute():void {
        model.getLocalData();
        service.startChecking();
    }
}
}