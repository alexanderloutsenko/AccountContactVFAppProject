public class ContactListDetail {
    public String contId {get; set;}
    public List<Contact> contList {get; set;}
    public Contact cont {get; set;}
    public List<Id> accIds;
    
    public ContactListDetail() {
        System.debug(System.CurrentPageReference().getParameters().size());
        Integer numOfParams = System.CurrentPageReference().getParameters().size();
        //String accId = System.CurrentPageReference().getParameters().get('id1');
        accIds = new List<Id>();
        for (Integer i = 1; i <= numOfParams; i++) {
            accIds.add(System.CurrentPageReference().getParameters().get('id'+i));
        }
        contList = [SELECT Id, Name, Account.Name 
                      FROM Contact 
                     WHERE AccountId IN: accIds 
                     ORDER BY CreatedDate];   
    }

    public PageReference fetchDetail(){
        if (contId != null){
            cont = [SELECT Id, FirstName, LastName, Account.Name, Phone, Email 
                      FROM Contact 
                     WHERE Id = :contId];
        }           
        PageReference pageRef = new PageReference('/apex/ContactVFPage');
        return pageRef;
    }

}