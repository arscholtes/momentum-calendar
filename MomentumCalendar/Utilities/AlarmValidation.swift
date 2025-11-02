//
//  AlarmValidation.swift
//  MomentumCalendar
//
//  🎓 LEARNING PIECE #3 - YOU'LL COMPLETE THIS
//  Estimated time: 10 minutes
//

import Foundation

// MARK: - Your Task

/*
 Complete the validation functions below.

 WHAT YOU'LL LEARN:
 - Swift optionals and guard statements
 - Validation patterns
 - Preventing bad data from reaching your API

 WHY THIS MATTERS:
 These functions prevent invalid alarm settings from being sent to your alarm API.
 Better to catch errors early than to debug weird API failures!
 */

extension AlarmSettings {
    /// Validates that alarm settings are correct before sending to API
    func isValid() -> Bool {
        // TODO: Check if triggerMinutesBefore is in valid range (5 to 120 minutes)
        // Hint: Use AlarmSettings.validMinuteRange.contains(triggerMinutesBefore)

        // TODO: Check if notificationType is one of the valid types
        // Hint: Use AlarmSettings.validNotificationTypes.contains(notificationType)

        // TODO: Return true only if BOTH checks pass

        return false  // Replace this with your validation logic
    }

    /// Returns a user-friendly error message if invalid
    func validationError() -> String? {
        // TODO: Check minutes range first
        // if !AlarmSettings.validMinuteRange.contains(triggerMinutesBefore) {
        //     return "Alarm time must be between 5 and 120 minutes before event"
        // }

        // TODO: Check notification type
        // if !AlarmSettings.validNotificationTypes.contains(notificationType) {
        //     return "Invalid notification type: \(notificationType)"
        // }

        // If everything is valid, return nil (no error)
        return nil  // Modify this based on your checks above
    }
}

/*
 BONUS CHALLENGE (optional):
 Add a static function that filters an array of events, keeping only those with valid alarms:

 static func eventsWithValidAlarms(_ events: [Event]) -> [Event] {
     // Filter events that have alarm settings AND those settings are valid
 }
 */

// MARK: - Testing
/*
 Test cases you can use:

 // Valid alarm
 let valid = AlarmSettings(triggerMinutesBefore: 15, notificationType: "gentle")
 print(valid.isValid())  // Should be true
 print(valid.validationError())  // Should be nil

 // Invalid - too short
 let tooShort = AlarmSettings(triggerMinutesBefore: 2, notificationType: "gentle")
 print(tooShort.isValid())  // Should be false
 print(tooShort.validationError())  // Should show error message

 // Invalid - bad type
 let badType = AlarmSettings(triggerMinutesBefore: 15, notificationType: "super-loud")
 print(badType.isValid())  // Should be false
 print(badType.validationError())  // Should show error message
 */
