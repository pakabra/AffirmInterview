/*Batch Apex for updating the contacts count on Account
 * Schedulable Apex: ContactsCountUpdateonAccountSchedule
 * TestClass: TestContactsCountUpdateonAccount
*/
public class ContactsUpdateOnAccountBatch implements Database.Batchable<AggregateResult>{
    public Iterable<AggregateResult> start(Database.BatchableContext bc){
        String query = 'SELECT AccountId, Count(Id) CNT FROM Contact WHERE AccountId != null GROUP BY AccountId';
        return  new AggregateResultIterable(query);
    }
    
    public void execute(Database.BatchableContext bc, List<sObject> scope){
        List<Account> accountsToUpdate = new List<Account>();
        for(sObject  tmpContact : scope) {
            AggregateResult a = (AggregateResult)tmpContact;
            Account account = new Account(Id = (Id) a.get('AccountId'));
            account.Number_of_Contacts__c = (Integer) a.get('CNT');
            accountsToUpdate.add(account);
        }
        
        try {
            UPDATE accountsToUpdate;
        } catch(Exception err) {
            //Process error here with logging framework 
            System.debug('Error while processing the batch' + err);
        }
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
}