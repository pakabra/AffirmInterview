/*This class provides data for test classes*/
public class TestDataProvider {
    //Account
    private Account singleTestAccount = new Account();
    private List<Account> listTestAccounts = new List<Account>();
    //Contact
    private Contact singleTestContact = new Contact();
    private List<Contact> listTestContacts = new List<Contact>();
    
     public Account singleAccount(Integer index){
            singleTestAccount = new Account(
                Name = 'Test #' + index,
                Description='This is a test account', 
                BillingStreet='1 Main St.', 
                BillingState='TX', 
                BillingPostalCode='78202', 
                BillingCountry='USA', 
                BillingCity='San Antonio', 
                AnnualRevenue=10000,
                Type='Other',
                Industry='Other'
            );
             return singleTestAccount;
    }
     public List<Account> listAccounts(Integer num, Integer index){
       
            for(Integer i = 0; i < num; i++){
                Account temp = new Account(
                    Name = 'Test Client #' + i,
                    Phone = '210-555-0000',
                    Description='This is a test account', 
                    BillingStreet='1 Main St.', 
                    BillingState='TX', 
                    BillingPostalCode='78202', 
                    BillingCountry='USA', 
                    BillingCity='San Antonio', 
                    AnnualRevenue=10000,
                    Type='Other',
                    Industry='Other'
                );
                listTestAccounts.add(temp);
                index ++;
            }
        return listTestAccounts;
    }
    
     public Contact singleContact(Integer index){
        singleTestContact = new Contact(
            FirstName = 'Test C # '+ index,
            LastName = 'Contact # ' + index,
            Phone = '210555555'+ index
        );
        
        return singleTestContact;
    }
    public List<Contact> listContacts(Integer num, Integer index){
        for(Integer i = 0; i < num; i++){
            Contact temp = new Contact(
                FirstName = 'Test C # '+ index,
                LastName = 'Contact #' + index,
                Phone = '210555555'+ index
            );
            listTestContacts.add(temp);
            index ++;
        }
        
        return listTestContacts;
    }
}