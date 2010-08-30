package leads.views {
import flash.desktop.DockIcon;
import flash.desktop.NativeApplication;
import flash.desktop.SystemTrayIcon;
import flash.display.NativeMenu;
import flash.display.NativeMenuItem;
import flash.events.Event;
import flash.events.InvokeEvent;
import flash.events.MouseEvent;
import flash.system.Capabilities;

import leads.models.events.LeadEvent;

import mx.core.Window;
import mx.events.FlexEvent;

import org.robotlegs.mvcs.Mediator;

public class LeadsMediator extends Mediator{

    [Inject]
    public var view:Leads;

    [Embed(source="/../assets/app_icons/icon16.png")]
    private var icon16:Class;

    private var allowExitForMacs:Boolean = false;

    public function LeadsMediator() {
    }

    override public function onRegister():void {
        addContextListener(LeadEvent.NEW_LEADS, handleNewLeads);
        handleCreationComplete();
    }

    private function handleNewLeads(event:LeadEvent):void {
        unDock();
    }

    private function handleCreationComplete(event:FlexEvent=null):void
    {
        NativeApplication.nativeApplication.autoExit = false;

        if(NativeApplication.supportsDockIcon)
        {
            var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
            NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, unDock);
            dockIcon.menu = createIconMenu();
        } else if (NativeApplication.supportsSystemTrayIcon)
        {

            var sysTrayIcon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
            sysTrayIcon.tooltip = "Leads Manager";
            sysTrayIcon.addEventListener(MouseEvent.CLICK, unDock);
            sysTrayIcon.menu = createIconMenu();
            NativeApplication.nativeApplication.icon.bitmaps = [(new icon16()).bitmapData];
            NativeApplication.nativeApplication.addEventListener(Event.EXITING, handleExiting);
        }
        addMacSupport();
    }

    private function handleExiting(event:Event):void {
        event.preventDefault();
    }


    private function unDock(event:*=null):void {
        view.nativeWindow.visible = true;
    }

    private function createIconMenu():NativeMenu
    {
        var iconMenu:NativeMenu = new NativeMenu();
        if(NativeApplication.supportsSystemTrayIcon){

            var exitCommand: NativeMenuItem = iconMenu.addItem(new NativeMenuItem("ZakoÄcz"));
            exitCommand.addEventListener(Event.SELECT, quitApplication);
        }
        return iconMenu;
    }

    private function quitApplication(event:Event):void {
        view.exit();
    }

    private function addMacSupport():void
    {
        if ( Capabilities.os.indexOf("Mac") == 0 )
        {
            var win:Window = new Window();
            win.visible = false;
            win.open(false);
            win.addEventListener(Event.CLOSING,handleMacClosing);

            view.addEventListener(InvokeEvent.INVOKE, handleInvoke);
        }
        view.addEventListener(Event.CLOSING, handleClosing);
    }

    private function handleMacClosing(event:Event):void
    {
        allowExitForMacs = true;
    }

    private function handleInvoke(event:InvokeEvent):void
    {
        if ( view.nativeWindow && !view.nativeWindow.visible )
        {
            view.nativeWindow.visible = true;
            view.nativeWindow.activate();
        }
    }


    private function handleClosing(event:Event):void
    {
        event.preventDefault();
        view.callLater(checkIfExit);
    }

    private function checkIfExit():void
    {
        if ( allowExitForMacs ) {
            view.nativeApplication.exit();
        }
        else {
            view.nativeWindow.visible = false;
        }
    }

}
}