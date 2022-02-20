public with sharing class LWCDemoController {
    @AuraEnabled(cacheable =true)
    public static list<Account> getAccounts(){
        return [SELECT Id,name 
                FROM Account 
                LIMIT 5];
    }
     @AuraEnabled
    public static Account getAccountDetails(string recordId){
        return [SELECT Id, Name, Industry, Type, Owner.Name,Owner.SmallPhotoUrl  
                FROM Account 
                WHERE id=:recordId ];
    }
}