# BookingStatusUpdates
SELECT Id,
       bookingId__c,
       salesforceBookingStatus__c,
       Brand_Api_Name__c,
       LastModifiedById,
       LastModifiedDate
FROM Booking__c
WHERE (LastModifiedById != '0052p000009Ka2zAAC' AND LastModifiedById != '0052p000009GcLbAAK')
