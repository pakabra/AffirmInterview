@isTest
public class TestContactsCountUpdateonAccount {
 public static TestDataProvider tdp = new TestDataProvider();
    
 @testSetup
    static void setup()
    {  
       list<Account> accountsList=tdp.listAccounts(3,0);
       insert accountsList;
        
       
        list<Contact> contactssList=tdp.listContacts(5, 0);
       
        for(Integer i=0;i< contactssList.size();i++){
            system.debug('contactssList[i]=='+contactssList[i]);
            contactssList[i].AccountId=accountsList[0].Id;
        }
         insert contactssList;
       
    }
    static testMethod void testBatchApex(){
         Test.startTest();
        ContactsUpdateOnAccountBatch batchApex = new ContactsUpdateOnAccountBatch();
        Database.executeBatch(batchApex);
        Test.stopTest();
        Account accountRecord=[SELECT Id,Name,Number_of_Contacts__c
                               FROM Account
                               WHERE Name='Test Client #0'];
        list<AggregateResult> updatedCount=[SELECT AccountId, COUNT(Id)sum 
                                            FROM Contact
                                            WHERE AccountId =:accountRecord.Id 
                                              GROUP BY AccountId
                                              LIMIT 1];
         AggregateResult a = (AggregateResult)updatedCount[0];
        Integer contactsCount=(Integer) a.get('sum');
        system.assertEquals(contactsCount,accountRecord.Number_of_Contacts__c,'SUCCESS');
    }
    public static testMethod void testschedule() {
        
        Test.StartTest();
        ContactsCountUpdateonAccountSchedule scheduleApex = new ContactsCountUpdateonAccountSchedule();
        
        String scheduleChron = '0 0 23 * * ?'; 
        system.schedule('Test Schedule Apex', scheduleChron, scheduleApex); 
        Test.stopTest(); 
    }
}