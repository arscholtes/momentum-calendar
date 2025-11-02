//
//  SampleData.swift
//  MomentumCalendar
//
//  🎓 LEARNING PIECE #4 - YOU'LL COMPLETE THIS
//  Estimated time: 10-15 minutes
//

import Foundation

// MARK: - Your Task

/*
 Create a sample Week that matches YOUR actual protocols.

 WHAT YOU'LL LEARN:
 - Creating Swift Date objects
 - Building arrays of complex objects
 - Working with your own data model
 - UUID generation

 WHY THIS MATTERS:
 This lets you test the app immediately without waiting for the agent to generate files.
 You can see your actual schedule displayed in the calendar!
 */

struct SampleData {
    /// Generates a realistic week based on Alex's protocols
    static func generateSampleWeek() -> Week {
        // TODO: Create start date for the week (next Monday)
        // Hint: let calendar = Calendar.current
        // let today = Date()
        // Find next Monday or use a specific date

        let calendar = Calendar.current
        let startDate = Date()  // TODO: Change to next Monday at midnight

        // TODO: Create sample events array
        var events: [Event] = []

        // EXAMPLE EVENT (already done for you):
        // Friday Gaming Session
        if let fridayMorning = calendar.date(byAdding: .day, value: 4, to: startDate) {
            let gaming = Event(
                id: UUID(),
                title: "Friday Gaming Session",
                startTime: calendar.date(bySettingHour: 6, minute: 0, second: 0, of: fridayMorning)!,
                durationMinutes: 50,
                eventType: .recovery,
                energyLevel: .low,
                alarmSettings: AlarmSettings(triggerMinutesBefore: 5, notificationType: "gentle"),
                notes: "Weekly BDNF recovery protocol"
            )
            events.append(gaming)
        }

        // TODO: Add more events! Here are ideas based on your protocols:
        // - Monday: Upper body workout at 1pm (60 min)
        // - Monday: Deep study 2:30pm-4:30pm (120 min) - post-workout BDNF peak
        // - Monday: CFA shift 11:30am-2pm (150 min)
        // - Tuesday: Running session 1pm (45 min)
        // - Wednesday: Lower body workout
        // - Buffer times between high-energy events (15-30 min)

        // HINT: Use the same pattern as the gaming event above
        // Change the day offset, time, duration, and eventType

        // TODO: Add at least 3-5 more events to make the week realistic

        // Create the Week object
        let endDate = calendar.date(byAdding: .day, value: 7, to: startDate)!

        return Week(
            version: "1.0",
            weekStartDate: startDate,
            weekEndDate: endDate,
            generatedAt: Date(),
            events: events
        )
    }
}

/*
 BONUS CHALLENGE (optional):
 Create a function that generates a random color-coded test week:

 static func generateTestWeekAllTypes() -> Week {
     // Create one event of each EventType to test all colors
 }
 */

// MARK: - Helper Extension
extension Calendar {
    /// Helper to find next occurrence of a weekday
    func nextWeekday(_ weekday: Int, after date: Date = Date()) -> Date? {
        // TODO (Optional): Implement this if you want
        // weekday: 1=Sunday, 2=Monday, etc.
        return date
    }
}
