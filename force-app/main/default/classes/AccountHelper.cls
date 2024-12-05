public with sharing class AccountHelper {
    
    // QUESTION 1
    public static void changeTypeToProspect(List<Account> typeProspect) {
        for (Account acc : typeProspect) {
            if (acc.Type == null) {
                acc.Type = 'Prospect';
            }
        }
    }

    // QUESTION 2
    public static void copyShippingToBilling(List<Account> shipToBill) {
        for (Account acc : shipToBill) {
                acc.BillingStreet = acc.ShippingStreet ?? null;
                acc.BillingCity = acc.ShippingCity ?? null;
                acc.BillingState = acc.ShippingState ?? null;
                acc.BillingPostalCode = acc.ShippingPostalCode ?? null;
                acc.BillingCountry = acc.ShippingCountry ?? null;
        }
    }

    // QUESTION 3
    public static void hotInHere(List<Account> whoHotWhoNot) {
        for (Account acc : whoHotWhoNot) {
            if (acc.Phone != null && acc.Website != null && acc.Fax != null) {
                acc.Rating = 'Hot';
            }
        }
    }

    // QUESTION 4
    public static void createAccount(List<Account> accountsToInsert) {
        List<Contact> contactsToInsert = new List<Contact>();
        for (Account acc : accountsToInsert) {
            Contact newContact = new Contact(AccountId = acc.Id, LastName = 'DefaultContact', Email = 'default@email.com');
            contactsToInsert.add(newContact);
        }
        insert contactsToInsert;
    }
    
}