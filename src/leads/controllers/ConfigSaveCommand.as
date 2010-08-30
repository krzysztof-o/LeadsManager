package leads.controllers {
import leads.models.ConfigModel;

import leads.views.events.ConfigEvent;

import org.robotlegs.mvcs.Command;

public class ConfigSaveCommand extends Command
{

    [Inject]
    public var model:ConfigModel;

    [Inject]
    public var event:ConfigEvent;

    override public function execute():void {
        model.save(event.vo);
    }
}
}