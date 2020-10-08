public class ContactListDetail {
    public String contId {get; set;}
    public List<Contact> contList {get; set;}
    public Contact cont {get; set;} 
    
    public ContactListDetail() {
        System.debug(System.CurrentPageReference().getParameters());
        String accId = System.CurrentPageReference().getParameters().get('id');
        contList = [SELECT Id, Name, Account.Name FROM Contact where AccountId =: accId ORDER BY CreatedDate];   
    }

    public PageReference fetchDetail(){
        if (contId != null){
            cont = [SELECT Id, FirstName, LastName, Account.Name, Phone, Email FROM Contact WHERE Id = :contId];
        }           
        PageReference pageRef = new PageReference('/apex/ContactVFPage');
        return pageRef;
    }

}