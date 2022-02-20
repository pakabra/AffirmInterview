@isTest
private class TestLWCDemoController {
 public static TestDataProvider tdp = new TestDataProvider();
    
 @testSetup
    static void setup()
    {  
       list<Account> accountsList=tdp.listAccounts(5,0);
       insert accountsList;
    }
    static testMethod void testFetchList(){
        test.startTest();
        list<Account> accountsList=LWCDemoController.getAccounts();
        test.stopTest();
        system.assertEquals(5,accountsList.size(),'SUCCESS');
    }
    static testMethod void testDetails(){
        Account accountRecord=[SELECT Id,Name
                               FROM Account
                               WHERE NAME ='Test Client #1'
                               ];
        test.startTest();
        LWCDemoController.AccountDetails record=LWCDemoController.getAccountDetails(accountRecord.Id);
        test.stopTest();
        system.assertEquals(accountRecord.Name,record.name,'SUCCESS');
    }
}
