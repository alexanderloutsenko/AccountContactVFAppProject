public class AccountTMPController {
    public List<WrapAccount> wrapAccList {get; set;} // as soon as I am passing the WrapAccount to controller this is automatically set to the sent values
    public Set<Id> idSet = new Set<Id>();
    public Id accountIdChosen {get; set;}// below is a setter for this property
    public PageReference pageRef;
    
    
    public AccountTMPController() {
       if(wrapAccList == null){
          	wrapAccList = new List<WrapAccount>();
            //idSet = new Set<Id>();
          	for(Account a : [SELECT Id, Name, AnnualRevenue FROM Account ORDER BY CreatedDate LIMIT 20])
          	{
           		wrapAccList.add(new WrapAccount(a));
                //idSet.add(a.Id);
           	}                       
     	}
    }
    
    public void addSelectedAccId() {
		idSet.add(accountIdChosen);
        System.debug('**idSet has got additional element '+ accountIdChosen);  
        System.debug('**idSet size is '+idSet.size());
    }
    
    public PageReference redirectToContactPage () { 
        /*String passedParam1 = Apexpages.currentPage().getParameters().get('idsForURL');
        String passedParam2 = System.CurrentPageReference().getParameters().get('idsForURL');
        System.debug(passedParam1);
        System.debug(passedParam2);
        PageReference accTMPPage = Page.AccountTMP;*/
        
        //System.debug(accTMPPage.getParameters());
        String selectedId = '';
        for (WrapAccount wa : wrapAccList) {
            if (wa.isSelected){
                selectedId = wa.waccId ;
                break;
            }
        }
        pageRef = new PageReference('/apex/ContactVFPage');
        pageRef.setRedirect(true);
        //List<Contact> contList = [select Id from contact where accountId =:selectedId];
        pageRef.getParameters().put('id', selectedId);
        
                System.debug('**parameter passed to controller is '+ pageRef.getParameters());
        
        return pageRef;

    }		
    
    // account and checkbox wrapper class
    public class WrapAccount {    
    public Account wacc {get;set;}
    public Id waccId {get;set;} 
    public String waccName {get;set;}
    public Double waccAnnualRevenue {get;set;}
    public boolean isSelected {get;set;}
     
    public WrapAccount (Account a){     
         wacc = a;
         waccId = a.Id;
         waccName = a.Name;
         waccAnnualRevenue = a.AnnualRevenue;    
         isSelected = false;
       }
  }    
    
}