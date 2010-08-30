package leads.remote.services {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.events.TimerEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.utils.Timer;

import leads.models.ConfigModel;
import leads.models.events.LeadEvent;
import leads.models.vo.LeadVO;

import ms.c4.utils.Console;

import org.robotlegs.mvcs.Actor;

public class LeadsService extends Actor implements ILeadsService {

    [Inject]
    public var userModel:ConfigModel;

    private static const LOGIN_URL:String = "https://www.ubezpieczeniaonline.pl/lead/";
    //private static const LEADS_URL:String = "https://www.ubezpieczeniaonline.pl/lead/system/wszystkie_leady.php";

    private var loader:URLLoader;
    private var timer:Timer;

    public function LeadsService() {
        loader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, onComplete);
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
    }

    public function startChecking():void
    {
        timer = new Timer(Number(userModel.vo.timeInterval) * 1000);
        timer.addEventListener(TimerEvent.TIMER, handleTimer);
        handleTimer();
        timer.start();
    }

    private function handleTimer(event:TimerEvent=null):void
    {
        dispatch(new LeadEvent(LeadEvent.CHECKING));
        
        var request:URLRequest = new URLRequest(LOGIN_URL);
        request.method = URLRequestMethod.POST;

        var requestData:URLVariables = new URLVariables();
        requestData.email = userModel.vo.email;
        requestData.haslo = userModel.vo.password;
        requestData.zaloguj = "Zaloguj";
        /*
        requestData.kategoria = "2";
        requestData.miejsce = "2";
        requestData.filtr_leady = "Zastosuj";
        */
        
        request.data = requestData;

        loader.load(request);
    }

    private function onIOError(event:IOErrorEvent):void
    {
        dispatch(new LeadEvent(LeadEvent.E_IO_ERROR));
    }

    private function onSecurityError(event:SecurityErrorEvent):void
    {
        dispatch(new LeadEvent(LeadEvent.E_SECURUTY_ERROR));
    }

    private function onComplete(event:Event):void
    {
        parseData(loader.data);
    }

    private function parseData(data:String):void
    {
        if(data.indexOf("Wyloguj") > -1)
        {
            if(data.indexOf("brak nowych LEAD") > -1 || data.indexOf("Filtr LEAD") == -1)
            {
                dispatch(new LeadEvent(LeadEvent.NO_LEADS));
            }
            else
            {
                parseLeads(data);
            }
        }
        else
        {
            dispatch(new LeadEvent(LeadEvent.E_LOGIN_ERROR));
        }
    }

    private function parseLeads(data:String):void
    {
        var exp:RegExp = /<table id="lead_lista" class="lista" cellpadding="0" cellspacing="0">(.*?)<\/table>/g;
        var matches:Object = exp.exec( data);
        var table:String = matches[1];

        exp = /<tr(.*?)>(.*?)<\/tr>/g;
        //matches = exp.exec(table);
        var matchesArr:Array = table.match(exp);
        //var i:uint = 0;
        matchesArr = matchesArr.slice(1);
        var tdExp:RegExp = /<td(.*?)>(.*?)<\/td>/g;

        var leads:Array = [];

        for each(var row:String in matchesArr)
        {
            //Console.log("Row "+(++i));
            var td:Array = row.match(tdExp);
            Console.log(td);
            Console.log(td[1]);
            var vo:LeadVO = new LeadVO();
            vo.type = /<td(.*?)>(.*?)<\/td>/.exec(td[1])[2];
            vo.nr = /<td(.*?)>(.*?)<\/td>/.exec(td[2])[2];
            vo.address = /<td(.*?)>(.*?)<\/td>/.exec(td[3])[2];
            vo.link = "https://www.ubezpieczeniaonline.pl" + /<td(.*?)href="(.*?)"/.exec(td[6])[2];

            //Console.log(vo);

            leads.push(vo);
        }
        dispatch(new LeadEvent(LeadEvent.NEW_LEADS_TO_PREPARE, leads));

    }
    
    /*
    private function logStatus(str:String):void
    {
        dispatch(new LeadStatusEvent(LeadStatusEvent.LOG, str));
    }
    */

}
}