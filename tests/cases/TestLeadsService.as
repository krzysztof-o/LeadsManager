package cases {
import flexunit.framework.Assert;

import leads.remote.services.ILeadsService;

public class TestLeadsService {

    private var leadsService:ILeadsService;
    private var str:String;
    
    public function TestLeadsService() {
    }
    [Before]
    public function setUp():void
    {

    }

    [After]
    public function tearDown():void
    {

    }
    [Test]
    public function testParseData():void
    {
        Assert.assertTrue(true);
    }

}
}