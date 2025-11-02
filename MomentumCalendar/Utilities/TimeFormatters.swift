//
//  TimeFormatters.swift
//  MomentumCalendar
//
//  🎓 LEARNING PIECE #2 - YOU'LL COMPLETE THIS
//  Estimated time: 10-15 minutes
//

import Foundation

// MARK: - Your Tasks

/*
 TASK 1: Complete the timeString function

 WHAT YOU'LL LEARN:
 - Swift DateFormatter
 - Date extensions
 - String formatting

 GOAL: Format a Date as "6:00 AM" or "11:30 PM"
 */

extension Date {
    /// Formats time as "6:00 AM" or "2:30 PM"
    func timeString() -> String {
        let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
}

/*
 TASK 2: Complete the durationString function

 WHAT YOU'LL LEARN:
 - Basic Swift math and logic
 - String interpolation
 - Conditional formatting

 GOAL: Format minutes as:
 - "1h 30m" for 90 minutes
 - "2h" for 120 minutes
 - "45m" for 45 minutes

 EXAMPLE:
 durationString(minutes: 90) → "1h 30m"
 durationString(minutes: 120) → "2h"
 durationString(minutes: 45) → "45m"
 */

/// Formats duration in minutes as "1h 30m" or "45m"
func durationString(minutes: Int) -> String {
    // TODO: Calculate hours and remaining minutes
    // Hint: let hours = minutes / 60
    // Hint: let remainingMinutes = minutes % 60 (% is modulo - gives remainder)

    // TODO: Return formatted string based on conditions:
    // If hours > 0 AND remainingMinutes > 0: return "\(hours)h \(remainingMinutes)m"
    // If hours > 0 AND remainingMinutes == 0: return "\(hours)h"
    // Otherwise: return "\(minutes)m"

    return "TODO"  // Replace this with your code
}

/*
 TASK 3 (Optional Bonus): Day of week formatter

 GOAL: Format Date as "Mon", "Tue", etc.
 */

extension Date {
    /// Formats date as abbreviated day name "Mon", "Tue", etc.
    func dayAbbreviation() -> String {
        // TODO (Optional): Create a DateFormatter with dateFormat = "EEE"
        // This is optional - if you don't complete it, I have a fallback

        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
}

// MARK: - Testing (you can use this to test your functions)
/*
 To test your functions, you can add print statements in your code:

 let testDate = Date()
 print(testDate.timeString())  // Should print current time like "10:30 AM"

 print(durationString(minutes: 90))   // Should print "1h 30m"
 print(durationString(minutes: 120))  // Should print "2h"
 print(durationString(minutes: 45))   // Should print "45m"
 */
