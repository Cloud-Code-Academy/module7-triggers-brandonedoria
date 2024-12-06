trigger OpportunityTrigger on Opportunity (before update, before delete) {

    if (Trigger.isBefore && Trigger.isUpdate) { // before update because like adding a validation rule
        OpportunityHelper.overFiveGs(Trigger.new); // QUESTION 5
        OpportunityHelper.getTheCEOs(Trigger.new); // QUESTION 7
    }

    if (Trigger.isBefore && Trigger.isDelete) {
        OpportunityHelper.betterNotDelete(Trigger.old); // QUESTION 6 // Trigger.old because we want to take in the record values that haven't been updated yet
    }
    
}