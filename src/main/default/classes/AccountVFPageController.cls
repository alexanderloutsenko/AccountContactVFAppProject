public class AccountVFPageController {
    public ApexPages.StandardController stndController {get; set;} 
    public List<WrapAccount> wrapAccList {get; set;} // as soon as I am passing the WrapAccount to controller this is automatically set to the sent values
    public List<ID> accIds ;
    public List<ID> tmpAccId {get; set;}
    public Set<Id> idSet = new Set<Id>();// remove this Set as it's an extra collection
    public Id accountIdChosen {get;}// below is a setter for this property
    public void setAccountIdChosen (Id accId){
        for(WrapAccount w : wrapAccList) {
            if(accId == w.waccId) {
                if(w.isSelected) {
                    w.isSelected = false;
                } else {
                    w.isSelected = true;
                }    
            }
        }
        System.debug('** setAccountIdChosen method -- account '+accId+' got its isSelected changed');
        //setIsSelected(accId);
    } 
    
    public AccountVFPageController() {
        //accListToLoad = [SELECT Id, Name, AnnualRevenue FROM Account ORDER BY CreatedDate LIMIT 20]; 
        //selectedAccId = new List<Account>(); 
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
    
    //property to get and set the selected account Id


    
    //add selected account Id into the list
    public void setSelectedAccId () {
        for(WrapAccount w : wrapAccList) {
            if(idSet.contains(w.waccId)) {
                if(!w.isSelected) {
                    idSet.remove(w.waccId);
                    System.debug(w.waccId + ' removed from idSet collection');
                }     
            } else {
                idSet.add(w.waccId);
                System.debug(w.waccId + ' added to idSet collection');
            }
        } 
        System.debug('**parameter passed to controller is '+tmpAccId);
    }
   
   // distinguish selected accounts and put them into the local List<Id>
   public void selectedRecords(){
     accIds = new List<Id>();     
      for(WrapAccount wra : wrapAccList){
           if(wra.isSelected == true){
           		accIds.add(wra.waccId);
           }                 
       }
       System.debug('**inside of selected records - accIds.size()=' + accIds.size());
       System.debug('**inside of selected records - idSet.size()=' + idSet.size());       
    }
    
    public void setAccIds () {
        selectedRecords();
        for (Id accIdToStore : idSet) {            
            System.debug('**selected Account\'s Id: ' + accIdToStore);
            //here you should put the code to set PageReference parameters
        }
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