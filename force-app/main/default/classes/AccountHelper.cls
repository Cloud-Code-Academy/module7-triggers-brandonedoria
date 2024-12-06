public with sharing class AccountHelper {
    
// helper class helps avoid complex logic in triggers

    // QUESTION 1
    public static void prospector(List<Account> triggerNew) { // Trigger.new takes in a list that holds the new versions of the records during an insert or update operation
        for (Account acc : triggerNew) {
            if (acc.Type == null) {
                acc.Type = 'Prospect'; // if Account type is null, change type to Prospect
            }
        }
    }

    // QUESTION 2
    public static void shipToBill(List<Account> triggerNew) {
        for (Account acc : triggerNew) {
                acc.BillingStreet = acc.ShippingStreet ?? null; // binary operator in the form 'a ?? b' that returns 'a' if 'a' isn’t null, and otherwise returns 'b'
                acc.BillingCity = acc.ShippingCity ?? null; // if not null, copy shipping to billing
                acc.BillingState = acc.ShippingState ?? null;
                acc.BillingPostalCode = acc.ShippingPostalCode ?? null;
                acc.BillingCountry = acc.ShippingCountry ?? null;
        }
    }

    // QUESTION 3
    public static void hotInHere(List<Account> triggerNew) {
        for (Account acc : triggerNew) {
            if (acc.Phone != null && acc.Website != null && acc.Fax != null) { // if all have a value, change rating to hot
                acc.Rating = 'Hot';
            }
        }
    }

    // QUESTION 4
    public static void defaultInOurStars(List<Account> triggerNew) {
        List<Contact> contactsToInsert = new List<Contact>();
        for (Account acc : triggerNew) {
            Contact newContact = new Contact(AccountId = acc.Id, LastName = 'DefaultContact', Email = 'default@email.com'); // when an account is created, create a new contact associated with that account
            contactsToInsert.add(newContact);
        }
        insert contactsToInsert;
    }

}