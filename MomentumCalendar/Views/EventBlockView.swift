//
//  EventBlockView.swift
//  MomentumCalendar
//
//  Displays a single event as a colored time block
//

import SwiftUI

struct EventBlockView: View {
    let event: Event
    let hourHeight: CGFloat = 60

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(event.title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(2)

            Text(event.startTime.timeString())
                .font(.system(size: 9))
                .foregroundColor(.white.opacity(0.9))

            Text(event.formattedDuration)
                .font(.system(size: 9))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: calculateHeight())
        .background(event.eventType.color)
        .cornerRadius(6)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }

    private func calculateHeight() -> CGFloat {
        let hours = CGFloat(event.durationMinutes) / 60.0
        return hours * hourHeight
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 10) {
        EventBlockView(event: Event(
            id: UUID(),
            title: "Upper Body Workout",
            startTime: Date(),
            durationMinutes: 60,
            eventType: .workout,
            energyLevel: .high,
            alarmSettings: nil,
            notes: nil
        ))

        EventBlockView(event: Event(
            id: UUID(),
            title: "Deep Study - Data Structures",
            startTime: Date(),
            durationMinutes: 120,
            eventType: .study,
            energyLevel: .high,
            alarmSettings: nil,
            notes: nil
        ))

        EventBlockView(event: Event(
            id: UUID(),
            title: "Buffer Time",
            startTime: Date(),
            durationMinutes: 30,
            eventType: .buffer,
            energyLevel: .rest,
            alarmSettings: nil,
            notes: nil
        ))
    }
    .padding()
    .frame(width: 200)
}
