trigger ContactTrigger on Contact (before insert,before update) {
 ContactHandlerClass contactHandler=new ContactHandlerClass();
    if(trigger.isInsert){
        contactHandler.updateContactFields(Trigger.new,NULL,'Insert');
    }
    if(trigger.isUpdate){
        contactHandler.updateContactFields(Trigger.new,Trigger.oldMap,'Update');
    }
    
}