//
//  DayColumnView.swift
//  MomentumCalendar
//
//  Displays events for a single day as a vertical timeline
//

import SwiftUI

struct DayColumnView: View {
    let day: Date
    let events: [Event]

    let startHour = 6    // 6 AM
    let endHour = 23     // 11 PM
    let hourHeight: CGFloat = 60

    var body: some View {
        VStack(spacing: 0) {
            // Day header
            Text(day.dayAbbreviation())
                .font(.headline)
                .frame(height: 30)

            // Timeline with events
            ZStack(alignment: .topLeading) {
                // Background grid (hour lines)
                VStack(spacing: 0) {
                    ForEach(startHour...endHour, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, hourHeight / 2)
                    }
                }

                // Events positioned by time
                ForEach(events) { event in
                    EventBlockView(event: event)
                        .offset(y: calculateOffset(for: event))
                        .padding(.horizontal, 4)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
    }

    /// Calculate vertical offset based on event start time
    private func calculateOffset(for event: Event) -> CGFloat {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: event.startTime)
        let minute = calendar.component(.minute, from: event.startTime)

        let hoursFromStart = CGFloat(hour - startHour)
        let minuteFraction = CGFloat(minute) / 60.0

        return (hoursFromStart + minuteFraction) * hourHeight
    }
}

// MARK: - Preview
#Preview {
    let sampleEvents = [
        Event(
            id: UUID(),
            title: "Morning Workout",
            startTime: Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: Date())!,
            durationMinutes: 60,
            eventType: .workout,
            energyLevel: .high,
            alarmSettings: nil,
            notes: nil
        ),
        Event(
            id: UUID(),
            title: "Study Block",
            startTime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!,
            durationMinutes: 120,
            eventType: .study,
            energyLevel: .high,
            alarmSettings: nil,
            notes: nil
        ),
        Event(
            id: UUID(),
            title: "Buffer",
            startTime: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date())!,
            durationMinutes: 30,
            eventType: .buffer,
            energyLevel: .rest,
            alarmSettings: nil,
            notes: nil
        )
    ]

    return DayColumnView(day: Date(), events: sampleEvents)
        .frame(width: 150, height: 600)
        .padding()
}
