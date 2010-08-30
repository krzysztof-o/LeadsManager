package cases {
import flash.events.Event;
import flash.events.EventDispatcher;

import flexunit.framework.Assert;

import leads.models.ConfigModel;
import leads.views.ConfigView;
import leads.views.ConfigViewMediator;

import org.flexunit.async.Async;
import org.fluint.uiImpersonation.UIImpersonator;

public class TestConfigViewMediator {
    private var view:ConfigView;
    private var mediator:ConfigViewMediator;

    public function TestConfigViewMediator() {
    }

    [Before(async, ui)]
    public function setUp():void
    {
        this.view = new ConfigView();
        this.mediator = new ConfigViewMediator();

        this.mediator.view = view;
        this.mediator.setViewComponent(view);
        this.mediator.eventDispatcher = new EventDispatcher();

        var userModel:ConfigModel = new ConfigModel();
        mediator.userModel = userModel;
        
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
        Assert.assertTrue(view.hasEventListener(Event.REMOVED_FROM_STAGE));
        mediator.onRemove();
        Assert.assertFalse(view.hasEventListener(Event.REMOVED_FROM_STAGE));
        mediator.onRegister();
    }


    [Test(async)]
    public function testHandleError():void
    {
        var userModel:ConfigModel = new ConfigModel();
        userModel.save("test@test.pl", "haslo123", false, 100);

        view.emailTextInput.text = "test@test.pl";
        view.passwordTextInput.text = "haslo123";
        view.openOnStartupCheckbox.selected = false;
        view.timeTextInput.text = "100";

        view.addEventListener(Event.REMOVED_FROM_STAGE,
                Async.asyncHandler(this, handleRemoveFromStage, 2000, userModel));
        view.dispatchEvent(new Event(Event.REMOVED_FROM_STAGE));
    }

    public function handleRemoveFromStage(event:Event, passThroughData:Object):void {

        Assert.assertObjectEquals(passThroughData.email, mediator.userModel.email);
    }
    

}
}