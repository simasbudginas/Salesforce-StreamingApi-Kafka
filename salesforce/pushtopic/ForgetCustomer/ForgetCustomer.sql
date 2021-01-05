SELECT Id,
       ExternalId__c,
       PersonEmail,
       Brand__pc,
       CRM_Status__pc,
       LastModifiedById,
       LastModifiedDate
FROM Account
WHERE CRM_Status__pc = 'Forgotten'
  AND PersonEmail != null
  AND ExternalId__c != null
