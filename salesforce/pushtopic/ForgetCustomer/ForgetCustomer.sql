SELECT Id,
       ExternalId__c,
       PersonEmail,
       Brand__pc,
       CRM_Status__pc,
       ForgottenAt__pc,
       LastModifiedById,
       LastModifiedDate
FROM Account
WHERE CRM_Status__pc = 'Forgotten'
  AND PersonEmail != null
  AND (LastModifiedById != '0052p000009Ka2zAAC' AND LastModifiedById != '0052p000009GcLbAAK')
