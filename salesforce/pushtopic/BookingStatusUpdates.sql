# BookingStatusUpdates
SELECT Id,
       bookingId__c,
       salesforceBookingStatus__c,
       Distribution_Site__r.brandApiName__c,
       LastModifiedBy.Id,
       LastModifiedBy.email,
       LastModifiedDate
FROM Booking__c
WHERE (LastModifiedById != '0052p000009Ka2zAAC' AND LastModifiedById != '0052p000009GcLbAAK')
