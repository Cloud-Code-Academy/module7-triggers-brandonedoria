trigger OpportunityTrigger on Opportunity (before update, before delete) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        OpportunityHelper.over5000(Trigger.new); // QUESTION 5
        OpportunityHelper.getTheCEO(Trigger.new); // QUESTION 7
    }

    if (Trigger.isBefore && Trigger.isDelete) {
        OpportunityHelper.betterNotDelete(Trigger.old); // QUESTION 6
    }
    
}