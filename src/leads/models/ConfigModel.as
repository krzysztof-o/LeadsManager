package leads.models {
import flash.data.EncryptedLocalStore;
import flash.desktop.NativeApplication;
import flash.net.registerClassAlias;
import flash.utils.ByteArray;

import leads.models.vo.ConfigVO;
import leads.views.events.ConfigEvent;

import org.robotlegs.mvcs.Actor;

public class ConfigModel extends Actor{

    public var vo:ConfigVO;
    private const ENCRYPTED_LOCAL_STORE_KEY:String = "config_key";

    public function ConfigModel()
    {
        registerClassAlias("UserVO", ConfigVO);
        //getLocalData();
    }

    public function getLocalData():void
    {
        
        var bytes:ByteArray = EncryptedLocalStore.getItem(ENCRYPTED_LOCAL_STORE_KEY);

        if(bytes)
        {
            vo = bytes.readObject() as ConfigVO;
        }
        else
        {
            vo = new ConfigVO();
       }
        
        dispatch(new ConfigEvent(ConfigEvent.DATA_LOADED, vo));
  }

    public function save(vo:ConfigVO):void
{
       this.vo = vo;
        
        try
        {
           NativeApplication.nativeApplication.startAtLogin = vo.openOnStartup;
        }
        catch(e:*){}

        EncryptedLocalStore.reset();
        var bytes:ByteArray = new ByteArray();
        bytes.writeObject(vo);

        EncryptedLocalStore.setItem(ENCRYPTED_LOCAL_STORE_KEY, bytes);
    }

}
}