public class ContactsCountUpdateonAccountSchedule implements schedulable{
 public void execute(SchedulableCOntext sc){
        ContactsUpdateOnAccountBatch batchJob=new ContactsUpdateOnAccountBatch();
        Database.executeBatch(batchJob); //executing with default batch size of 200 records
    }
}