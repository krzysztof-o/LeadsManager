package leads.models.vo {
public class LeadVO {

    public var type:String;
    public var nr:String;
    public var address:String;
    public var link:String;
    public var visited:Boolean;
    
    public function LeadVO(type:String="", nr:String="", address:String="", link:String="", visited:Boolean=false) {
        this.type = type;
        this.nr = nr;
        this.address = address;
        this.link = link;
        this.visited = visited;
    }
}
}