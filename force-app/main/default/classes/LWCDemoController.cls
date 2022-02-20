public with sharing class LWCDemoController {
    @AuraEnabled(cacheable =true)
    public static list<Account> getAccounts(){
        return [SELECT Id,name 
                FROM Account 
                LIMIT 5];
    }
    @AuraEnabled
    public static AccountDetails getAccountDetails(string recordId){
        Account currentAccount = [select Id, Name, Industry, Type, Owner.Name,Owner.SmallPhotoUrl  from Account where id=:recordId limit 1 ];
        return new AccountDetails(
            currentAccount.Id, 
            currentAccount.Name, 
            currentAccount.Industry, 
            currentAccount.Type,  
            currentAccount.Owner.Name,
            currentAccount.Owner.SmallPhotoUrl
        );
    }
    
    public class AccountDetails {
        @AuraEnabled public String Id; 
         @AuraEnabled public String Name; 
         @AuraEnabled public String Industry; 
         @AuraEnabled public String Type; 
         @AuraEnabled public String OwnerName; 
         @AuraEnabled public String OwnerPhotoUrl; 
        
        public AccountDetails(String Id, String Name, String Industry, String Type, String OwnerName, String OwnerPhotoUrl) {
            this.Id = Id;
            this.Name = Name;
            this.Industry = Industry;
            this.OwnerName = OwnerName;
            this.Type = Type;
            this.OwnerPhotoUrl = OwnerPhotoUrl;
        }
    }
}
