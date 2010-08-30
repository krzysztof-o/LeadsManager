package leads.views.components {
import flash.events.Event;

import spark.components.ButtonBarButton;

public class IconButtonBarButton extends ButtonBarButton {

    private var _icon:*;
    private var iconChanged:Boolean;

    public function IconButtonBarButton() {
        super();
    }

    override public function set data(value:Object):void {

        if(value.icon && value.icon != icon)
        {
            iconChanged = true;
            invalidateProperties();
        }

        super.data = value;
    }



    [Bindable(event="iconChanged")]
    public function get icon():* {
        return _icon;
    }

    public function set icon(value:*):void {
        if (_icon == value) return;
        _icon = value;
        dispatchEvent(new Event("iconChanged"));
    }



    protected override function commitProperties():void {
        if(iconChanged)
        {
            iconChanged = false;
            icon = data.icon;
        }

        super.commitProperties();
    }
}
}