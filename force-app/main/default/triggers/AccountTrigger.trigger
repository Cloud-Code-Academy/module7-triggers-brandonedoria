trigger AccountTrigger on Account (before insert, after insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        AccountHelper.changeTypeToProspect(Trigger.new); // QUESTION 1
        AccountHelper.copyShippingToBilling(Trigger.new); // QUESTION 2
        AccountHelper.hotInHere(Trigger.new); // QUESTION 3
    }

    if (Trigger.isAfter && Trigger.isInsert) {
        AccountHelper.createAccount(Trigger.new); // QUESTION 4
    }

}