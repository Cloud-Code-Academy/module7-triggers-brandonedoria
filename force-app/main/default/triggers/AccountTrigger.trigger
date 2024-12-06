trigger AccountTrigger on Account (before insert, after insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        AccountHelper.prospector(Trigger.new); // QUESTION 1 // Trigger.new because we want the newly updated records
        AccountHelper.shipToBill(Trigger.new); // QUESTION 2
        AccountHelper.hotInHere(Trigger.new); // QUESTION 3
    }

    if (Trigger.isAfter && Trigger.isInsert) { // after insert because we want the account created first before create the contact so we can associate the two
        AccountHelper.defaultInOurStars(Trigger.new); // QUESTION 4
    }

}