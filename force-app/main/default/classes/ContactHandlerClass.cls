/*Handler Class for ContactTrigger
 *TestClass : TestContactHandlerClass
*/
public class ContactHandlerClass {
    public void updateContactFields(list<Contact> contactsList,Map<Id,Contact> contactsOldMap, String operationType){
        Set<Id> accountIds = new Set<Id>(); //stores accountIds 
        list<Contact> contactsListToUpdate = new list<Contact>();// stores the contact records that needs to be updated
        for(Contact record: contactsList) {
            if(record.AccountId != null && ( operationType =='Insert'||
                                            contactsOldMap.get(record.Id).AccountId <> record.AccountId ||
                                            string.isBlank(record.Account_Industry__c))
              ){
                      contactsListToUpdate.add(record);
                      accountIds.add(record.AccountId);
            }
        }
        if(!accountIds.isEmpty()){
            Map<Id, Account> accountsMap = new Map<Id, Account>([SELECT Industry 
                                                                 FROM Account 
                                                                 WHERE Id = :accountIds
                                                                ]);
                for(Contact c: contactsList) {
                    c.Account_Industry__c = accountsMap.get(c.AccountId).Industry;
                }
        }
    }
}