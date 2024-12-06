public with sharing class OpportunityHelper {

// helper class helps avoid complex logic in triggers

    // QUESTION 5
    public static void overFiveGs(List<Opportunity> triggerNew) {
        for (Opportunity opp : triggerNew) {
            if (opp.Amount < 5000 && opp.Amount != null) {
                opp.addError('Opportunity amount must be greater than 5000'); // amount must be over 5000, otherwise, add error
            }
        }
    }

    // QUESTION 6
    public static void betterNotDelete(List<Opportunity> triggerOld) { // Trigger.old holds the old versions of the records
        Set<Id> accIds = new Set<Id>(); // initialize set

        for (Opportunity opp : triggerOld) { // get the account Ids for each opp
            accIds.add(opp.AccountId);
        }
        
        Map<Id, Account> idToAccount = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accIds]); // map each id to their account to reference later. Must include 'Industry' in query if going to reference later

        for (Opportunity opp : triggerOld) {
            if (opp.StageName == 'Closed Won' && idToAccount.get(opp.AccountId).Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }

    // QUESTION 7
    public static void getTheCEOs(List<Opportunity> triggerNew) {
        Set<Id> accIds = new Set<Id>(); // initialize set

        for (Opportunity opp : triggerNew) { // get the account Ids for each opp
            accIds.add(opp.AccountId);
        }

        List<Contact> findTheCEOs = [SELECT Id, AccountId FROM Contact WHERE AccountID IN :accIds AND Title = 'CEO']; // get a list of the contacts with CEO in title that are associated with the accounts related to the updated opportunities
        
        for (Opportunity opp : triggerNew) {
            for (Contact con : findTheCEOs) {
                if (opp.AccountId == con.AccountId) {
                    opp.Primary_Contact__c = con.Id; // if the opportunity and the contact are related to the same account, set that contact as the primary contact on the opp
                }
            }
        }
    }

}