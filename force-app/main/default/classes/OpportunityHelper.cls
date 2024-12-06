public with sharing class OpportunityHelper {

// helper class helps avoid complex logic in triggers

    // QUESTION 5
    public static void over5000(List<Opportunity> newOpps) {
        for (Opportunity opp : newOpps) {
            if (opp.Amount < 5000 && opp.Amount != null) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    // QUESTION 6
    public static void betterNotDelete(List<Opportunity> oldOpps) {
        Set<Id> accIds = new Set<Id>();
        for (Opportunity opp : oldOpps) {
            accIds.add(opp.AccountId);
        }
        
        Map<Id, Account> idToAccount = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accIds]);

        for (Opportunity opp : oldOpps) {
            if (opp.StageName == 'Closed Won' && idToAccount.get(opp.AccountId).Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }

    // QUESTION 7
    public static void getTheCEO(List<Opportunity> newOpps) {
        Set<Id> accIds = new Set<Id>();
        for (Opportunity opp : newOpps) {
            accIds.add(opp.AccountId);
        }

        List<Contact> findTheCeo = [SELECT Id, AccountId FROM Contact WHERE AccountID IN :accIds AND Title = 'CEO'];
        
        for (Opportunity opp : newOpps) {
            for (Contact con : findTheCeo) {
                if (opp.AccountId == con.AccountId) {
                    opp.Primary_Contact__c = con.Id;
                }
            }
        }
    }

}