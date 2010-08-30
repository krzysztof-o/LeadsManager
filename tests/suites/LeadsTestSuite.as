package suites{
import cases.TestConfigViewMediator;
import cases.TestLogViewMediator;
import cases.TestMainViewMediator;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class LeadsTestSuite {
    
    public var testLeadsService:TestLogViewMediator;
    public var testConfigViewMediator:TestConfigViewMediator;
    public var testMainViewMediator:TestMainViewMediator;
    
    public function LeadsTestSuite() {


    }
}
}