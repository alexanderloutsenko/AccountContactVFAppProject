public class SelectAccountController {
    
    public Id selectedAccId {get; set;}
    public List<Account> accList {get; set;}
    public List<Contact> contList {get; set;}
    //public Contact cont {get; set;}
    public Set<ID> accIds {get; set;} 

    public SelectAccountController(ApexPages.StandardSetController setController) {
    accList = setController.getSelected();
        System.debug('*inside of constructor before FOR loop ');
        for (Account acc : accList) {
            System.debug('*inside of constructor -- selected Account : ' + acc);
        }
        //contList = [SELECT Id, Name, Account.Name FROM Contact ORDER BY CreatedDate];   
    }
    
    public void setAccIds () {
       /* for(Account a : selected) {
            accIds.add(a.Id);
        }
        System.debug('we\'ve got the following num of ids in the set:' + accIds.size());*/
        string passedParam1 = Apexpages.currentPage().getParameters().get('selectedAccounts');
        string passedParam2 = system.CurrentPageReference().getParameters().get('selectedAccounts');
        system.debug(passedParam1);
        system.debug(passedParam2);
        //accList = setController.getSelected();
        for (Account acc : accList) {
            System.debug('**selected Account : ' + acc);
        }
    }
    
   /* public PageReference fetchDetail(){
        if (contId != null){
            cont = [SELECT Id, FirstName, LastName, Account.Name, Phone, Email FROM Contact WHERE Id = :contId];
        }           
        PageReference pageRef = new PageReference('/apex/ContactVFPage');
        return pageRef;
    }	*/
}