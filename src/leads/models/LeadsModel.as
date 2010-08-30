package leads.models {
import flash.utils.Dictionary;

import leads.models.vo.LeadVO;

import mx.collections.ArrayCollection;

import org.robotlegs.mvcs.Actor;

public class LeadsModel extends Actor{
    public var leads:ArrayCollection;
    private var nrs:Dictionary;

    public function LeadsModel()
    {
        leads = new ArrayCollection();
        leads.filterFunction = filterFunction;
        nrs = new Dictionary();
    }
    private function filterFunction(item:LeadVO):Boolean
    {
           return !item.visited;
    }

    public function addLeadsWithoutDuplicates(leads:Array):Boolean
    {
        var anyNew:Boolean = false;
        for each(var newLead:LeadVO in leads)
        {
            if(!hasLead(newLead) && passFilter(newLead))
            {
                addLead(newLead);
                anyNew = true;
            }
        }

        return anyNew;
    }

    private function passFilter(lead:LeadVO):Boolean
    {
        return (/(.*?)yciowy/.test(lead.type)
                && /ma(.*?)opolskie/.test(lead.address)
                );
    }

    private function hasLead(newLead:LeadVO):Boolean
    {
        return (nrs[newLead.nr] != null);
    }

    private function addLead(vo:LeadVO):void
    {
        nrs[vo.nr] = true;
        leads.addItemAt(vo, 0);
    }
    
    /*
    private function removeLead(vo:LeadVO):void
    {
        leads.removeItemAt(leads.getItemIndex(vo));    
    }
    */

    public function refreshLeads():void
    {
        leads.refresh();
    }

    public function markLeadAsVisited(vo:LeadVO):void
    {
        vo.visited = true;
    }
}
}