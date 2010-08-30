package leads.views.components {
import leads.views.components.skins.IconTabBarSkin;

import spark.components.TabBar;

[Style(name="icon", type="")]


public class IconTabBar extends TabBar {
    public function IconTabBar() {
        super();
        setStyle("skinClass", IconTabBarSkin);
        buttonMode = useHandCursor = true;
    }
}
}