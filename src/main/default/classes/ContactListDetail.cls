public class ContactListDetail {
    public String contId {get; set;}
    public List<Contact> contList {get; set;}
    public Contact cont {get; set;} 

    public ContactListDetail(ApexPages.StandardController controller) {
        contList = [SELECT Id, Name, Account.Name FROM Contact ORDER BY CreatedDate];   
    }
    public PageReference fetchDetail(){
        if (contId != null){
            cont = [SELECT Id, FirstName, LastName, Account.Name, Phone, Email FROM Contact WHERE Id = :contId];
        }           
        PageReference pageRef = new PageReference('/apex/ContactVFPage');
        return pageRef;
    }

}