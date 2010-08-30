package leads.models.vo {
public class ConfigVO {
    
    public var email:String;
    public var password:String;
    public var openOnStartup:Boolean;
    public var timeInterval:Number;
    
    public function ConfigVO(email:String="", password:String="", openOnStartup:Boolean=true, timeInterval:Number=30) {
        this.email = email;
        this.password = password;
        this.openOnStartup = openOnStartup;
        this.timeInterval = timeInterval;
    }
}
}