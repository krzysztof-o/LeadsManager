package cases {
import flash.events.Event;
import flash.events.EventDispatcher;

import leads.models.events.LeadEvent;
import leads.views.MainView;
import leads.views.MainViewMediator;

import org.flexunit.Assert;
import org.flexunit.async.Async;
import org.fluint.uiImpersonation.UIImpersonator;

public class TestMainViewMediator {
    public function TestMainViewMediator() {
    }


    private var view:MainView;
    private var mediator:MainViewMediator;

    [Before(async, ui)]
    public function setUp():void
    {
        this.view = new MainView();
        this.mediator = new MainViewMediator();

        this.mediator.view = view;
        this.mediator.setViewComponent(view);
        this.mediator.eventDispatcher = new EventDispatcher();

        mediator.onRegister();

        Async.proceedOnEvent(this, this.view, Event.ADDED_TO_STAGE);
        UIImpersonator.addChild( this.view );
    }

    [After(async, ui)]
    public function tearDown():void
    {
        this.mediator.onRemove();
        this.mediator.eventDispatcher = null;
        this.view = null;
        this.mediator.view = null;
    }

    [Test]
    public function testViewExists():void
    {
        Assert.assertNotNull( mediator.view );
        Assert.assertNotNull( mediator.getViewComponent() );
    }

    [Test]
    public function testAddListeners()
    {
        Assert.assertTrue(mediator.eventDispatcher.hasEventListener(LeadEvent.NEW_LEADS));
    }
    
    [Test]
    public function testRemoveListener()
    {
        mediator.onRemove();
        Assert.assertFalse(mediator.eventDispatcher.hasEventListener(LeadEvent.NEW_LEADS));
        mediator.onRegister();
    }

    [Test(async)]
    public function testHandleNewLeads():void
    {
        mediator.eventDispatcher.addEventListener(LeadEvent.NEW_LEADS,
                Async.asyncHandler(this, handleNewLeads, 2000));
        mediator.eventDispatcher.dispatchEvent(new LeadEvent(LeadEvent.NEW_LEADS));
    }

    public function handleNewLeads(event:LeadEvent, passThroughData:Object):void {
        Assert.assertEquals(view.tabs.selectedIndex, 0)

    }

}
}