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
   
    public static testMethod void testschedule() {
        
        Test.StartTest();
        ContactsCountUpdateonAccountSchedule scheduleApex = new ContactsCountUpdateonAccountSchedule();
        
        String scheduleChron = '0 0 23 * * ?'; 
        system.schedule('Test Schedule Apex', scheduleChron, scheduleApex); 
        Test.stopTest(); 
    }
}
