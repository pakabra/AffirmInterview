@isTest
private class TestContactTrigger {
    public static TestDataProvider tdp = new TestDataProvider();
    
 @testSetup
    static void setup()
    {  
       list<Account> accountsList=tdp.listAccounts(5,0);
       insert accountsList;
        
        list<Contact> contactssList=tdp.listContacts(5, 0);
        contactssList[0].AccountId=accountsList[0].Id;
        contactssList[1].AccountId=accountsList[1].Id;
        contactssList[2].AccountId=accountsList[2].Id;
        contactssList[3].AccountId=accountsList[3].Id;
        contactssList[4].AccountId=accountsList[4].Id;
        insert contactssList;
    }
    static testMethod void testInsertRecords(){
        Account accountRecord=[SELECT Id,Name,Industry
                                    FROM Account
                                    WHERE Name= 'Test Client #1'];
        system.debug('accountRecord==='+accountRecord.Industry);
        Contact contactsRecord=tdp.singleContact(6);
        contactsRecord.AccountId=accountRecord.Id;
        
        test.startTest();
        insert contactsRecord;
        test.stopTest();
        Contact updatedContact=[SELECT Account_Industry__c
                                     FROM Contact
                                     WHERE Id =:contactsRecord.Id];
         System.assertEquals(accountRecord.Industry,updatedContact.Account_Industry__c,'Record Updated');
    }
    static testMethod void testUpdateRecords(){
        Account accountRecord=tdp.singleAccount(6);
        accountRecord.Industry='Utilities';
        insert accountRecord;
        
        Contact contactToUpdate=[SELECT Id,Name,AccountId,Account_Industry__c
                                            FROM Contact
                                            WHERE FirstName = 'Test C # 3'
                                           ];
        
        contactToUpdate.AccountId=accountRecord.Id;
        test.startTest();
          update contactToUpdate;
        test.stopTest();
         Contact updatedContact=[SELECT Account_Industry__c
                                     FROM Contact
                                     WHERE Id =:contactToUpdate.Id];
         System.assertEquals(accountRecord.Industry,updatedContact.Account_Industry__c,'Records Updated');
    }
}