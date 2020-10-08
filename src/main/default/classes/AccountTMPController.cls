public class AccountTMPController {
    public List<WrapAccount> wrapAccList {get; set;} // as soon as I am passing the WrapAccount to controller this is automatically set to the sent values
    public List<Id> idList = new List<Id>();
    //public Id accountIdChosen {get; set;}
    public PageReference pageRef;    
    
    public AccountTMPController() {
       if(wrapAccList == null){
          	wrapAccList = new List<WrapAccount>();
          	for(Account a : [SELECT Id, Name, AnnualRevenue FROM Account ORDER BY CreatedDate LIMIT 20])
          	{
           		wrapAccList.add(new WrapAccount(a));
           	}                       
     	}
    }
    // method populating selected ids list 
    public void addSelectedAccId(Id accId) {
		idList.add(accId);
        System.debug('**idList size is '+idList.size());
    }
    
    public PageReference redirectToContactPage () { 
		//form the list of account ids to pass to Contact page
        for (WrapAccount wa : wrapAccList) {
            if (wa.isSelected){
                addSelectedAccId(wa.waccId);
            }
        }
        // form the URL for Contact page redirect with parameters to pass
        pageRef = new PageReference('/apex/ContactVFPage');
        pageRef.setRedirect(true);
        for(Integer i = 1; i <= idList.size(); i++) {
        	pageRef.getParameters().put('id'+i, idList[i-1]);
        }        
        return pageRef;
    }		
    
    // account+checkbox wrapper class
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