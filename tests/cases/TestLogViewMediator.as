package cases {
import flash.events.Event;
import flash.events.EventDispatcher;

import flexunit.framework.Assert;

import leads.models.events.LeadStatusEvent;
import leads.views.LogViewMediator;
import leads.views.LogView;

import org.flexunit.async.Async;
import org.fluint.uiImpersonation.UIImpersonator;

public class TestLogViewMediator {
    public function TestLogViewMediator() {}


    private var view:LogView;
    private var mediator:LogViewMediator;

    [Before(async, ui)]
    public function setUp():void
    {
        this.view = new LogView();
        this.mediator = new LogViewMediator();

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
        Assert.assertTrue(mediator.eventDispatcher.hasEventListener(LeadStatusEvent.LOG));
        mediator.onRemove();
        Assert.assertFalse(mediator.eventDispatcher.hasEventListener(LeadStatusEvent.LOG));
        mediator.onRegister();
    }

    [Test(async)]
    public function testHandleError():void
    {
        var passThroughtData:String = "przykladowy blad";
        mediator.eventDispatcher.addEventListener(LeadStatusEvent.LOG,
                Async.asyncHandler(this, handleError, 2000, passThroughtData));
        mediator.eventDispatcher.dispatchEvent(new LeadStatusEvent(LeadStatusEvent.LOG, passThroughtData));
    }

    public function handleError(event:LeadStatusEvent, passThroughData:Object):void {

        Assert.assertContained(passThroughData, view.textArea.text);
        Assert.assertEquals( view.textArea.scroller.verticalScrollBar.value, view.textArea.scroller.verticalScrollBar.maximum);
    }

    
}
}