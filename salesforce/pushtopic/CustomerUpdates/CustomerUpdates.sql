SELECT Id,
       ExternalId__c,
       FirstName,
       LastName,
       Gender__pc,
       PersonEmail,
       Phone,
       PersonMailingCountry,
       PersonMailingCity,
       PersonMailingStreet,
       PersonMailingPostalCode,
       LinkToSubscriptionManagement__pc,
       CurrencyIsoCode,
       Locale__pc,
       Market__pc,
       Brand__pc,
       ForgottenAt__pc,
       LastModifiedById
FROM Account
WHERE PersonEmail != null
  AND ((LastModifiedById != '0052p000009Ka2zAAC' AND LastModifiedById != '0052p000009GcLbAAK') OR ExternalId__c = null)
